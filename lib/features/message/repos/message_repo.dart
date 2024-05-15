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

  Future<void> createNewInterview(
    String title,
    String content,
    String startTime,
    String endTime,
    int projectId,
    int senderId,
    int receiverId,
    String roomCode,
    String roomId,
    String expiredAt,
  ) async {
    log('createNewInterview here');
    String url = '$baseUrl/interview';
    final response = await httpService.request(
      method: RequestMethod.post,
      url: url,
      body: {
        'title': title,
        'content': content,
        'startTime': startTime,
        'endTime': endTime,
        'projectId': projectId,
        'senderId': senderId,
        'receiverId': receiverId,
        'meeting_room_code': roomCode,
        'meeting_room_id': roomId,
        'expired_at': expiredAt,
      },
    );
    log('Response from sending message: $response');
  }

  // Checked
  Future<void> disableInterview(int interviewId) async {
    String url = '$baseUrl/interview/$interviewId/disable';
    final response = await httpService
        .request(method: RequestMethod.patch, url: url, body: {});
    log('Response from disable interviewId: $response');
  }

  // Checked
  Future<void> deleteInterview(int interviewId) async {
    log('delete Interview here');
    String url = '$baseUrl/interview/$interviewId';
    final response = await httpService.request(
      method: RequestMethod.delete,
      url: url,
    );
    log('Response from delete interviewId: $response');
  }

  // Not checked yet
  Future<List<Interview>> getAllInterviewsOfUserByUserId(int userId) async {
    log('Getting all interviews of user by userId');
    String url = '$baseUrl/interview/user/$userId';
    final response = await httpService.request(
      method: RequestMethod.get,
      url: url,
    );
    log('Response from getting all interviews of user by userId: $response');
    final interviews = (response['result'] as List)
        .map((json) => Interview.fromJson(json))
        .toList();
    log('Interviews: $interviews');
    return interviews;
  }

  Future<void> updateInterview(
    int interviewId,
    String title,
    String startTime,
    String endTime,
  ) async {
    log('updateInterview here');
    String url = '$baseUrl/interview/$interviewId';
    final response = await httpService.request(
      method: RequestMethod.patch,
      url: url,
      body: {
        'title': title,
        'startTime': startTime,
        'endTime': endTime,
      },
    );
    log('Response from update interviewId: $response');
  }
}
