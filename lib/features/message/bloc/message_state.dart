import 'package:equatable/equatable.dart';
import 'package:final_project_mobile/models/message.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object?> get props => [];
}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessageLoadSuccess extends MessageState {
  final List<dynamic> messages;

  const MessageLoadSuccess(this.messages);

  @override
  List<Object?> get props => [messages];
}

class MessageLoadFailure extends MessageState {
  final String error;

  const MessageLoadFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class ConversationLoadSuccess extends MessageState {
  final List<Conversation> conversations;

  const ConversationLoadSuccess(this.conversations);

  @override
  List<Object?> get props => [conversations];
}

class ConversationLoadFailure extends MessageState {
  final String error;

  const ConversationLoadFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class AllMessagesInConversationLoadSuccess extends MessageState {
  final List<Conversation> conversations;

  const AllMessagesInConversationLoadSuccess(this.conversations);

  @override
  List<Object?> get props => [conversations, DateTime.now()];
}

class AllMessagesInConversationLoadFailure extends MessageState {
  final String error;

  const AllMessagesInConversationLoadFailure(this.error);

  @override
  List<Object?> get props => [error, DateTime.now()];
}

// State for sending message
class MessageSendSuccess extends MessageState {}

class MessageSendFailure extends MessageState {
  final String error;

  const MessageSendFailure(this.error);

  @override
  List<Object?> get props => [error, DateTime.now()];
}

// State for interview
class InterviewCreateSuccess extends MessageState {
  final String roomCode;

  const InterviewCreateSuccess(this.roomCode);

  @override
  List<Object?> get props => [roomCode];
}

class InterviewOperationFailure extends MessageState {
  final String error;

  const InterviewOperationFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class InterviewDisableSuccess extends MessageState {
  final int interviewId;

  const InterviewDisableSuccess(this.interviewId);

  @override
  List<Object?> get props => [interviewId];
}

class InterviewDeleted extends MessageState {
  final int interviewId;

  const InterviewDeleted(this.interviewId);

  @override
  List<Object?> get props => [interviewId];
}

class InterviewUpdateSuccess extends MessageState {
  final int interviewId;

  const InterviewUpdateSuccess(this.interviewId);

  @override
  List<Object?> get props => [interviewId];
}
