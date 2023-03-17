import 'package:flutter/material.dart';
import 'package:grocery_app/models/order.dart';

class OrderListProvider extends ChangeNotifier {
  List<Order> _ordersProvider = [];

  List<Order> get ordersProvider => _ordersProvider;
  void setOrderList(List<Order> list) {
    _ordersProvider = list;
    notifyListeners();
  }

  void clear() {
    _ordersProvider = [];
    notifyListeners();
  }

  void addToOrderList(Order order) {
    _ordersProvider.add(order);
    notifyListeners();
  }
}
