import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_app/constants/constant.dart';
import 'package:grocery_app/helpers/http_handler.dart';
import 'package:grocery_app/helpers/snackbar.dart';
import 'package:grocery_app/models/book_item.dart';
import 'package:http/http.dart' as http;

class SearchBooksService {
  Future<List<BookItem>> fetchSearchedProducts({
    required BuildContext context,
    required String searchQuery,
  }) async {
    // final userProvider = Provider.of<UserProvider>(
    //   context,
    //   listen: false,
    // );
    List<BookItem> bookList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products/search/$searchQuery'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        //'x-auth-token': userProvider.user.token,
      }).timeout(
        const Duration(
          seconds: 4,
        ),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            bookList.add(
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
      showSnackBar(context, e.toString());
    }

    return bookList;
  }
}
