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
  final String message;

  const SendMessage(this.message);

  @override
  List<Object?> get props => [message];
}
