import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/common_widgets/app_textfield.dart';
import 'package:grocery_app/helpers/column_with_seprator.dart';
import 'package:grocery_app/helpers/snackbar.dart';

import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/providers/user_provider.dart';
import 'package:grocery_app/screens/cart/widgets/cart_item.dart';
import 'package:grocery_app/services/cart_services.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:pay/pay.dart';

import 'package:provider/provider.dart';

import 'checkout_bottom_sheet.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final Future<PaymentConfiguration> _gpayConfig =
      PaymentConfiguration.fromAsset("gpay.json");
  List<PaymentItem> paymentItems = [];
  final CartServices cartServices = CartServices();
  final _cartFormKey = GlobalKey<FormState>();
  String addressToBeUsed = "";
  String phoneToBeUsed = "";
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>().cartFavoriteList;
    double sum = 0;

    cartProvider.forEach(
      ((element) => sum += element.quantity * element.bookDTO.price),
    );

    paymentItems.add(
      PaymentItem(
          amount: sum.toString(),
          label: 'Total amount',
          status: PaymentItemStatus.final_price),
    );
    final userProvider = Provider.of<UserProvider>(context).account;
    return userProvider.token.isEmpty
        ? Center(
            child: AppText(
              text: "Go back to login",
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          )
        : Scaffold(
            body: cartProvider.isEmpty
                ? Center(
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: "Cart is empty",
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF7C7C7C),
                          ),
                          AppText(
                            text: "Get your self some books ->",
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF7C7C7C),
                          ),
                        ],
                      ),
                    ),
                  )
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "My Cart | \$$sum",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          if (userProvider.customer.address == null ||
                              userProvider.customer.address!.isEmpty)
                            Form(
                              key: _cartFormKey,
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    AppTextField(
                                      controller: _addressController,
                                      hintText: 'Address',
                                      isObscure: false,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    if (userProvider.customer.phone == null ||
                                        userProvider.customer.phone!.isEmpty)
                                      AppTextField(
                                        controller: _phoneController,
                                        hintText: 'Phone',
                                        isObscure: false,
                                      ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          Column(
                            children: getChildrenWithSeperator(
                              addToLastChild: false,
                              widgets: cartProvider.map((e) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 25,
                                  ),
                                  width: double.maxFinite,
                                  child: CartItemWidget(
                                    item: e,
                                    quantity: e.quantity,
                                  ),
                                );
                              }).toList(),
                              seperator: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                ),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          getCheckoutButton(
                            context,
                            sum,
                            userProvider.customer.address ?? "",
                            userProvider.customer.phone ?? "",
                          )
                        ],
                      ),
                    ),
                  ),
          );
  }

  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
    cartServices.payment(
        context: context, address: addressToBeUsed, phone: phoneToBeUsed);
  }

  void payPressed(String addressFromProvider, String phoneFromProvider) {
    addressToBeUsed = "";
    bool isForm =
        _addressController.text.isNotEmpty || _phoneController.text.isNotEmpty;

    if (isForm) {
      if (_cartFormKey.currentState!.validate()) {
        addressToBeUsed = _addressController.text;
        phoneToBeUsed = _phoneController.text;
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
      phoneToBeUsed = phoneFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
    log(addressToBeUsed);
  }

  Widget getCheckoutButton(BuildContext context, double totalPrice,
      String addressFromProvider, String phoneFromProvider) {
    return FutureBuilder(
      future: _gpayConfig,
      builder: (context, snapshot) => snapshot.hasData
          ? GooglePayButton(
              onPressed: () =>
                  payPressed(addressFromProvider, phoneFromProvider),
              paymentConfiguration: snapshot.data!,
              paymentItems: paymentItems,
              type: GooglePayButtonType.buy,
              margin: const EdgeInsets.only(
                top: 15.0,
              ),
              onPaymentResult: onGooglePayResult,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget getButtonPriceWidget(double totalPrice) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Color(0xff489E67),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        "\$${totalPrice.toStringAsFixed(2)}",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  void showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return CheckoutBottomSheet();
        });
  }
}
