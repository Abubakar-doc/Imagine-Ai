import 'package:flutter/material.dart';

const Color customPurple = Color(0xFF5C3DF6);
const Color customDarkGreybg = Color(0xFF181A20);
const Color customWhitebg = Color(0xFFFFFFFF);
const Color customDarkTextContainer = Color(0xFF1F222A);
const Color customDarkContainerOutline = Color(0xFF414454);
Color customLightTextContainer = Colors.grey.shade200;

const Color customDarkTextColor = Color(0xFFFFFFFF); // Text color for dark theme
const Color customLightTextColor = Color(0xFF0B0B0B); // Text color for light theme

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: customWhitebg,
  brightness: Brightness.light,
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: customLightTextColor),
  ),
  iconTheme: const IconThemeData(color: customPurple), // Icon color for light theme
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: customDarkGreybg,
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: customDarkTextColor),
  ),
  iconTheme: const IconThemeData(color: Colors.white), // Icon color for dark theme
);
