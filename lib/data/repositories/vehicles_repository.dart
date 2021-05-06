import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paperopoli_terminal/core/errors/exceptions.dart';
import 'package:paperopoli_terminal/core/utils/constants.dart';
import 'package:paperopoli_terminal/data/models/vehicle_model.dart';

class VehiclesRepository {
  Future<List<VehicleModel>> fetch({
    required User user,
  }) async =>
      await http.get(
        Uri.parse(
          TERMINAL_API_URL,
        ),
        headers: {
          HttpHeaders.authorizationHeader: await user.getIdToken(),
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      ).then((response) {
        if (response.statusCode == HttpStatus.ok ||
            response.statusCode == HttpStatus.notModified) {
          return jsonDecode(response.body)
              .map(
                (item) => VehicleModel.fromJson(item),
              )
              .toList<VehicleModel>();
        } else {
          throw new ServerException();
        }
      });

  Future<void> delete({
    required int id,
    required User user,
  }) async =>
      http.delete(
        Uri.parse(
          '$TERMINAL_API_URL/vehicles/delete/$id',
        ),
        headers: {
          HttpHeaders.authorizationHeader: await user.getIdToken(),
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      ).then((response) {
        if (response.statusCode != HttpStatus.ok) {
          throw new ServerException();
        }
      });

  Future<void> edit({
    required VehicleModel vehicleModel,
    required User user,
  }) async =>
      http.patch(
        Uri.parse(
          '$TERMINAL_API_URL/vehicles/edit/${vehicleModel.plate}',
        ),
        headers: {
          HttpHeaders.authorizationHeader: await user.getIdToken(),
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      ).then((response) {
        if (response.statusCode != HttpStatus.ok) {
          throw new ServerException();
        }
      });

  Future<VehicleModel> create({
    required VehicleModel vehicleModel,
    required User user,
  }) async =>
      http.post(
        Uri.parse(
          '$TERMINAL_API_URL/vehicles/create',
        ),
        headers: {
          HttpHeaders.authorizationHeader: await user.getIdToken(),
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      ).then((response) {
        if (response.statusCode == HttpStatus.ok) {
          return vehicleModel..plate = response.body;
        } else {
          throw new ServerException();
        }
      });
}
