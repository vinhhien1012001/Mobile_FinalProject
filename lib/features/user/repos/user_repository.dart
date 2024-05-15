import 'dart:convert';
import 'dart:developer';

import 'package:final_project_mobile/services/http_service.dart';
import 'package:final_project_mobile/models/user_profile.dart';
import 'package:final_project_mobile/services/secure_storage.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final String baseUrl = 'https://api.studenthub.dev/api';

  late HttpService httpService;

  UserRepository() {
    httpService = HttpService();
  }

  Future<UserProfile> getMyProfile() async {
    final response = await httpService.request(
        method: RequestMethod.get, url: '$baseUrl/auth/me');
    return UserProfile.fromJson(response['result']);
  }

  Future<UserProfile> signIn(
      String email, String password, String fullname, int role) async {
    final response = await httpService.request(
        method: RequestMethod.post,
        url: '$baseUrl/auth/sign-up',
        body: {
          'email': email,
          'password': password,
          'fullname': fullname,
          'role': role
        });
    return UserProfile.fromJson(response['result']);
  }

  Future<void> signUp(
      String email, String password, String fullname, int role) async {
    try {
      final response = await httpService.request(
        method: RequestMethod.post,
        url: '$baseUrl/auth/sign-up',
        body: {
          'email': email,
          'password': password,
          'fullname': fullname,
          'role': role
        },
      );
      if (response['result'] == null) {
        String errorDetails =
            response['errorDetails'].map((e) => e.toString()).join(' ');
        throw Exception(errorDetails);
      }
    } catch (e) {
      print('ERRORS:');
      log(e.toString());
      rethrow;
    }
  }

  Future<void> signOut() async {
    late http.Client client;
    client = http.Client();
    try {
      http.Response response;

      final uri = Uri.parse('$baseUrl/auth/logout');
      final jwt = await SecureStorage().readSecureData('jwt');
      final headers = {
        'Authorization': 'Bearer $jwt',
        // 'Content-type': "Application/json"
      };
      response = await client.post(uri, headers: headers);
      if (response.statusCode > 400) {
        throw ('${jsonDecode(response.body)['errorDetails']}');
      }
      return jsonDecode(response.body);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
