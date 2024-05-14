// ignore_for_file: use_build_context_synchronously

import 'package:final_project_mobile/features/message/bloc/message_bloc.dart';
import 'package:final_project_mobile/features/message/bloc/message_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NewInterviewDialog extends StatefulWidget {
  final int projectId;
  final int senderId;
  final int receiverId;
  const NewInterviewDialog({
    super.key,
    required this.projectId,
    required this.senderId,
    required this.receiverId,
  });
  @override
  NewInterviewDialogState createState() => NewInterviewDialogState();
}

class NewInterviewDialogState extends State<NewInterviewDialog> {
  late TextEditingController _titleController;
  late TextEditingController _meetingCodeController;
  late TextEditingController _meetingRoomController;
  late TextEditingController _contentController;
  late DateTime _startDate;
  late DateTime _endDate;
  late DateTime _expireDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _meetingCodeController = TextEditingController();
    _meetingRoomController = TextEditingController();
    _contentController = TextEditingController();
    _startDate = DateTime.now();
    _endDate = DateTime.now().add(const Duration(hours: 1));
    _expireDate = DateTime.now().add(const Duration(days: 1));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Interview'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _meetingCodeController,
              decoration: const InputDecoration(labelText: 'Meeting Code'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _meetingRoomController,
              decoration: const InputDecoration(labelText: 'Meeting Room'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Content'),
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
                  label:
                      Text(DateFormat('MM/dd/yyyy HH:mm').format(_startDate)),
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
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Expire:'),
                const SizedBox(width: 12),
                TextButton.icon(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: _expireDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      final selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(_expireDate),
                      );
                      if (selectedTime != null) {
                        setState(() {
                          _expireDate = DateTime(
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
                  label:
                      Text(DateFormat('MM/dd/yyyy HH:mm').format(_expireDate)),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Submit button action
            String title = _titleController.text.trim();
            String meetingCode = _meetingCodeController.text.trim();
            String meetingRoom = _meetingRoomController.text.trim();
            String content = _contentController.text.trim();
            if (title.isNotEmpty) {
              // Create the interview with the provided details
              // You can handle the creation logic here
              BlocProvider.of<MessageBloc>(context).add(
                CreateNewInterview(
                  title: title,
                  content: content,
                  startTime: _startDate.toIso8601String(),
                  endTime: _endDate.toIso8601String(),
                  projectId: widget.projectId,
                  senderId: widget.senderId,
                  receiverId: widget.receiverId,
                  roomCode: meetingCode,
                  roomId: meetingRoom,
                  expiredAt: _expireDate.toIso8601String(),
                ),
              );
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
    _meetingCodeController.dispose();
    _meetingRoomController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
