import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:ionicons/ionicons.dart';
import 'package:paperopoli_terminal/data/models/category_model.dart';

const bool IS_WEB = kIsWeb;
// ignore: non_constant_identifier_names
final bool IS_MOBILE_ON_WEB = kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS);

//const String TERMINAL_API_URL = 'http://192.168.0.4/paperopoli_terminal';
const String TERMINAL_API_URL = 'http://localhost/paperopoli_terminal';

const String OPEN_WEATHER_API_KEY = '3fad3e73d27847a54f8ba8da4f5c8112';

const List<Color> ACCENT_COLORS = [
  Color(0xffF9FEDF),
  Color(0xffe6fbff),
  Color(0xffF3F1FF),
];

const List<CategoryModel> CATEGORIES = [
  CategoryModel(
    name: 'Dashboard',
    mainIcon: Ionicons.grid_outline,
    icons: [],
  ),
  CategoryModel(
    name: 'Viaggi',
    mainIcon: Icons.calendar_today_outlined,
    icons: [],
  ),
  CategoryModel(
    name: 'Movimentazioni',
    mainIcon: Icons.stacked_line_chart_outlined,
    icons: [],
  ),
  CategoryModel(
    name: 'Navi',
    mainIcon: Ionicons.boat_outline,
    icons: [
      Icons.login,
      Icons.logout,
      Icons.insert_link,
    ],
  ),
  CategoryModel(
    name: 'Merci',
    mainIcon: Ionicons.cube_outline,
    icons: [
      Icons.directions_boat,
      Icons.play_for_work,
      Icons.logout,
    ],
  ),
  CategoryModel(
    name: 'Persone',
    mainIcon: Ionicons.people_outline,
    icons: [
      Icons.done,
      Icons.close,
    ],
  ),
  CategoryModel(
    name: 'Veicoli',
    mainIcon: Ionicons.car_outline,
    icons: [
      Icons.done,
      Icons.close,
    ],
  ),
];
