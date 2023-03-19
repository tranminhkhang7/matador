import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:grocery_app/constants/constant.dart';
import 'package:grocery_app/helpers/snackbar.dart';
import 'package:grocery_app/models/order.dart';
import 'package:grocery_app/models/order_detail.dart';
import 'package:grocery_app/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OrderServices {
  Future<List<OrderDetail>> getOrderDetails(
      BuildContext context, int orderId) async {
    List<OrderDetail> orderDetails = [];
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res =
          await http.get(Uri.parse('$uriCuaKhoa/order/get/$orderId'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${userProvider.account.token}"
      });
      for (int i = 0; i < jsonDecode(res.body).length; i++) {
        orderDetails.add(
          OrderDetail.fromMap(
            jsonDecode(res.body)[i],
          ),
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderDetails;
  }

  Future<List<Order>> fetchUserOrders(BuildContext context) async {
    List<Order> orderList = [];
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res =
          await http.get(Uri.parse('$uriCuaKhoa/order/get'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${userProvider.account.token}"
      });

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          orderList.add(
            Order.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }
      }
    } catch (e) {
      rethrow;
    }
    return orderList;
  }
}
