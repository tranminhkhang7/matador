import 'package:flutter/material.dart';

class OrderWidget extends StatelessWidget {
  final String orderNumber;
  final String orderDate;
  final String orderStatus;
  final String orderTotal;
  final String address;
  final VoidCallback? onTap;

  const OrderWidget({
    Key? key,
    required this.orderNumber,
    required this.orderDate,
    required this.orderStatus,
    required this.orderTotal,
    this.onTap,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order # $orderNumber',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(orderDate),
                    SizedBox(height: 8.0),
                    Text(
                      address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      orderStatus,
                      style: TextStyle(
                        color: orderStatus == 'Delivered'
                            ? Colors.green
                            : Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '\$$orderTotal',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
