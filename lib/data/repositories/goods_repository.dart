import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:paperopoli_terminal/core/errors/exceptions.dart';
import 'package:paperopoli_terminal/core/utils/constants.dart';
import 'package:paperopoli_terminal/data/models/good/good_model.dart';

class GoodsRepository {
  Future<List<GoodModel>> fetch({
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
                (item) => GoodModel.fromJson(item),
              )
              .toList<GoodModel>();
        } else {
          throw ServerException();
        }
      });

  Future<void> delete({
    required int id,
    required User user,
  }) async =>
      http.delete(
        Uri.parse(
          '$TERMINAL_API_URL/goods/delete/$id',
        ),
        headers: {
          HttpHeaders.authorizationHeader: await user.getIdToken(),
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      ).then((response) {
        if (response.statusCode != HttpStatus.ok) {
          throw ServerException();
        }
      });

  Future<void> edit({
    required GoodModel goodModel,
    required User user,
  }) async =>
      http.patch(
        Uri.parse(
          '$TERMINAL_API_URL/goods/edit/${goodModel.id}',
        ),
        headers: {
          HttpHeaders.authorizationHeader: await user.getIdToken(),
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      ).then((response) {
        if (response.statusCode != HttpStatus.ok) {
          throw ServerException();
        }
      });

  Future<GoodModel> create({
    required GoodModel goodModel,
    required User user,
  }) async =>
      http.post(
        Uri.parse(
          '$TERMINAL_API_URL/goods/create',
        ),
        headers: {
          HttpHeaders.authorizationHeader: await user.getIdToken(),
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      ).then((response) {
        if (response.statusCode == HttpStatus.ok) {
          return goodModel
            ..id = int.parse(
              response.body,
            );
        } else {
          throw ServerException();
        }
      });
}
