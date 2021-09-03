import 'package:flutter/material.dart';

ThemeData appThemeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.white,
  accentColor: Colors.black,
  fontFamily: 'roboto',
  accentIconTheme: IconThemeData(
    color: Colors.white.withOpacity(0.7),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
);
