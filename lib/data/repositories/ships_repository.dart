import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paperopoli_terminal/core/errors/exceptions.dart';
import 'package:paperopoli_terminal/core/utils/constants.dart';
import 'package:paperopoli_terminal/data/models/ships_model.dart';

class ShipsRepository {
  Future<List<ShipModel>> fetch({
    required User user,
  }) async =>
      await http.get(
        Uri.parse(
          '$SERVER_URL/ships/index',
        ),
        headers: {
          HttpHeaders.authorizationHeader: await user.getIdToken(),
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      ).then(
        (response) {
          print(response.body);
          if (response.statusCode == HttpStatus.ok ||
              response.statusCode == HttpStatus.notModified) {
            return jsonDecode(response.body)
                .map(
                  (item) => ShipModel.fromJson(item),
                )
                .toList<ShipModel>();
          } else {
            throw new ServerException();
          }
        },
      );

  Future<void> delete({
    required int id,
    required User user,
  }) async =>
      http.delete(
        Uri.parse(
          '$SERVER_URL/ships/delete/$id',
        ),
        headers: {
          HttpHeaders.authorizationHeader: await user.getIdToken(),
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      ).then(
        (response) {
          if (response.statusCode != HttpStatus.ok) {
            throw new ServerException();
          }
        },
      );

  Future<void> edit({
    required ShipModel shipModel,
    required User user,
  }) async =>
      http.patch(
        Uri.parse(
          '$SERVER_URL/ships/edit/${shipModel.id}',
        ),
        headers: {
          HttpHeaders.authorizationHeader: await user.getIdToken(),
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      ).then(
        (response) {
          if (response.statusCode != HttpStatus.ok) {
            throw new ServerException();
          }
        },
      );

  Future<ShipModel> create({
    required ShipModel shipModel,
    required User user,
  }) async =>
      http.post(
        Uri.parse(
          '$SERVER_URL/ships/create',
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
            throw new ServerException();
          }
        },
      );
}
