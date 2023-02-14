import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grocery_app/constants/constant.dart';
import 'package:grocery_app/helpers/http_handler.dart';
import 'package:grocery_app/helpers/snackbar.dart';
import 'package:grocery_app/models/account.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Account> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      Account account = Account(
        email: email,
        password: password,
      );
      http.Response res = await http.post(
        Uri.parse("$uriCuaKhoa/signup"),
        body: account.toJson(),
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
      if (res.statusCode == 200) {
        return account;
      }
      //return Account(email: '', password: '');
    } on TimeoutException catch (_) {
      showSnackBar(context, "Timeout");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return Account(email: '', password: '');
  }
}
