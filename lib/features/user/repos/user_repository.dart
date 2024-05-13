import 'dart:convert';
import 'dart:developer';

import 'package:final_project_mobile/services/http_service.dart';
import 'package:final_project_mobile/models/user_profile.dart';

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
        print('ERRORS:');
        // print(response['errorDetails'].runtimeType);
        // String errorDetails = response['errorDetails'].join(' ');
        String errorDetails =
            response['errorDetails'].map((e) => e.toString()).join(' ');
        throw Exception(errorDetails);
      }
    } catch (e) {
      print('ERRORS:');
      log(e.toString());
      throw e;
    }
  }

  Future<void> signOut() async {
    log('Signing out');
    await httpService.request(
        method: RequestMethod.post, url: '$baseUrl/auth/logout');
  }
}
