import 'package:flutter/material.dart';

ThemeData appThemeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.white,
  fontFamily: 'roboto',
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.green,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(Colors.green),
  ),
  textTheme: TextTheme(
    headline6: TextStyle(
      color: Colors.green,
      fontSize: 16.0,
      height: 1.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  dividerTheme: DividerThemeData(
    space: 1.0,
    thickness: 1.0,
  ),
);
