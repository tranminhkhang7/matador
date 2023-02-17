import 'package:flutter/material.dart';
import 'package:grocery_app/providers/search_list_provider.dart';
import 'package:grocery_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<SearchItemsProvider>(
          create: (context) => SearchItemsProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}
