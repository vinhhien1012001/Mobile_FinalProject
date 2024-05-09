import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<Map<String, String>> messages = [
    {
      'name': 'Hien',
      'message': 'Hello, how are you?',
      'id': '1',
      'date': '2024-05-08'
    },
    {
      'name': 'Khoa',
      'message': 'This is a sample message',
      'id': '2',
      'date': '2024-05-08'
    },
    {
      'name': 'Ngoc',
      'message': 'Another message',
      'id': '3',
      'date': '2024-05-08'
    },
  ];

  List<Map<String, String>> filteredMessages = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredMessages = messages;
    searchController.addListener(searchMessages);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchMessages() {
    String searchText = searchController.text;
    if (searchText.isEmpty) {
      setState(() {
        filteredMessages = messages;
      });
    } else {
      setState(() {
        filteredMessages = messages
            .where((message) => message['name']!
                .toLowerCase()
                .contains(searchText.toLowerCase()))
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
              height: 40, // Adjust the height of the input field
              child: TextField(
                controller: searchController,
                style: const TextStyle(fontSize: 16), // Adjust text size
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 8), // Adjust vertical padding
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
                itemCount: filteredMessages.length,
                itemBuilder: (context, index) {
                  String formattedDate = DateFormat('dd/MM/yyyy')
                      .format(DateTime.parse(filteredMessages[index]['date']!));

                  return ListTile(
                    leading: CircleAvatar(
                        child: Text(filteredMessages[index]['name']![0])),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(filteredMessages[index]['name']!),
                        Text(formattedDate,
                            style: const TextStyle(fontSize: 13)),
                      ],
                    ),
                    subtitle: Text(filteredMessages[index]['message']!),
                    onTap: () {
                      // Navigate to the message details page
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => MessageDetailsPage(message: filteredMessages[index]),
                      //   ),
                      // );
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
