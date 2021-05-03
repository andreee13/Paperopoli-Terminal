import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paperopoli_terminal/core/utils/constants.dart';

class ServerService {
  final User user;

  ServerService({
    required this.user,
  });

  Future<http.Response> login() async => await http.post(
        Uri.parse(
          SERVER_URL,
        ),
        body: jsonEncode({
          'metadata': {
            'creationTime': user.metadata.creationTime!.toIso8601String(),
            'lastSignInTime': user.metadata.lastSignInTime!.toIso8601String(),
          },
        }),
        headers: {
          HttpHeaders.authorizationHeader: await user.getIdToken(
            true,
          ),
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      );

  Future<http.Response> setPreferences() async => await http.patch(
        Uri.parse(
          SERVER_URL,
        ),
        body: jsonEncode({}),
        headers: {
          HttpHeaders.authorizationHeader: await user.getIdToken(
            true,
          ),
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      );
}
