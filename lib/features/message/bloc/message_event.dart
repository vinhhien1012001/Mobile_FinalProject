import 'package:equatable/equatable.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object?> get props => [];
}

class GetAllConversationsByProjectId extends MessageEvent {
  final int projectId;

  const GetAllConversationsByProjectId(this.projectId);

  @override
  List<Object?> get props => [projectId];
}

class GetMessageByProjectIdAndUserId extends MessageEvent {
  final int projectId;
  final String userId;

  const GetMessageByProjectIdAndUserId(this.projectId, this.userId);

  @override
  List<Object?> get props => [projectId, userId];
}

class GetAllMessages extends MessageEvent {}

class GetMessageByPage extends MessageEvent {}

class SendMessage extends MessageEvent {
  final int projectId;
  final int receiverId;
  final int senderId;
  final String content;
  final int messageFlag;

  const SendMessage({
    required this.projectId,
    required this.receiverId,
    required this.senderId,
    required this.content,
    required this.messageFlag,
  });

  @override
  List<Object?> get props =>
      [projectId, receiverId, senderId, content, messageFlag];
}

class GetAllMessagesInConversation extends MessageEvent {
  final int projectId;
  final int recipientId;

  const GetAllMessagesInConversation(this.projectId, this.recipientId);

  @override
  List<Object?> get props => [projectId, recipientId];
}
