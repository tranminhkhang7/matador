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
import 'package:grocery_app/models/order.dart';
import 'package:grocery_app/providers/favorite_list_providers.dart';
import 'package:grocery_app/providers/order_list_provider.dart';
import 'package:grocery_app/providers/search_list_provider.dart';
import 'package:grocery_app/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      // Account account = Account(
      //   email: email,
      //   password: password,
      //   token: '',
      //   birthDate: null,
      //   gender: '',
      //   name: '',
      // );
      http.Response res = await http.post(
        Uri.parse("$uriCuaKhoa/auth/signup"),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
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
        ).timeout(
          const Duration(seconds: 5),
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
              birthDate: DateTime.parse(data['customerDetail']['birthday']),
              gender: data['customerDetail']['gender'],
              name: data['customerDetail']['name'],
            );

            //user
            var userProvider =
                Provider.of<UserProvider>(context, listen: false);
            userProvider.setUserFromModel(account);

            //favList
            var favBooksProvider =
                Provider.of<FavoriteListProvider>(context, listen: false);
            favBooksProvider.setFavoriteList(
              await fetchFavoriteBooks(context, account.email, account.token),
            );

            //orderList
            var orderProvider =
                Provider.of<OrderListProvider>(context, listen: false);
            orderProvider.setOrderList(
              await fetchUserOrders(context, account.token),
            );
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
      BuildContext context, String email, String token) async {
    List<BookItem> favoriteList = [];
    try {
      favoriteList.add(
        BookItem(
          bookId: 1,
          author: 'Khoa',
          description: 'des',
          imageLink:
              'https://www.google.com/photos/about/static/images/ui/logo-photos.png',
          price: 3,
          publisher: 'Khoa',
          quantityLeft: '10',
          status: 'available',
          title: 'Book Test 1',
        ),
      );
      favoriteList.add(
        BookItem(
          bookId: 2,
          author: 'Khoa',
          description: 'des',
          imageLink:
              'https://www.google.com/photos/about/static/images/ui/logo-photos.png',
          price: 3,
          publisher: 'Khoa',
          quantityLeft: '10',
          status: 'available',
          title: 'Book Test 1',
        ),
      );
      // http.Response res = await http.get(Uri.parse('$uri/book/listBook/'),
      //     headers: {
      //       'Content-Type': 'application/json; charset=UTF-8',
      //       'Authorization': token
      //     });
      // httpErrorHandle(
      //   response: res,
      //   context: context,
      //   onSuccess: () {
      //     for (int i = 0; i < jsonDecode(res.body).length; i++) {
      //       favoriteList.add(
      //         BookItem.fromJson(
      //           jsonEncode(
      //             jsonDecode(res.body)[i],
      //           ),
      //         ),
      //       );
      //     }
      //   },
      // );
    } catch (e) {
      showSnackBar(context, e.toString());
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
      throw e;
    }
    return orderList;
  }

  Future<void> logout(BuildContext context) async {
    Provider.of<UserProvider>(context, listen: false).clear();
    Provider.of<FavoriteListProvider>(context, listen: false).clear();
    Provider.of<OrderListProvider>(context, listen: false).clear();
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
