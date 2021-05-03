import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
final ThemeData DEFAULT_THEME = ThemeData(
  fontFamily: 'SFProDisplay',
  accentColor: Colors.white10,
  scaffoldBackgroundColor: Colors.white,
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  dialogTheme: DialogTheme(
    titleTextStyle: TextStyle(
      color: Colors.black,
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
