class Interview {
  final String title;
  final String content;
  final String startTime;
  final String endTime;
  final int projectId;
  final int senderId;
  final int receiverId;
  final String? meetingRoomCode;
  final String? meetingRoomId;

  Interview({
    required this.title,
    required this.content,
    required this.startTime,
    required this.endTime,
    required this.projectId,
    required this.senderId,
    required this.receiverId,
    required this.meetingRoomCode,
    required this.meetingRoomId,
  });

  factory Interview.fromJson(Map<String, dynamic> json) {
    return Interview(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      projectId: json['projectId'] ?? 0,
      senderId: json['senderId'] ?? 0,
      receiverId: json['receiverId'] ?? 0,
      meetingRoomCode: json['meeting_room_code'] ?? '',
      meetingRoomId: json['meeting_room_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'startTime': startTime,
      'endTime': endTime,
      'projectId': projectId,
      'senderId': senderId,
      'receiverId': receiverId,
      'meeting_room_code': meetingRoomCode,
      'meeting_room_id': meetingRoomId,
    };
  }
}
