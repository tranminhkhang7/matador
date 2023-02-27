import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/cart.dart';

class CartProvider extends ChangeNotifier {
  List<Cart> _cartFavoriteList = [];
  List<Cart> get cartFavoriteList => _cartFavoriteList;
  void setCartItemList(List<Cart> list) {
    _cartFavoriteList = list;
    notifyListeners();
  }

  void clear() {
    _cartFavoriteList = [];
    notifyListeners();
  }
}
