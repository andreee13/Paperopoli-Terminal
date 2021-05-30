import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paperopoli_terminal/core/utils/constants.dart';
import 'package:paperopoli_terminal/data/models/trip/trip_model.dart';

class ServerService {
  final User _user;

  const ServerService(
    this._user,
  );

  /* QUAYS */

  Future<http.Response> fetchQuays() async => await http.get(
        Uri.parse(
          '$TERMINAL_API_URL/quays/index',
        ),
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.value,
          HttpHeaders.authorizationHeader: await _user.getIdToken(),
        },
      );

  /* TRIPS */

  Future<http.Response> editTrip(
    TripModel tripModel,
  ) async =>
      await http.post(
        Uri.parse(
          '$TERMINAL_API_URL/trips/edit',
        ),
        body: jsonEncode(tripModel),
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.value,
          HttpHeaders.authorizationHeader: await _user.getIdToken(),
        },
      );

  Future<http.Response> createTrip(
    TripModel tripModel,
  ) async =>
      await http.post(
        Uri.parse(
          '$TERMINAL_API_URL/trips/create',
        ),
        body: jsonEncode(tripModel),
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.value,
          HttpHeaders.authorizationHeader: await _user.getIdToken(),
        },
      );

  Future<http.Response> deleteTrip(
    TripModel tripModel,
  ) async =>
      await http.post(
        Uri.parse(
          '$TERMINAL_API_URL/trips/delete',
        ),
        body: jsonEncode({
          'id': tripModel.id,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.value,
          HttpHeaders.authorizationHeader: await _user.getIdToken(),
        },
      );
}
