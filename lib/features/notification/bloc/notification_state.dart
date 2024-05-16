part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {}

class GetNotificationSuccess extends NotificationState {
  final List<Notification> notifications;

  const GetNotificationSuccess({required this.notifications});

  @override
  List<Object?> get props => [notifications];
}

class GetNotificationFailure extends NotificationState {
  final String error;

  const GetNotificationFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
