import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InterviewCard extends StatelessWidget {
  final String title;
  final String startTime;
  final String endTime;
  final String roomCode;
  final String roomId;
  final Function()? onDelete;
  final Function()? onUpdate;
  final Function()? onDisable;

  const InterviewCard({
    super.key,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.roomCode,
    required this.roomId,
    this.onDelete,
    this.onUpdate,
    this.onDisable,
  });

  @override
  Widget build(BuildContext context) {
    final startDateTime = DateTime.parse(startTime);
    final endDateTime = DateTime.parse(endTime);

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PopupMenuButton<int>(
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text('Delete this interview'),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text('Update this interview'),
                    ),
                    const PopupMenuItem<int>(
                      value: 2,
                      child: Text('Disable this interview'),
                    ),
                  ],
                  onSelected: (value) {
                    switch (value) {
                      case 0:
                        onDelete?.call();
                        break;
                      case 1:
                        onUpdate?.call();
                        break;
                      case 2:
                        onDisable?.call();
                        break;
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.schedule, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  DateFormat('hh:mm a').format(startDateTime),
                  style: const TextStyle(fontSize: 16),
                ),
                const Text(' - '),
                Text(
                  DateFormat('hh:mm a').format(endDateTime),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  DateFormat('MMM dd, yyyy').format(startDateTime),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.meeting_room, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  roomCode,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.confirmation_number, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  roomId,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
