import 'package:final_project_mobile/pages/sub-pages/message_conversation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatParticipant {
  final String id;
  final String name;
  final List<Map<String, String>> messages;

  ChatParticipant({
    required this.id,
    required this.name,
    required this.messages,
  });
}

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  MessagePageState createState() => MessagePageState();
}

class MessagePageState extends State<MessagePage> {
  List<ChatParticipant> chatParticipants = [
    ChatParticipant(
      id: '1',
      name: 'Hien',
      messages: [
        {
          'name': 'Hien',
          'message': 'Hello, how are you?',
          'date': '2024-05-08'
        },
        {'name': 'Hien', 'message': 'How are you today?', 'date': '2024-05-09'},
        {'name': 'Minh', 'message': 'How are you today?', 'date': '2024-05-09'},
        {'name': 'Hien', 'message': 'No no', 'date': '2024-06-09'},
        {'name': 'Hien', 'message': 'No no', 'date': '2024-06-09'},

        // Add more messages here for Hien
      ],
    ),
    ChatParticipant(
      id: '2',
      name: 'Khoa',
      messages: [
        {
          'name': 'Khoa',
          'message': 'This is a sample message',
          'date': '2024-05-08'
        },
        // Add more messages here for Khoa
      ],
    ),
    ChatParticipant(
      id: '3',
      name: 'Ngoc',
      messages: [
        {'name': 'Ngoc', 'message': 'Another message', 'date': '2024-05-08'},
        // Add more messages here for Ngoc
      ],
    ),
    // Add more chat participants as needed
  ];

  List<ChatParticipant> filteredChatParticipants = [];

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredChatParticipants = chatParticipants;
    searchController.addListener(searchParticipants);
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
        filteredChatParticipants = chatParticipants;
      });
    } else {
      setState(() {
        filteredChatParticipants = chatParticipants
            .where((participant) =>
                participant.name.toLowerCase().contains(searchText))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              itemCount: filteredChatParticipants.length,
              itemBuilder: (context, index) {
                ChatParticipant participant = filteredChatParticipants[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(participant.name[0])),
                  title: Text(participant.name),
                  subtitle: Text(participant.messages.isNotEmpty
                      ? '${participant.messages.last['name']}: ${participant.messages.last['message']}'
                      : ''),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          key: Key(participant.id),
                          currentUser: 'Minh',
                          messages: participant.messages,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
