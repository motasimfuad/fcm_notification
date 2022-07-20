import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:fcm_notification/features/notification/domain/usecases/create_notification_usecase.dart';
import 'package:fcm_notification/features/notification/domain/usecases/delete_notification_usecase.dart';
import 'package:fcm_notification/features/notification/domain/usecases/get_app_notifications_usecase.dart';
import 'package:fcm_notification/features/notification/domain/usecases/get_notification_usecase.dart';
import 'package:fcm_notification/features/notification/domain/usecases/update_notification_usecase.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final CreateNotificationUsecase createNotification;
  final UpdateNotificationUsecase updateNotification;
  final GetAppsNotificationsUsecase getAppsNotifications;
  final GetNotificationUsecase getNotification;
  final DeleteNotificationUsecase deleteNotification;

  NotificationBloc({
    required this.createNotification,
    required this.updateNotification,
    required this.getAppsNotifications,
    required this.getNotification,
    required this.deleteNotification,
  }) : super(NotificationInitial()) {
    on<NotificationEvent>((event, emit) async {
      // TODO: implement event handler
    });
  }
}
