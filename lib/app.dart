import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:grocery_app/routes_settings.dart';
import 'package:grocery_app/screens/splash_screen.dart';
import 'package:grocery_app/services/auth_service.dart';
import 'package:grocery_app/styles/theme.dart';
import 'package:grocery_app/widgets/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? mytoken = "";

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    requestPermission();
    getToken();
    initInfor();
  }

//request notification permission
  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Granted permission.");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("Granted provisional permission.");
    } else {
      print("Not Granted permission.");
    }
  }

  void getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? accToken = prefs.getString('accToken');
    print("accToken");
    print(accToken);

    await FirebaseMessaging.instance.getToken().then((firebaseToken) {
      setState(() {
        mytoken = firebaseToken;
      });
      print("firebaseToken");
      print(firebaseToken);

      authService.fetchSendingFirebaseToken(context, accToken!, firebaseToken!);

      // return token;
      // saveToken(token!);
    });   
  }

  initInfor() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialize = const DarwinInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iosInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'dbfood',
        'dbfood',
        importance: Importance.max,
        styleInformation: bigTextStyleInformation,
        priority: Priority.max,
        playSound: false,
      );
      NotificationDetails platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: const DarwinNotificationDetails());
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, platformChannelSpecifics,
          payload: message.data['body']);
    });
  }

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
