import 'dart:developer';

import 'package:final_project_mobile/models/notification.dart';
import 'package:final_project_mobile/services/http_service.dart';

class NotificationRepository {
  final String baseUrl = 'https://api.studenthub.dev/api';

  late HttpService httpService;

  NotificationRepository() {
    httpService = HttpService();
  }

  Future<List<Notification>> getNotification(int userId) async {
    log('Get Notification in repository');
    final response = await httpService.request(
      method: RequestMethod.get,
      url: '$baseUrl/notification/getByReceiverId/$userId',
    );
    log('response repo: ${response['result']}');
    if (response['result'] != null) {
      if (response['result'].isEmpty) {
        return [];
      }
      return response['result']
          .map((item) => Notification.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }
}
