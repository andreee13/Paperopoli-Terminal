import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:paperopoli_terminal/data/models/category_model.dart';
import 'package:paperopoli_terminal/data/models/good_model.dart';
import 'package:paperopoli_terminal/data/models/models_status.dart';
import 'package:paperopoli_terminal/data/models/person_model.dart';
import 'package:paperopoli_terminal/data/models/ships_model.dart';
import 'package:paperopoli_terminal/data/models/vehicle_model.dart';

const bool IS_WEB = kIsWeb;
// ignore: non_constant_identifier_names
final bool IS_MOBILE_ON_WEB = kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS);

const String SERVER_URL = 'http://192.168.0.20';

const String OPEN_WEATHER_API_KEY = '3fad3e73d27847a54f8ba8da4f5c8112';

const List<CategoryModel> CATEGORIES = [
  CategoryModel(
    name: 'Dashboard',
    mainIcon: Icons.apps,
    icons: [],
  ),
  CategoryModel(
    name: 'Programma',
    mainIcon: Icons.calendar_today_outlined,
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

// ignore: non_constant_identifier_names
final List<ShipModel> FAKE_SHIPS = [
  ShipModel(
    1111,
    ShipStatus.docked,
    DateTime.now().add(
      Duration(
        days: 24,
      ),
    ),
    DateTime.now(),
  ),
  ShipModel(
    2222,
    ShipStatus.docked,
    DateTime.now().add(
      Duration(
        days: 6,
      ),
    ),
    DateTime.now(),
  ),
  ShipModel(
    3333,
    ShipStatus.docked,
    DateTime.now().add(
      Duration(
        days: 11,
      ),
    ),
    DateTime.now(),
  ),
  ShipModel(
    4444,
    ShipStatus.docked,
    DateTime.now().add(
      Duration(
        days: 7,
      ),
    ),
    DateTime.now(),
  ),
  ShipModel(
    5555,
    ShipStatus.arriving,
    DateTime.now().add(
      Duration(
        days: 2,
      ),
    ),
    DateTime.now(),
  ),
  ShipModel(
    6666,
    ShipStatus.leaving,
    DateTime.now().add(
      Duration(
        days: 8,
      ),
    ),
    DateTime.now(),
  ),
  ShipModel(
    7777,
    ShipStatus.leaving,
    DateTime.now().add(
      Duration(
        days: 1,
      ),
    ),
    DateTime.now(),
  ),
];

// ignore: non_constant_identifier_names
final List<GoodModel> FAKE_GOODS = [
  GoodModel(
    8630,
    GoodStatus.onShip,
    FAKE_SHIPS[0],
  ),
  GoodModel(
    8630,
    GoodStatus.onShip,
    FAKE_SHIPS[1],
  ),
  GoodModel(
    8630,
    GoodStatus.onShip,
    FAKE_SHIPS[2],
  ),
  GoodModel(
    8630,
    GoodStatus.onShip,
    FAKE_SHIPS[3],
  ),
  GoodModel(
    8630,
    GoodStatus.onShip,
    FAKE_SHIPS[4],
  ),
  GoodModel(
    8630,
    GoodStatus.onShip,
    FAKE_SHIPS[5],
  ),
  GoodModel(
    8630,
    GoodStatus.onShip,
    FAKE_SHIPS[6],
  ),
];
// ignore: non_constant_identifier_names
final List<PersonModel> FAKE_PEOPLE = [
  PersonModel(
    2352,
    'Mario Rossi',
    PersonStatus.onVehicle,
  ),
  PersonModel(
    2362,
    'Beppino Ginetti',
    PersonStatus.onGround,
  ),
  PersonModel(
    7624,
    'Franco Bianchi',
    PersonStatus.onShip,
  ),
];
// ignore: non_constant_identifier_names
final List<VehicleModel> FAKE_VEHICLES = [
  VehicleModel(
    'CF832KJ',
    FAKE_PEOPLE[0],
    VehicleStatus.inside,
  ),
  VehicleModel(
    'CF832KJ',
    FAKE_PEOPLE[0],
    VehicleStatus.inside,
  ),
  VehicleModel(
    'CF832KJ',
    FAKE_PEOPLE[1],
    VehicleStatus.outside,
  ),
  VehicleModel(
    'CF832KJ',
    FAKE_PEOPLE[2],
    VehicleStatus.outside,
  ),
];
