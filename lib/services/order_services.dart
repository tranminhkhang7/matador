import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:grocery_app/constants/constant.dart';
import 'package:grocery_app/helpers/snackbar.dart';
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
}
