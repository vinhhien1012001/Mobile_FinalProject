import 'dart:developer';

import 'package:final_project_mobile/models/message.dart';
import 'package:final_project_mobile/services/http_service.dart';

class MessageRepository {
  final String baseUrl = 'https://api.studenthub.dev/api';

  late HttpService httpService;

  MessageRepository() {
    httpService = HttpService();
  }

  Future<List<Conversation>> getAllConversationsInProject(int projectId) async {
    log('Getting all conversations in project');
    String url = '$baseUrl/message/$projectId';
    final response = await httpService.request(
      method: RequestMethod.get,
      url: url,
    );

    // Check if the response contains the expected 'result' key
    if (response.containsKey('result')) {
      try {
        // Attempt to parse the 'result' list into Conversation objects
        final List<Conversation> conversations = List<Conversation>.from(
          response['result'].map((json) {
            return Conversation(
              id: json['id'],
              content: json['content'].toString(),
              createdAt: json['createdAt'].toString(),
              sender: User(
                  fullname: json['sender']['fullname'],
                  id: json['sender']['id']),
              receiver: User(
                  fullname: json['receiver']['fullname'],
                  id: json['receiver']['id']),
              // Need to do interview
              // interview: json['interview'] != null
              //     ? Interview.fromJson(json['interview'])
              //     : null,
            );
          }),
        );

        return conversations; // Return the list of conversations
      } catch (e) {
        print('Error parsing conversations: $e');
        throw Exception('Error parsing conversations: $e');
      }
    } else {
      print('Response does not contain "result" key: $response');
      throw Exception('Response does not contain "result" key');
    }
  }
}
