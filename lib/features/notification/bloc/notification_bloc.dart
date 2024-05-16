import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project_mobile/features/notification/bloc/notification_event.dart';
import 'package:final_project_mobile/features/notification/repos/notification_repository.dart';
import 'package:final_project_mobile/models/notification.dart';
import 'package:nb_utils/nb_utils.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository notificationRepository =
      NotificationRepository();

  NotificationBloc({required NotificationRepository repository})
      : super(NotificationInitial()) {
    on<GetNotification>(_fetchNotification);
  }

  Future<void> _fetchNotification(
      GetNotification event, Emitter<NotificationState> emit) async {
    try {
      final notifications =
          await notificationRepository.getNotification(event.userId);
      emit(GetNotificationSuccess(notifications: notifications));
    } catch (error) {
      log('ERROR GET NOTIFICATION ${error.toString()}');
      emit(GetNotificationFailure(error: error.toString()));
    }
  }
}
