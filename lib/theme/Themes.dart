import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    primaryColorLight: Colors.black45,
    bottomAppBarColor: Colors.white,
    dialogBackgroundColor: Colors.orangeAccent,
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.orange),
      ),
      floatingLabelStyle: TextStyle(
          color: Colors.orange
      ),
    ),
  );
  static final dark = ThemeData.dark().copyWith(
    backgroundColor: Colors.black,
    primaryColorLight: Colors.white54,
    bottomAppBarColor: Colors.black26,
    dialogBackgroundColor: Colors.black26,
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.orange),
      ),
      floatingLabelStyle: TextStyle(
          color: Colors.orange
      ),
    ),
  );
}