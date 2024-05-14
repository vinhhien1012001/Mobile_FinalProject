class Conversation {
  final int? id;
  final String? createdAt;
  final String content;
  final User sender;
  final User receiver;
  final Interview? interview;

  Conversation({
    this.id,
    required this.content,
    this.createdAt,
    required this.sender,
    required this.receiver,
    this.interview,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'],
      content: json['content'],
      createdAt: json['createdAt'],
      sender: User.fromJson(json['sender']),
      receiver: User.fromJson(json['receiver']),
      interview: json['interview'] != null
          ? Interview(
              createdAt: json['interview']['createdAt'],
              updatedAt: json['interview']['updatedAt'],
              deletedAt: json['interview']['deletedAt'],
              title: json['interview']['title'],
              startTime: json['interview']['startTime'],
              endTime: json['interview']['endTime'],
              disableFlag: json['interview']['disableFlag'],
              meetingRoomId: json['interview']['meetingRoomId'],
              meetingRoom:
                  MeetingRoom.fromJson(json['interview']['meetingRoom']),
              id: json['interview']['id'])
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'content': content,
      'sender': sender.toJson(),
      'receiver': receiver.toJson(),
    };
  }

  @override
  String toString() {
    return 'Conversation{id: $id, content: $content, createdAt: $createdAt, sender: $sender, receiver: $receiver}';
  }
}

class User {
  final int id;
  final String fullname;

  User({
    required this.id,
    required this.fullname,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullname: json['fullname'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, fullname: $fullname}';
  }
}

class MeetingRoom {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String meetingRoomCode;
  final String meetingRoomId;
  final String expiredAt;

  MeetingRoom({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.meetingRoomCode,
    required this.meetingRoomId,
    required this.expiredAt,
  });

  factory MeetingRoom.fromJson(Map<String, dynamic> json) {
    return MeetingRoom(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      meetingRoomCode: json['meeting_room_code'],
      meetingRoomId: json['meeting_room_id'],
      expiredAt: json['expired_at'],
    );
  }
}

class Interview {
  final int id;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String? title;
  final String? startTime;
  final String? endTime;
  final int? disableFlag;
  final int? meetingRoomId;
  final MeetingRoom? meetingRoom;

  Interview({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.title,
    this.startTime,
    this.endTime,
    this.disableFlag,
    this.meetingRoomId,
    this.meetingRoom,
  });

  factory Interview.fromJson(Map<String, dynamic> json) {
    return Interview(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      title: json['title'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      disableFlag: json['disableFlag'],
      meetingRoomId: json['meetingRoomId'],
      meetingRoom: MeetingRoom.fromJson(json['meetingRoom']),
    );
  }
}
