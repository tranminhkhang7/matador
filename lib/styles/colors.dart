import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  //One instance, needs factory
  static AppColors? _instance;
  factory AppColors() => _instance ??= AppColors._();

  AppColors._();

  static const primaryColor = Color(0xffd2a679);
  static const darkGrey = Color(0xff7C7C7C);
  static const Color lightGrey = Color(0xffebecee);
  static const secondaryColor = Color.fromARGB(214, 255, 174, 0);
  static const scaffoldBackgroundColor = Colors.white;
}
