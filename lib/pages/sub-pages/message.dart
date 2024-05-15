import 'dart:developer';

import 'package:final_project_mobile/features/message/bloc/message_bloc.dart';
import 'package:final_project_mobile/features/message/bloc/message_event.dart';
import 'package:final_project_mobile/features/message/bloc/message_state.dart';
import 'package:final_project_mobile/models/message.dart';
import 'package:final_project_mobile/pages/sub-pages/message_conversation.dart';
import 'package:final_project_mobile/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key, required this.projectId});

  final int projectId;

  @override
  MessagePageState createState() => MessagePageState();
}

class MessagePageState extends State<MessagePage> {
  List<Conversation> conversations = [];

  List<Conversation> filteredConversations = [];

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredConversations = conversations;
    searchController.addListener(searchParticipants);

    BlocProvider.of<MessageBloc>(context)
        .add(GetAllConversationsByProjectId(widget.projectId));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchParticipants() {
    String searchText = searchController.text.toLowerCase();
    if (searchText.isEmpty) {
      setState(() {
        filteredConversations = conversations;
      });
    } else {
      setState(() {
        filteredConversations = conversations
            .where((participant) => participant.receiver.fullname
                .toLowerCase()
                .contains(searchText))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageBloc, MessageState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ConversationLoadSuccess) {
          conversations = state.conversations;
          log('Conversations: $conversations');
          filteredConversations = conversations;
        }
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: searchController,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredConversations.length,
                  itemBuilder: (context, index) {
                    Conversation participant = filteredConversations[index];
                    return ListTile(
                      leading: CircleAvatar(
                          child: Text(participant.receiver.id.toString())),
                      title: Text(participant.receiver.fullname),
                      subtitle: Text(participant.content ?? ''),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.messageConversation,
                          arguments: {
                            'projectId': widget.projectId,
                            'recipientId': participant.receiver.id,
                          },
                          // MaterialPageRoute(
                          //   builder: (context) => MessagesDetails(
                          //     projectId: widget.projectId,
                          //     recipientId: participant.receiver.id,
                          //   ),
                          // ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
