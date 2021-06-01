import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paperopoli_terminal/core/errors/exceptions.dart';
import 'package:paperopoli_terminal/core/utils/constants.dart';
import 'package:paperopoli_terminal/data/models/ship/ship_model.dart';

class ShipsRepository {
  Future<List<ShipModel>> fetch({
    required User user,
  }) async =>
      await http.get(
        Uri.parse(
          '$TERMINAL_API_URL/ships/index',
        ),
        headers: {
          HttpHeaders.authorizationHeader: await user.getIdToken(),
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      ).then(
        (response) {
          if (response.statusCode == HttpStatus.ok ||
              response.statusCode == HttpStatus.notModified) {
            var v = <ShipModel>[];
            /*jsonDecode(response.body).forEach<Map<String, dynamic>>((value) {
              v.add(
                ShipModel.fromJson(
                  value,
                ),
              );
            });*/
            jsonDecode(response.body).forEach(
              (String k, value) => v.add(
                ShipModel.fromJson(
                  value,
                ),
              ),
            );
            return v;
          } else {
            throw ServerException();
          }
        },
      );

  Future<void> delete({
    required int id,
    required User user,
  }) async =>
      http.delete(
        Uri.parse(
          '$TERMINAL_API_URL/ships/delete/$id',
        ),
        headers: {
          HttpHeaders.authorizationHeader: await user.getIdToken(),
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      ).then(
        (response) {
          if (response.statusCode != HttpStatus.ok) {
            throw ServerException();
          }
        },
      );

  Future<void> edit({
    required ShipModel shipModel,
    required User user,
  }) async =>
      http.patch(
        Uri.parse(
          '$TERMINAL_API_URL/ships/edit/${shipModel.id}',
        ),
        headers: {
          HttpHeaders.authorizationHeader: await user.getIdToken(),
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      ).then(
        (response) {
          if (response.statusCode != HttpStatus.ok) {
            throw ServerException();
          }
        },
      );

  Future<ShipModel> create({
    required ShipModel shipModel,
    required User user,
  }) async =>
      http.post(
        Uri.parse(
          '$TERMINAL_API_URL/ships/create',
        ),
        headers: {
          HttpHeaders.authorizationHeader: await user.getIdToken(),
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      ).then(
        (response) {
          if (response.statusCode == HttpStatus.ok) {
            return shipModel
              ..id = int.parse(
                response.body,
              );
          } else {
            throw ServerException();
          }
        },
      );
}
