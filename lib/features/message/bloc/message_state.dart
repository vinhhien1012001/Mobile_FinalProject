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
