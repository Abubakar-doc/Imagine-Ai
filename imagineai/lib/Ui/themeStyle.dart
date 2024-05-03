import 'package:flutter/material.dart';

const Color customPurple = Color(0xFF5C3DF6);
const Color custombackground = Color(0xFF181A20);

ThemeData lightTheme = ThemeData(
  textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 45, color: Colors.black)),
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
);

ThemeData darkTheme = ThemeData(
  textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 45, color: Colors.white)),
  scaffoldBackgroundColor: custombackground,
  brightness: Brightness.dark,
);

