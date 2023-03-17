import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:grocery_app/constants/constant.dart';
import 'package:grocery_app/constants/routes_constraints.dart';
import 'package:grocery_app/helpers/http_handler.dart';
import 'package:grocery_app/helpers/snackbar.dart';
import 'package:grocery_app/models/account.dart';
import 'package:grocery_app/models/book_item.dart';
import 'package:grocery_app/models/customer.dart';
import 'package:grocery_app/models/order.dart';
import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/providers/favorite_list_provider.dart';
import 'package:grocery_app/providers/order_list_provider.dart';
import 'package:grocery_app/providers/user_provider.dart';
import 'package:grocery_app/services/cart_services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AuthService {
  Future<void> signUpUser(
      {required BuildContext context,
      required String email,
      required String password,
      required String name,
      String? address,
      required String gender,
      String? phone,
      DateTime? birthday}) async {
    try {
      Account account = Account(
        email: email,
        password: password,
        token: '',
        customer: Customer(
          address: address,
          birthday: null,
          gender: gender,
          name: name,
          phone: phone,
        ),
      );
      Customer customer = Customer(
        name: name,
        gender: gender,
        birthday: birthday,
        address: address,
        phone: phone,
      );
      String json = jsonEncode({
        'email': email,
        'password': password,
        'customerDetail': {
          'name': name,
          'gender': gender,
          'birthday': "2023-02-11T13:30:00Z",
          'address': address,
          'phone': phone
        }
      });
      log(jsonDecode(json).toString());
      http.Response res = await http.post(
        Uri.parse("$uriCuaKhoa/auth/signup"),
        body: json,
        // jsonEncode({
        //   'email': email,
        //   'password': password,
        //   'customerDetail': jsonEncode({
        //     'name': name,
        //     'gender': gender,
        //     'birthday': "2023-02-11T13:30:00Z",
        //     'address': address,
        //     'phone': phone
        //   })
        //   //customer.toJson(),
        // }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(
        const Duration(seconds: 5),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Account created, Please sign in');
        },
      );
    } on TimeoutException catch (_) {
      showSnackBar(context, "Timeout");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      //SharedPreferences preferences = await SharedPreferences.getInstance();
      if (email.isNotEmpty && password.isNotEmpty) {
        http.Response res = await http.post(
          Uri.parse("$uriCuaKhoa/auth/signin"),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            var data = json.decode(res.body) as Map<String, dynamic>;

            Account account = Account(
              email: email,
              password: password,
              token: data['token'],
              customer: Customer.fromMap(data['customerDetail']),
              // birthDate: DateTime.parse(data['customerDetail']['birthday']),
              // gender: data['customerDetail']['gender'],
              // name: data['customerDetail']['name'],
              // address: data['customerDetail']['address'],
              // phone: data['customerDetail']['phone'],
            );

            //favList
            var favBooksProvider =
                Provider.of<FavoriteListProvider>(context, listen: false);
            favBooksProvider.setFavoriteList(
              await fetchFavoriteBooks(context, account.token),
            );

            //orderList
            var orderProvider =
                Provider.of<OrderListProvider>(context, listen: false);
            orderProvider.setOrderList(
              await fetchUserOrders(context, account.token),
            );

            //cart
            var cartProvider =
                Provider.of<CartProvider>(context, listen: false);
            cartProvider.setCartItemList(
              await CartServices().getCart(context, account.token),
            );
            //user
            var userProvider =
                Provider.of<UserProvider>(context, listen: false);
            userProvider.setUserFromModel(account);
          },
        );
      }
    } on TimeoutException catch (_) {
      showSnackBar(context, "Timeout");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<BookItem>> fetchFavoriteBooks(
      BuildContext context, String token) async {
    List<BookItem> favoriteList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uriCuaKhoa/favourite/retrieve'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            favoriteList.add(
              BookItem.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      rethrow;
    }
    return favoriteList;
  }

  Future<List<Order>> fetchUserOrders(
      BuildContext context, String token) async {
    List<Order> orderList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uriCuaKhoa/order/get'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
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

  Future<void> logout(BuildContext context) async {
    Provider.of<UserProvider>(context, listen: false).clear();
    Provider.of<FavoriteListProvider>(context, listen: false).clear();
    Provider.of<OrderListProvider>(context, listen: false).clear();
    Provider.of<CartProvider>(context, listen: false).clear();
  }

  // Future<void> getUserData({
  //   required BuildContext context,
  // }) async {
  //   try {
  //     // SharedPreferences prefs = await SharedPreferences.getInstance();
  //     // String? token = prefs.getString('Authorization');

  //     //log(response);

  //     http.Response userResponse = await http.get(
  //       Uri.parse('https://8b6c-171-252-155-251.ap.ngrok.io/'),
  //       headers: <String, String>{
  //         "Content-Type": "application/json; charset=UTF-8",
  //         "x-auth-token": ''
  //       },
  //     ).timeout(
  //       const Duration(
  //         seconds: 10,
  //       ),
  //     );

  //     var userProvider = Provider.of<UserProvider>(context, listen: false);
  //     userProvider.setUser(userResponse.body);
  //   } on TimeoutException catch (_) {
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  // }
}
