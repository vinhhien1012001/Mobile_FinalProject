// ignore_for_file: use_build_context_synchronously

import 'package:final_project_mobile/features/message/bloc/message_bloc.dart';
import 'package:final_project_mobile/features/message/bloc/message_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UpdateInterviewDialog extends StatefulWidget {
  final int projectId;
  final int senderId;
  final int receiverId;
  final int interviewId;
  const UpdateInterviewDialog({
    super.key,
    required this.projectId,
    required this.senderId,
    required this.receiverId,
    required this.interviewId,
  });
  @override
  UpdateInterviewDialogState createState() => UpdateInterviewDialogState();
}

class UpdateInterviewDialogState extends State<UpdateInterviewDialog> {
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
      title: const Text('Update Interview'),
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
            // Row(
            //   children: [
            //     const Text('Expire:'),
            //     const SizedBox(width: 12),
            //     TextButton.icon(
            //       onPressed: () async {
            //         final selectedDate = await showDatePicker(
            //           context: context,
            //           initialDate: _expireDate,
            //           firstDate: DateTime(2000),
            //           lastDate: DateTime(2100),
            //         );
            //         if (selectedDate != null) {
            //           final selectedTime = await showTimePicker(
            //             context: context,
            //             initialTime: TimeOfDay.fromDateTime(_expireDate),
            //           );
            //           if (selectedTime != null) {
            //             setState(() {
            //               _expireDate = DateTime(
            //                 selectedDate.year,
            //                 selectedDate.month,
            //                 selectedDate.day,
            //                 selectedTime.hour,
            //                 selectedTime.minute,
            //               );
            //             });
            //           }
            //         }
            //       },
            //       icon: const Icon(Icons.calendar_today),
            //       label:
            //           Text(DateFormat('MM/dd/yyyy HH:mm').format(_expireDate)),
            //     ),
            //   ],
            // ),
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

            if (title.isNotEmpty) {
              // Update the interview with the provided details
              BlocProvider.of<MessageBloc>(context).add(
                UpdateInterview(
                  interviewId: widget.interviewId,
                  title: title,
                  startTime: _startDate.toIso8601String(),
                  endTime: _endDate.toIso8601String(),
                  projectId: widget.projectId,
                  recipientId: widget.receiverId,
                ),
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('Update'),
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
