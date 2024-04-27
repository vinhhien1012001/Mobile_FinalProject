import 'dart:convert';

import 'package:final_project_mobile/services/secure_storage.dart';
import 'package:http/http.dart' as http;

enum RequestMethod { get, post, put, delete, patch }

class HttpService {
  late http.Client client;

  HttpService() {
    client = http.Client();
  }

  Future request({
    required RequestMethod method,
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      http.Response response;

      final uri = Uri.parse(url);
      final jwt = await SecureStorage().readSecureData('jwt');
      final headers = {
        'Authorization': 'Bearer $jwt',
      };
      switch (method) {
        case RequestMethod.get:
          response = await client.get(uri, headers: headers);
          break;
        case RequestMethod.post:
          response = await client.post(uri, body: body, headers: headers);
          break;
        case RequestMethod.put:
          response = await client.put(uri, body: body, headers: headers);
          break;
        case RequestMethod.delete:
          response = await client.delete(uri, headers: headers);
        case RequestMethod.patch:
          response = await client.patch(uri, body: body, headers: headers);
          break;
      }

      if (response.statusCode > 400) {
        throw Exception('Error: Http status ${response.statusCode}');
      }
      return jsonDecode(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
