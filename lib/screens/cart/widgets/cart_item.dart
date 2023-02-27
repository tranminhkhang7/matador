import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/cart.dart';
import 'package:grocery_app/services/cart_services.dart';

import 'package:grocery_app/styles/colors.dart';
import 'package:grocery_app/widgets/item_counter_widget.dart';

class CartItemWidget extends StatefulWidget {
  CartItemWidget({Key? key, required this.item, required this.quantity})
      : super(key: key);
  final Cart item;
  final int quantity;

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  final double height = 110;

  final Color borderColor = Color(0xffE2E2E2);

  final double borderRadius = 18;

  late int amount;
  final CartServices cartServices = CartServices();
  @override
  void initState() {
    amount = widget.quantity;
    super.initState();
  }

  void addToCart(int bookId, int quantity) async {
    await cartServices.addToCart(context, bookId, quantity);
  }

  void removeFromCart(int bookId, int quantity) async {
    await cartServices.removeFromCart(context, bookId, quantity);
  }

  void removeAnItemFromCart(int bookId) async {
    await cartServices.removeAnItemFromCart(context, bookId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          imageWidget(),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: widget.item.bookDTO.title,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  textOverflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5,
                ),
                AppText(
                    text: widget.item.bookDTO.description,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGrey),
                SizedBox(
                  height: 12,
                ),
                ItemCounterWidget(
                  onAmountChanged: (newAmount) {
                    newAmount > amount
                        ? addToCart(widget.item.bookDTO.bookId, 1)
                        : removeFromCart(widget.item.bookDTO.bookId, 1);
                    setState(() {
                      amount = newAmount;
                    });
                  },
                  quantity: amount,
                  quantityLeft:
                      int.parse(widget.item.bookDTO.quantityLeft.toString()),
                )
              ],
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Remove from cart'),
                    content: Text(
                        'Remove ${widget.item.bookDTO.title} with amount of $amount from cart '),
                    actions: [
                      ElevatedButton(
                        onPressed: () =>
                            Navigator.pop(context), // Closes the dialog
                        child: Text('No'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Changes the tab
                          removeAnItemFromCart(widget.item.bookDTO.bookId);
                          Navigator.pop(context); // Closes the dialog
                        },
                        child: Text('Yes'),
                      ),
                    ],
                  ),
                ),
                child: Icon(
                  Icons.close,
                  color: AppColors.darkGrey,
                  size: 25,
                ),
              ),
              Spacer(
                flex: 5,
              ),
              Container(
                width: 70,
                child: AppText(
                  text: "\$${getPrice().toStringAsFixed(2)}",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.right,
                ),
              ),
              Spacer(),
            ],
          )
        ],
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      width: 75,
      child: Image.network(
        widget.item.bookDTO.imageLink,
        fit: BoxFit.contain,
      ),
    );
  }

  double getPrice() {
    return widget.item.bookDTO.price * amount;
  }
}
