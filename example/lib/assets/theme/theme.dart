import 'package:flutter/material.dart';
import 'package:yandex_mapkit_example/assets/theme/color_pallete.dart';

final _baseTheme = ThemeData(
  primaryColor: primaryColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColor,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: backgroundDarkColor),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
  ),
  textTheme: const TextTheme(),
);

ThemeData generateLightTheme() {
  return _baseTheme.copyWith(
    scaffoldBackgroundColor: backgroundLightColor,
    iconTheme: const IconThemeData(color: backgroundLightColor),
    textTheme: _baseTheme.textTheme.apply(
      bodyColor: backgroundLightColor,
    ),
  );
}

ThemeData generateDarkTheme() {
  return _baseTheme.copyWith(
    scaffoldBackgroundColor: backgroundDarkColor,
    iconTheme: const IconThemeData(color: backgroundDarkColor),
    textTheme: _baseTheme.textTheme.apply(
      bodyColor: backgroundDarkColor,
    ),
  );
}
