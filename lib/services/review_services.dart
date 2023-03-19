import 'dart:convert';
import 'dart:developer';

import 'package:grocery_app/constants/constant.dart';
import 'package:grocery_app/helpers/http_handler.dart';
import 'package:grocery_app/models/book_item.dart';
import 'package:grocery_app/models/comment.dart';
import 'package:grocery_app/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ReviewServices {
  Future<BookItem> addComment({
    required BuildContext context,
    required String content,
    required double rating,
    required int bookId,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    BookItem book = BookItem(
      bookId: bookId,
      author: '',
      description: '',
      imageLink: '',
      price: 0,
      publisher: '',
      quantityLeft: 0,
      status: '',
      title: '',
    );
    // Comment comment =
    //     Comment(content: content, rating: rating, timestamp: DateTime.now());
    http.Response res =
        await http.post(Uri.parse('$uriCuaKhoa/book/addComment'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ${userProvider.account.token}',
            },
            body: jsonEncode(
              {
                "content": content,
                "rating": rating,
                "bookId": bookId,
              },
            ));
    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () {
        book = BookItem.fromJson(
          jsonEncode(
            jsonDecode(res.body),
          ),
        );
        log(book.title);
      },
    );
    return book;
  }
}
