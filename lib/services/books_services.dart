import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grocery_app/constants/constant.dart';
import 'package:grocery_app/helpers/http_handler.dart';
import 'package:grocery_app/helpers/snackbar.dart';
import 'package:grocery_app/models/book_item.dart';
import 'package:grocery_app/models/genre.dart';
import 'package:grocery_app/providers/favorite_list_provider.dart';
import 'package:grocery_app/providers/user_provider.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BooksService {
  Future<List<BookItem>> fetchSearchedProducts({
    required BuildContext context,
    required String searchQuery,
    int pageNo = 0,
    int pageSize = 6,
  }) async {
    List<BookItem> bookList = [];
    try {
      http.Response res = await http.get(
          Uri.parse(
              '$uriCuaKhoa/book/search?query=$searchQuery&pageNo=$pageNo&pageSize=$pageSize'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            //'Authorization': 'Bearer ${userProvider.account.token}',
          });

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
    } on SocketException catch (e) {
      showSnackBar(
        context,
        'Connection refuse $e',
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return bookList;
  }

  Future<List<BookItem>> fetchSearchedProductsChatGPT({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final queryParams = {'query': searchQuery};
    final uri = Uri.https(uriCuaKhoa, '/book/search', queryParams);

    final bookList = <BookItem>[];

    try {
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': 'Bearer ${userProvider.account.token}',
      }).timeout(const Duration(seconds: 4));

      final data = jsonDecode(response.body) as List<dynamic>;
      bookList.addAll(
          data.map((bookData) => BookItem.fromJson(jsonEncode(bookData))));
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return bookList;
  }

  Future<List<BookItem>> fetchCategoryBooks({
    required BuildContext context,
    required int categoryId,
  }) async {
    List<BookItem> bookList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uriCuaKhoa/book/listBook/$categoryId'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

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

  Future<List<Genre>> fetchGenres(BuildContext context) async {
    List<Genre> genreList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uriCuaKhoa/book/genre'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            genreList.add(Genre.fromMap(
              jsonDecode(res.body)[i],
            ));
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return genreList;
  }

  Future<void> addToFavorite(BuildContext context, int bookId) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      log(userProvider.account.token);
      http.Response res =
          await http.post(Uri.parse('$uriCuaKhoa/favourite/$bookId'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${userProvider.account.token}',
      });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          List<BookItem> newFavList = [];
          final favProvider =
              Provider.of<FavoriteListProvider>(context, listen: false);
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            newFavList.add(
              BookItem.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
          favProvider.setFavoriteList(newFavList);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> deleteFromFavorite(BuildContext context, int bookId) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      log(userProvider.account.token);
      http.Response res = await http
          .delete(Uri.parse('$uriCuaKhoa/favourite/$bookId'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${userProvider.account.token}',
      });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          List<BookItem> newFavList = [];
          final favProvider =
              Provider.of<FavoriteListProvider>(context, listen: false);
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            newFavList.add(
              BookItem.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
          favProvider.setFavoriteList(newFavList);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
