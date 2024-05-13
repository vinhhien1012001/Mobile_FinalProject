import 'dart:developer';

import 'package:final_project_mobile/features/message/bloc/message_event.dart';
import 'package:final_project_mobile/features/message/bloc/message_state.dart';
import 'package:final_project_mobile/features/message/repos/message_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository messageRepository;

  MessageBloc({required this.messageRepository}) : super(MessageInitial()) {
    on<GetAllConversationsByProjectId>(_getAllConversationsByProjectId);
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
}
