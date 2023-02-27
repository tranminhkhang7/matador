import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/firebase_options.dart';
import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/providers/favorite_list_provider.dart';
import 'package:grocery_app/providers/order_list_provider.dart';
import 'package:grocery_app/providers/search_list_provider.dart';
import 'package:grocery_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<SearchItemsProvider>(
          create: (context) => SearchItemsProvider(),
        ),
        ChangeNotifierProvider<FavoriteListProvider>(
          create: (context) => FavoriteListProvider(),
        ),
        ChangeNotifierProvider<OrderListProvider>(
          create: (context) => OrderListProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}
