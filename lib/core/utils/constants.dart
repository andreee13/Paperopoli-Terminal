import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';

const bool IS_WEB = kIsWeb;
// ignore: non_constant_identifier_names
final bool IS_MOBILE_ON_WEB = kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS);

const String SERVER_URL = 'https://tidety.ddns.net/api';

const String OPEN_WEATHER_API_KEY = '3fad3e73d27847a54f8ba8da4f5c8112';

const List<Map<String, dynamic>> CATEGORIES = [
  {
    'name': 'Dashboard',
    'icon': Icons.apps,
  },
  {
    'name': 'Calendario',
    'icon': Icons.calendar_today_outlined,
  },
  {
    'name': 'Navi',
    'icon': Icons.directions_boat,
  },
  {
    'name': 'Merci',
    'icon': Icons.grid_view,
  },
  {
    'name': 'Veicoli',
    'icon': Icons.local_shipping,
  },
];
