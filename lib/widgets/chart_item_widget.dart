import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/styles/colors.dart';

import 'item_counter_widget.dart';

class ChartItemWidget extends StatefulWidget {
  ChartItemWidget({Key? key, required this.item, required this.quantity})
      : super(key: key);
  final GroceryItem item;
  final int quantity;

  @override
  _ChartItemWidgetState createState() => _ChartItemWidgetState();
}

class _ChartItemWidgetState extends State<ChartItemWidget> {
  final double height = 110;

  final Color borderColor = Color(0xffE2E2E2);

  final double borderRadius = 18;

  late int amount;
  @override
  void initState() {
    amount = widget.quantity;
    super.initState();
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: widget.item.name,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  textOverflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5,
                ),
                AppText(
                    text: widget.item.description,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGrey),
                SizedBox(
                  height: 12,
                ),
                ItemCounterWidget(
                  onAmountChanged: (newAmount) {
                    setState(() {
                      amount = newAmount;
                    });
                  },
                  quantity: amount,
                  quantityLeft: 100,
                )
              ],
            ),
          ),
          Column(
            children: [
              Icon(
                Icons.close,
                color: AppColors.darkGrey,
                size: 25,
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
        widget.item.imagePath,
        fit: BoxFit.contain,
      ),
    );
  }

  double getPrice() {
    return widget.item.price * amount;
  }
}
