import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, String>> notifications = [
    {
      'content': 'You have submitted to join project "Javis - AI Copilot"',
      'type': 'notification',
      'id': '1',
      'date': '2024-05-08'
    },
    {
      'content':
          'You have invited to interview for project "Javis - AI Copilot"',
      'type': 'interview',
      'id': '2',
      'date': '2024-05-08'
    },
    {
      'content': 'You have offered to join project "Javis - AI Copilot"',
      'type': 'offer',
      'id': '3',
      'date': '2024-05-08'
    },
    {
      'content': 'New message from Ngoc',
      'type': 'message',
      'id': '4',
      'date': '2024-05-08'
    },
  ];

  List<Map<String, String>> filterednotifications = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filterednotifications = notifications;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
                itemCount: filterednotifications.length,
                separatorBuilder: (context, index) =>
                    const Divider(color: Colors.grey),
                itemBuilder: (context, index) {
                  String formattedDate = DateFormat('dd/MM/yyyy').format(
                      DateTime.parse(filterednotifications[index]['date']!));

                  return ListTile(
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.blue[800],
                      child: Icon(
                        filterednotifications[index]['type'] == 'notification'
                            ? Icons.notification_important
                            : filterednotifications[index]['type'] ==
                                    'interview'
                                ? Icons.calendar_today
                                : filterednotifications[index]['type'] ==
                                        'offer'
                                    ? Icons.assignment
                                    : Icons.mail,
                        color: Colors.white,
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(
                          filterednotifications[index]['content']!,
                          softWrap: true,
                          style: TextStyle(
                              color: Colors.blue[800],
                              fontWeight: FontWeight.bold),
                        )),
                      ],
                    ),
                    subtitle: Text(formattedDate!),
                    onTap: () {
                      // Navigate to the message details page
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => MessageDetailsPage(message: filterednotifications[index]),
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
