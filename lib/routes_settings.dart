import 'package:flutter/material.dart';
import 'package:grocery_app/constants/routes_constraints.dart';
import 'package:grocery_app/helpers/page_transition.dart';
import 'package:grocery_app/models/account.dart';
import 'package:grocery_app/screens/account/account_screen.dart';

Route<dynamic> generateRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case RoutesHandler.ACCOUNT:
      return (SlideBottomRoute(
        page: AccountScreen(),
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
