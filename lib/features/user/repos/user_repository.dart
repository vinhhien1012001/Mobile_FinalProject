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
    log('2nd');
    final response = await httpService.request(
        method: RequestMethod.get, url: '$baseUrl/auth/me');
    return UserProfile.fromJson(response['result']);
  }
}
