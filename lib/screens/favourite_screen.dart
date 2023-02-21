import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';

import 'package:grocery_app/models/book_item.dart';

import 'package:grocery_app/providers/favorite_list_providers.dart';

import 'package:grocery_app/providers/user_provider.dart';

import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<BookItem> favList = context.watch<FavoriteListProvider>().favoriteList;
    final user = context.watch<UserProvider>().account;
    return Scaffold(
      body: user.token.isEmpty
          ? Center(
              child:
                  TextButton(onPressed: () {}, child: Text('Go back to login')),
            )
          : favList.isEmpty
              ? Center(
                  child: AppText(
                    text: "No Favorite Items",
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF7C7C7C),
                  ),
                )
              : ListView.builder(
                  itemCount: favList.length,
                  itemBuilder: (context, index) {
                    BookItem bookItem = favList[index];
                    return Container();
                  },
                ),
    );
  }
}
