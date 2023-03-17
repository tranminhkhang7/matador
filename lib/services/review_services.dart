import 'dart:convert';

import 'package:grocery_app/constants/constant.dart';
import 'package:grocery_app/models/comment.dart';
import 'package:grocery_app/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ReviewServices {
  Future<void> addComment(
      {required BuildContext context,
      required String content,
      required double rating}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Comment comment =
        Comment(content: content, rating: rating, timestamp: DateTime.now());
    http.Response res =
        await http.post(Uri.parse('$uriCuaKhoa/book/addComment'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${userProvider.account.token}',
    }, body: {
      jsonEncode({comment})
    });
  }
}
