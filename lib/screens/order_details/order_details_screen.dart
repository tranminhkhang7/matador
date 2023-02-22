import 'package:flutter/material.dart';
import 'package:grocery_app/models/order_detail.dart';
import 'package:grocery_app/services/order_services.dart';
import 'package:grocery_app/widgets/loader.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int orderId;
  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  OrderServices orderServices = OrderServices();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
      ),
      body: Builder(
        builder: (context) {
          return FutureBuilder(
            future: orderServices.getOrderDetails(
              context,
              widget.orderId,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!.isNotEmpty
                    ? ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          OrderDetail orderDetail = snapshot.data![index];
                          return Container(
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    orderDetail.price.toString(),
                                  ),
                                  Text(
                                    orderDetail.quantity.toString(),
                                  ),
                                  Text(
                                    orderDetail.book.title,
                                  ),
                                  Text(
                                    orderDetail.book.author,
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                    : Container(
                        child: Center(child: const Text('No data')),
                      );
              } else {
                return const Loader();
              }
            },
          );
        },
      ),
    );
  }
}
