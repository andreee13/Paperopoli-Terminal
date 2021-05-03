import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;

const bool IS_WEB = kIsWeb;
// ignore: non_constant_identifier_names
final bool IS_MOBILE_ON_WEB = kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS);

const String SERVER_URL = 'https://tidety.ddns.net/api';

const String OPEN_WEATHER_API_KEY = '3fad3e73d27847a54f8ba8da4f5c8112';

const String VAPID_KEY =
    'BCmAzZ_X3PbV7jk314Tb871ntUJqo8P3rMdUY5RClXJzjprMIjAjxhEWydLSvhztjnNDMl5qhy_MYTiQx10GxtU';

const String HIVE_TIDE_BOX_KEY = 'hive_tide_key';
const String HIVE_PREFERENCES_BOX_KEY = 'hive_preferences_key';
const String HIVE_PREVISION_BOX_KEY = 'hive_prevision_tide_key';
const String HIVE_WEATHER_BOX_KEY = 'hive_weather_key';
const String HIVE_WIND_BOX_KEY = 'hive_wind_key';

const List<int> STATIONS_ID = [
  01025,
  01030,
  01033,
  01036,
  01023,
  01024,
  01022,
  01037,
  01028,
  01032,
  01021,
  01045,
  01029,
];
