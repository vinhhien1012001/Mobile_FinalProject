import 'dart:developer';

import 'package:final_project_mobile/features/message/bloc/message_bloc.dart';
import 'package:final_project_mobile/features/message/bloc/message_event.dart';
import 'package:final_project_mobile/features/message/bloc/message_state.dart';
import 'package:final_project_mobile/features/user/bloc/user_bloc.dart';
import 'package:final_project_mobile/models/message.dart';
import 'package:final_project_mobile/models/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MessagesDetails extends StatefulWidget {
  final int projectId;
  final int recipientId;
  const MessagesDetails({
    super.key,
    required this.projectId,
    required this.recipientId,
  });

  @override
  State<MessagesDetails> createState() => _MessagesDetailsState();
}

class _MessagesDetailsState extends State<MessagesDetails> {
  final TextEditingController _messageController = TextEditingController();
  late List<Conversation> conversations = [];
  late final UserProfile sender;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MessageBloc>(context).add(
      GetAllMessagesInConversation(
        widget.projectId,
        widget.recipientId,
      ),
    );
    sender = BlocProvider.of<UserProfileBloc>(context).state.userProfile;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageBloc, MessageState>(
      listener: (context, state) {
        if (state is AllMessagesInConversationLoadSuccess) {
          conversations = state.conversations;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Chat'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      Conversation conversation = conversations[index];
                      String senderName = conversation.sender.fullname ?? '';
                      String formattedDate =
                          DateFormat('HH:mm           dd/MM').format(
                        DateTime.parse(conversation.createdAt ?? '').toLocal(),
                      );

                      bool isCurrentUser = conversation.sender.id == sender.id;

                      return Align(
                        alignment: isCurrentUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: isCurrentUser
                                ? Colors.blue[100]
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isCurrentUser ? 'You' : senderName,
                                style: TextStyle(
                                  fontWeight: isCurrentUser
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isCurrentUser
                                      ? Colors.blue
                                      : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                conversation.content ?? '',
                              ),
                              const SizedBox(height: 4),
                              Text(
                                formattedDate,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    FloatingActionButton(
                      onPressed: () {
                        // Open dialog to create a new interview
                        showDialog(
                          context: context,
                          builder: (context) => const NewInterviewDialog(),
                        );
                      },
                      child: const Icon(Icons.add),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        // Handle send message action here
                        String message = _messageController.text;
                        if (message.isNotEmpty) {
                          BlocProvider.of<MessageBloc>(context).add(
                            SendMessage(
                              content: message,
                              messageFlag: 0,
                              projectId: widget.projectId,
                              receiverId: widget.recipientId,
                              senderId: 352,
                            ),
                          );
                          _messageController.clear();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class NewInterviewDialog extends StatefulWidget {
  const NewInterviewDialog({super.key});

  @override
  NewInterviewDialogState createState() => NewInterviewDialogState();
}

class NewInterviewDialogState extends State<NewInterviewDialog> {
  late TextEditingController _titleController;
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _startDate = DateTime.now();
    _endDate = DateTime.now().add(const Duration(hours: 1));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Interview'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text('Start:'),
              const SizedBox(width: 12),
              TextButton.icon(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _startDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    final selectedTime = await showTimePicker(
                      // ignore: use_build_context_synchronously
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(_startDate),
                    );
                    if (selectedTime != null) {
                      setState(() {
                        _startDate = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
                      });
                    }
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(DateFormat('MM/dd/yyyy HH:mm').format(_startDate)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text('End:'),
              const SizedBox(width: 12),
              TextButton.icon(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _endDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    final selectedTime = await showTimePicker(
                      // ignore: use_build_context_synchronously
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(_endDate),
                    );
                    if (selectedTime != null) {
                      setState(() {
                        _endDate = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
                      });
                    }
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(DateFormat('MM/dd/yyyy HH:mm').format(_endDate)),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Cancel button action
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Submit button action
            String title = _titleController.text.trim();
            if (title.isNotEmpty) {
              // Create the interview with the provided details
              // You can handle the creation logic here
              Navigator.of(context).pop();
            }
          },
          child: const Text('Create'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}
