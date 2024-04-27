import 'dart:convert';
import 'dart:developer';

import 'package:final_project_mobile/constants/base.constant.dart';
import 'package:final_project_mobile/services/secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final authServiceProvider = Provider<AuthServices>((ref) => AuthServices());

class AuthServices {
  Future<String> login({required email, required String password}) async {
    try {
      final res = await http.post(Uri.https(baseURL, '/api/auth/sign-in'),
          body: {'email': email, 'password': password});
      log(res.body);
      if (res.statusCode == 201) {
        final resBody = jsonDecode(res.body)['result']['token'];
        final jwtToken = resBody;
        log(jwtToken);
        ('token', jwtToken);
        SecureStorage().writeSecureData('jwt', jwtToken);
        return jwtToken;
      }
    } catch (e) {
      return '';
    }
    return '';
  }

  // Future<UserProfile> getMyProfile() async {
  //   final res = await http.get(Uri.https(baseURL, '/api/auth/me'), headers: {
  //     'Authorization': 'Bearer $jwtToken',
  //   });
  //   if (res.statusCode == 200) {
  //     final resBody = jsonDecode(res.body)['result'];
  //     return UserProfile(
  //         id: resBody['id'],
  //         fullname: resBody['fullname'],
  //         roles: List<int>.from(resBody['roles']));
  //   } else {
  //     throw Exception('Failed to load profile');
  //   }
  // }
}
