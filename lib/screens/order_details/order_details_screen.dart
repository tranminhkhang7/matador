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
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          orderDetail.book.imageLink),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        orderDetail.book.title,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Author: ${orderDetail.book.author}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Price: ${orderDetail.price}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                          // Container(
                          //   child: Center(
                          //     child: Column(
                          //       children: [
                          //         Text(
                          //           orderDetail.price.toString(),
                          //         ),
                          //         Text(
                          //           orderDetail.quantity.toString(),
                          //         ),
                          //         Text(
                          //           orderDetail.book.title,
                          //         ),
                          //         Text(
                          //           orderDetail.book.author,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // );
                        },
                      )
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
