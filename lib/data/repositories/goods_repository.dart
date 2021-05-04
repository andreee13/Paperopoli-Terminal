import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paperopoli_terminal/core/errors/exceptions.dart';
import 'package:paperopoli_terminal/core/utils/constants.dart';
import 'package:paperopoli_terminal/data/models/good_model.dart';

class GoodsRepository {
  final User user;

  GoodsRepository({
    required this.user,
  });

  Future<List<GoodModel>> fetch() async => await http.get(
        Uri.parse(
          SERVER_URL,
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
          throw new ServerException();
        }
      });

  Future<void> delete({
    required int id,
  }) async =>
      http.delete(
        Uri.parse(
          '$SERVER_URL/goods/delete/$id',
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
    required GoodModel goodModel,
  }) async =>
      http.patch(
        Uri.parse(
          '$SERVER_URL/goods/edit/${goodModel.id}',
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

  Future<GoodModel> create({
    required GoodModel goodModel,
  }) async =>
      http.post(
        Uri.parse(
          '$SERVER_URL/goods/create',
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
          throw new ServerException();
        }
      });
}
