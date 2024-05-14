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
        log('Error parsing conversations: $e');
        throw Exception('Error parsing conversations: $e');
      }
    } else {
      log('Response does not contain "result" key: $response');
      throw Exception('Response does not contain "result" key');
    }
  }

  Future<List<Conversation>> getMessagesInConversation(
      int projectId, int recipientId) async {
    log('Getting all messages in conversation');
    String url = '$baseUrl/message/$projectId/user/$recipientId';
    final response = await httpService.request(
      method: RequestMethod.get,
      url: url,
    );
    List<dynamic> _conversations = (response['result'] as List);
    log('conversations up here: $_conversations');
    final conversations = (response['result'] as List)
        .map((json) => Conversation.fromJson(json))
        .toList();
    log('conversations here: $conversations');
    return conversations;
  }

  Future<void> sendMessage(
    int projectId,
    int receiverId,
    int senderId,
    String content,
    int messageFlag,
  ) async {
    log('Sending message');
    String url = '$baseUrl/message/sendMessage';
    final response = await httpService.request(
      method: RequestMethod.post,
      url: url,
      body: {
        'projectId': projectId,
        'receiverId': receiverId,
        'senderId': senderId,
        'content': content,
        'messageFlag': messageFlag ?? 0,
      },
    );
    log('Response from sending message: $response');
  }
}
