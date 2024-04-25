import 'dart:convert';
import 'dart:developer';

import 'package:final_project_mobile/constants/base.constant.dart';
import 'package:final_project_mobile/src/models/user_profile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final authServiceProvider = Provider<AuthServices>((ref) => AuthServices());

class AuthServices {
  final storage = const FlutterSecureStorage();
  late String jwtToken = '';
  AuthServices() {
    _initToken();
  }
  Future<void> _initToken() async {
    jwtToken = (await storage.read(key: 'token')) ?? '';
  }

  Future<String> login({required email, required String password}) async {
    try {
      final res = await http.post(Uri.https(baseURL, '/api/auth/sign-in'),
          body: {'email': email, 'password': password});
      log(res.body);
      if (res.statusCode == 201) {
        final resBody = jsonDecode(res.body)['result']['token'];
        jwtToken = resBody;
        log(jwtToken);
        const FlutterSecureStorage().write(key: 'token', value: jwtToken);
        return jwtToken;
      }
    } catch (e) {
      return '';
    }
    return '';
  }

  Future<UserProfile> getMyProfile() async {
    final res = await http.get(Uri.https(baseURL, '/api/auth/me'), headers: {
      'Authorization': 'Bearer $jwtToken',
    });
    if (res.statusCode == 200) {
      final resBody = jsonDecode(res.body)['result'];
      return UserProfile.fromJson(resBody);
    } else {
      throw Exception('Failed to load profile');
    }
  }
}
