import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/book_item.dart';

class FavoriteListProvider extends ChangeNotifier {
  List<BookItem> _favoriteList = [];

  List<BookItem> get favoriteList => _favoriteList;

  void setFavoriteList(List<BookItem> list) {
    _favoriteList = list;
  }

  void clear() {
    _favoriteList = [];
  }
}
