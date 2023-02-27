import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/constant.dart';
import 'package:grocery_app/helpers/http_handler.dart';
import 'package:grocery_app/helpers/snackbar.dart';
import 'package:grocery_app/models/cart.dart';
import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/providers/user_provider.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CartServices {
  Future<List<Cart>> getCart(BuildContext context, String token) async {
    List<Cart> carts = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uriCuaKhoa/cart/retrieve'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            carts.add(
              Cart.fromMap(
                jsonDecode(res.body)[i],
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return carts;
  }

  Future<void> addToCart(BuildContext context, int bookId, int quantity) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http
          .post(Uri.parse('$uriCuaKhoa/cart/add/$bookId/$quantity'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${userProvider.account.token}',
      });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          List<Cart> newCartList = [];
          final cartProvider =
              Provider.of<CartProvider>(context, listen: false);
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            newCartList.add(
              Cart.fromMap(
                jsonDecode(res.body)[i],
              ),
            );
          }
          cartProvider.setCartItemList(newCartList);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> removeFromCart(
      BuildContext context, int bookId, int quantity) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http
          .delete(Uri.parse('$uriCuaKhoa/cart/$bookId/$quantity'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${userProvider.account.token}',
      });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          List<Cart> newCartList = [];
          final cartProvider =
              Provider.of<CartProvider>(context, listen: false);
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            newCartList.add(
              Cart.fromMap(
                jsonDecode(res.body)[i],
              ),
            );
          }
          cartProvider.setCartItemList(newCartList);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> removeAnItemFromCart(BuildContext context, int bookId) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http
          .delete(Uri.parse('$uriCuaKhoa/cart/item/$bookId'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${userProvider.account.token}',
      });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          List<Cart> newCartList = [];
          final cartProvider =
              Provider.of<CartProvider>(context, listen: false);
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            newCartList.add(
              Cart.fromMap(
                jsonDecode(res.body)[i],
              ),
            );
          }
          cartProvider.setCartItemList(newCartList);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
