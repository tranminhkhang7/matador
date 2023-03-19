import 'package:flutter/material.dart';
import 'package:grocery_app/constants/routes_constraints.dart';
import 'package:grocery_app/models/order.dart';
import 'package:grocery_app/providers/order_list_provider.dart';
import 'package:grocery_app/screens/order/widgets/order_widget.dart';
import 'package:grocery_app/services/order_services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order> orders = [];
  late Future<List<Order>> _futureOrders;
  final OrderServices orderServices = OrderServices();
  void navigateToOrderDetails(int orderId) {
    Navigator.pushNamed(
      context,
      RoutesHandler.ORDER_DETAILS,
      arguments: orderId,
    );
  }

  void fetchUserOrders() async {
    orders = await orderServices.fetchUserOrders(context);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserOrders();
    _futureOrders = orderServices.fetchUserOrders(context);
  }

  @override
  Widget build(BuildContext context) {
    //final orders = context.read<OrderListProvider>().ordersProvider;
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        elevation: 0,
      ),
      body: FutureBuilder<List<Order>>(
        future: _futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final ordersList = snapshot.data;
            return ListView.builder(
              itemCount: ordersList!.length,
              itemBuilder: (BuildContext context, int index) {
                final order = ordersList[index];
                return GestureDetector(
                  onTap: () => navigateToOrderDetails(order.id),
                  child: OrderWidget(
                    orderNumber: order.id.toString(),
                    orderDate: DateFormat('dd/MM/y h:mm a').format(order.time),
                    orderStatus: order.status,
                    orderTotal: order.totalAmount.toString(),
                    address: order.address,
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('Failed to fetch orders'),
            );
          }
        },
      ),
      // ListView.builder(
      //   itemCount: orders.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     final order = orders[index];
      //     return GestureDetector(
      //       onTap: () => navigateToOrderDetails(
      //         order.id,
      //       ),
      //       child: OrderWidget(
      //         orderNumber: order.id.toString(),
      //         //(index + 1).toString(),
      //         orderDate: DateFormat('dd/MM/y h:mm a').format(
      //           order.time,
      //         ),
      //         orderStatus: order.status,
      //         orderTotal: order.totalAmount.toString(),
      //         address: order.address,
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
