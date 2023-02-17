import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:grocery_app/constants/constant.dart';
import 'package:grocery_app/helpers/http_handler.dart';
import 'package:grocery_app/helpers/snackbar.dart';
import 'package:grocery_app/models/account.dart';
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
        Uri.parse("https://8b6c-171-252-155-251.ap.ngrok.io/auth/signup"),
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
      SharedPreferences preferences = await SharedPreferences.getInstance();

      http.Response res = await http.post(
        Uri.parse("https://8b6c-171-252-155-251.ap.ngrok.io/auth/signin"),
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
          log(
            jsonEncode({'token': res.body}),
          );
          Account account = Account(
            email: email,
            password: password,
            token: res.body,
            birthDate: null,
            gender: '',
            name: '',
          );
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setUserFromModel(account);
          // await preferences.setString(
          //     'Authorization', jsonDecode(res.body)['token']);
          //await getUserData(context: context);
        },
      );
    } on TimeoutException catch (_) {
      showSnackBar(context, "Timeout");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> getUserData({
    required BuildContext context,
  }) async {
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // String? token = prefs.getString('Authorization');

      //log(response);

      http.Response userResponse = await http.get(
        Uri.parse('https://8b6c-171-252-155-251.ap.ngrok.io/'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": ''
        },
      ).timeout(
        const Duration(
          seconds: 10,
        ),
      );

      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(userResponse.body);
    } on TimeoutException catch (_) {
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
