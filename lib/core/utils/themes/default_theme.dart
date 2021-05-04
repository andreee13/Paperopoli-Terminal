import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
final ThemeData DEFAULT_THEME = ThemeData(
  fontFamily: 'SFProDisplay',
  accentColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          15,
        ),
      ),
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: AppBarTheme(
    color: Colors.red,
    elevation: 1,
  ),
);
