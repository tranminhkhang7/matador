import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/constants/routes_constraints.dart';

import 'package:grocery_app/models/book_item.dart';

import 'package:grocery_app/providers/favorite_list_provider.dart';

import 'package:grocery_app/providers/user_provider.dart';
import 'package:grocery_app/services/books_services.dart';

import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  BooksService booksService = BooksService();
  @override
  void initState() {
    super.initState();
  }

  void navigateToSomeWhere(BuildContext context) {
    Navigator.pushNamed(
      context,
      RoutesHandler.ACCOUNT,
    );
  }

  void removeFromFavorite(int id) {
    booksService.deleteFromFavorite(context, id);
    setState(() {});
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Image.network(
                                bookItem.imageLink,
                                width: 80,
                                height: 120,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      bookItem.title,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      bookItem.description,
                                      style: TextStyle(fontSize: 16),
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Author: ${bookItem.author}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 120,
                              width: 50,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Icon(
                                  //   Icons.arrow_forward_ios,
                                  // ),
                                  // SizedBox(
                                  //   height: 12,
                                  // ),
                                  GestureDetector(
                                    onTap: () {
                                      removeFromFavorite(bookItem.bookId);
                                      // favList.removeWhere((element) =>
                                      //     element.bookId == bookItem.bookId);
                                    },
                                    child: Icon(
                                      Icons.favorite_outlined,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
