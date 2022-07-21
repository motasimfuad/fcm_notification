import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:fcm_notification/features/notification/domain/usecases/create_notification_usecase.dart';
import 'package:fcm_notification/features/notification/domain/usecases/delete_notification_usecase.dart';
import 'package:fcm_notification/features/notification/domain/usecases/get_app_notifications_usecase.dart';
import 'package:fcm_notification/features/notification/domain/usecases/get_notification_usecase.dart';
import 'package:fcm_notification/features/notification/domain/usecases/update_notification_usecase.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/notification_entity.dart';

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
      // get apps notifications
      if (event is GetAppNotificationsEvent) {
        emit(NotificationListLoading());
        final notifications = await getAppsNotifications(Params(
          id: event.appId,
        ));
        notifications.fold(
          (l) => emit(NotificationListLoadingFailed(message: l.toString())),
          (r) => emit(NotificationListLoaded(notifications: r)),
        );
      }

      // create notification
      if (event is CreateNotificationEvent) {
        emit(NotificationLoading());
        final notification = await createNotification(Params(
          notification: event.notification,
        ));
        notification.fold(
          (l) => emit(NotificationCreatingFailed(message: l.toString())),
          (r) => emit(NotificationCreatedState()),
        );
      }

      // delete notification
      if (event is DeleteNotificationEvent) {
        final deleted = await deleteNotification(Params(
          id: event.id,
        ));
        deleted.fold(
          (l) => emit(NotificationDeletingFailed(message: l.toString())),
          (r) => emit(NotificationDeletedState()),
        );
      }

      // duplicate notification
      if (event is DuplicateNotificationEvent) {
        final notification = event.notification;
        NotificationEntity duplicatedNotification = NotificationEntity(
          appId: notification.appId,
          id: const Uuid().v1(),
          name: '${notification.name} (duplicated)',
          topicName: notification.topicName,
          deviceId: notification.deviceId,
          title: notification.title,
          body: notification.body,
          imageUrl: notification.imageUrl,
          dataKey: notification.dataKey,
          dataValue: notification.dataValue,
          lastSentAt: null,
          createdAt: DateTime.now(),
        );

        final duplicated = await createNotification(Params(
          notification: duplicatedNotification,
        ));
        duplicated.fold(
          (l) => emit(NotificationDuplicatingFailed(message: l.toString())),
          (r) => emit(NotificationDuplicatedState()),
        );
      }
    });
  }
}
