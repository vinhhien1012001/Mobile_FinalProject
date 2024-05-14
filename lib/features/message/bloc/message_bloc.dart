import 'dart:developer';

import 'package:final_project_mobile/features/message/bloc/message_event.dart';
import 'package:final_project_mobile/features/message/bloc/message_state.dart';
import 'package:final_project_mobile/features/message/repos/message_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository messageRepository;

  MessageBloc({required this.messageRepository}) : super(MessageInitial()) {
    on<GetAllConversationsByProjectId>(_getAllConversationsByProjectId);
    on<GetAllMessagesInConversation>(_getAllMessagesInConversation);
    on<SendMessage>(_sendMessage);
  }

  Future<void> _getAllConversationsByProjectId(
      GetAllConversationsByProjectId event, Emitter<MessageState> emit) async {
    try {
      final conversations =
          await messageRepository.getAllConversationsInProject(event.projectId);
      emit(ConversationLoadSuccess(conversations));
    } catch (error) {
      emit(ConversationLoadFailure(error.toString()));
    }
  }

  Future<void> _getAllMessagesInConversation(
      GetAllMessagesInConversation event, Emitter<MessageState> emit) async {
    try {
      final conversations = await messageRepository.getMessagesInConversation(
          event.projectId, event.recipientId);
      log('Getting all messages in conversation: $conversations');
      emit(AllMessagesInConversationLoadSuccess(conversations));
    } catch (error) {
      emit(AllMessagesInConversationLoadFailure(error.toString()));
    }
  }

  Future<void> _sendMessage(
      SendMessage event, Emitter<MessageState> emit) async {
    log('Sending message: $event');
    try {
      await messageRepository.sendMessage(event.projectId, event.receiverId,
          event.senderId, event.content, event.messageFlag);
      emit(MessageSendSuccess());

      final conversations = await messageRepository.getMessagesInConversation(
          event.projectId, event.receiverId);
      emit(AllMessagesInConversationLoadSuccess(conversations));
    } catch (error) {
      emit(MessageSendFailure(error.toString()));
    }
  }
}
