import 'package:flutter/material.dart';
import 'package:grocery_app/constants/routes_constraints.dart';
import 'package:grocery_app/helpers/page_transition.dart';
import 'package:grocery_app/models/book_item.dart';
import 'package:grocery_app/models/genre.dart';
import 'package:grocery_app/screens/account/account_screen.dart';
import 'package:grocery_app/screens/category/category_screen.dart';
import 'package:grocery_app/screens/dashboard/dashboard_screen.dart';
import 'package:grocery_app/screens/order/screens/orders_screen.dart';
import 'package:grocery_app/screens/product_details/book_detail_screen.dart';
import 'package:grocery_app/screens/profile/user_profile.dart';
import 'package:grocery_app/screens/search/search_all_screen.dart';

Route<dynamic> generateRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case RoutesHandler.BOTTOM_BAR:
      return (SlideBottomRoute(
        page: DashboardScreen(),
      ));
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
      return SlideBottomRoute(
          page: BookDetailScreen(
        bookItem: bookItem,
      ));
    case RoutesHandler.USER_PROFILE:
      return (FadeRoute(
        page: UserProfileScreen(),
      ));
    case RoutesHandler.CATEGORY_PRODUCTS:
      var genre = routeSettings.arguments as Genre;
      return (SlideBottomRoute(
        page: CategoryItemsScreen(
          genre: genre,
        ),
      ));
    case RoutesHandler.ORDERS:
      return (FadeRoute(
        page: OrdersScreen(),
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
