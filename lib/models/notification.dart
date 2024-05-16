import 'package:final_project_mobile/models/message.dart';

class Notification {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final int receiverId;
  final int senderId;
  final int messageId;
  final String title;
  final String notifyFlag;
  final String typeNotifyFlag;
  final String content;
  final Conversation message;
  final User sender;
  final User receiver;

  Notification({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.receiverId,
    required this.senderId,
    required this.messageId,
    required this.title,
    required this.notifyFlag,
    required this.typeNotifyFlag,
    required this.content,
    required this.message,
    required this.sender,
    required this.receiver,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      receiverId: json['receiverId'],
      senderId: json['senderId'],
      messageId: json['messageId'],
      title: json['title'],
      notifyFlag: json['notifyFlag'],
      typeNotifyFlag: json['typeNotifyFlag'],
      content: json['content'],
      message: Conversation.fromJson(json['message']),
      sender: User.fromJson(json['sender']),
      receiver: User.fromJson(json['receiver']),
    );
  }
}
