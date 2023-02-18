import 'package:flutter/material.dart';
import 'package:grocery_app/constants/routes_constraints.dart';
import 'package:grocery_app/helpers/page_transition.dart';
import 'package:grocery_app/models/book_item.dart';
import 'package:grocery_app/screens/account/account_screen.dart';
import 'package:grocery_app/screens/product_details/book_detail_screen.dart';
import 'package:grocery_app/screens/search/search_all_screen.dart';

Route<dynamic> generateRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case RoutesHandler.ACCOUNT:
      return (SlideBottomRoute(
        page: AccountScreen(),
      ));
    case RoutesHandler.SEARCH_ALL:
      var searchQuery = routeSettings.arguments as String;
      return SlideRightRoute(
        page: SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case RoutesHandler.SINGLE_PRODUCT:
      var bookItem = routeSettings.arguments as BookItem;
      return ScaleRoute(
          page: BookDetailScreen(
        bookItem: bookItem,
      ));
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Screen not exist"),
          ),
        ),
      );
  }
}
