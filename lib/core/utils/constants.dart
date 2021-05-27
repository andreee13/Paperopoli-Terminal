import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
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
  Color(0xfff2fdff),
  Color(0xffF3F1FF),
];

const List<CategoryModel> CATEGORIES = [
  CategoryModel(
    name: 'Dashboard',
    mainIcon: Icons.apps,
    icons: [],
  ),
  CategoryModel(
    name: 'Viaggi',
    mainIcon: Icons.calendar_today_outlined,
    icons: [],
  ),
  CategoryModel(
    name: 'Operazioni',
    mainIcon: Icons.construction,
    icons: [],
  ),
  CategoryModel(
    name: 'Navi',
    mainIcon: Icons.directions_boat,
    icons: [
      Icons.login,
      Icons.logout,
      Icons.insert_link,
    ],
  ),
  CategoryModel(
    name: 'Merci',
    mainIcon: Icons.grid_view,
    icons: [
      Icons.directions_boat,
      Icons.play_for_work,
      Icons.logout,
    ],
  ),
  CategoryModel(
    name: 'Veicoli',
    mainIcon: Icons.local_shipping,
    icons: [
      Icons.done,
      Icons.close,
    ],
  ),
];
