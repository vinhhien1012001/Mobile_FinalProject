import 'package:equatable/equatable.dart';
// import 'package:final_project_mobile/models/student.dart';
// import 'package:final_project_mobile/models/user_profile.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class GetNotification extends NotificationEvent {
  final int userId;

  const GetNotification({required this.userId});

  @override
  List<Object> get props => [userId];
}
