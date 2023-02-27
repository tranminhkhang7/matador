import 'package:flutter/material.dart';
import 'package:grocery_app/routes_settings.dart';
import 'package:grocery_app/screens/splash_screen.dart';
import 'package:grocery_app/services/auth_service.dart';
import 'package:grocery_app/styles/theme.dart';
import 'package:grocery_app/widgets/loader.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matador',
      theme: themeData,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoutes(settings),
      home: Builder(builder: (context) {
        return FutureBuilder(
          future:
              authService.signInUser(context: context, email: '', password: ''),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SplashScreen();
            } else {
              return const Loader();
            }
          },
        );
      }),
    );
  }
}
