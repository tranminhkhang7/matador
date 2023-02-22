import 'package:flutter/material.dart';
import 'package:grocery_app/constants/routes_constraints.dart';
import 'package:grocery_app/providers/order_list_provider.dart';
import 'package:grocery_app/screens/order/widgets/order_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  void navigateToOrderDetails(int orderId) {
    Navigator.pushNamed(
      context,
      RoutesHandler.ORDER_DETAILS,
      arguments: orderId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final orders = context.read<OrderListProvider>().ordersProvider;
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          final order = orders[index];
          return GestureDetector(
            onTap: () => navigateToOrderDetails(
              order.id,
            ),
            child: OrderWidget(
              orderNumber: order.id.toString(),
              //(index + 1).toString(),
              orderDate: DateFormat('dd/MM/y h:mm a').format(
                order.time,
              ),
              orderStatus: order.status,
              orderTotal: order.totalAmount.toString(),
              address: order.address,
            ),
          );
        },
      ),
    );
  }
}
