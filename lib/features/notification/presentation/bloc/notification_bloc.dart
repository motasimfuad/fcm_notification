import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'package:fcm_notification/features/notification/domain/usecases/create_notification_usecase.dart';
import 'package:fcm_notification/features/notification/domain/usecases/delete_app_notifications_usecase.dart';
import 'package:fcm_notification/features/notification/domain/usecases/delete_notification_usecase.dart';
import 'package:fcm_notification/features/notification/domain/usecases/get_app_notifications_usecase.dart';
import 'package:fcm_notification/features/notification/domain/usecases/get_notification_usecase.dart';
import 'package:fcm_notification/features/notification/domain/usecases/send_notification_usecase.dart';
import 'package:fcm_notification/features/notification/domain/usecases/update_notification_usecase.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/notification_entity.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final CreateNotificationUsecase createNotification;
  final UpdateNotificationUsecase updateNotification;
  final GetAppNotificationsUsecase getAppsNotifications;
  final GetNotificationUsecase getNotification;
  final DeleteNotificationUsecase deleteNotification;
  final DeleteAppNotificationsUsecase deleteAppNotifications;
  final SendNotificationUsecase sendNotification;

  NotificationBloc({
    required this.createNotification,
    required this.updateNotification,
    required this.getAppsNotifications,
    required this.getNotification,
    required this.deleteNotification,
    required this.deleteAppNotifications,
    required this.sendNotification,
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

      // delete app notifications
      if (event is DeleteAppNotificationsEvent) {
        final deleted = await deleteAppNotifications(Params(
          id: event.appId,
        ));
        deleted.fold(
          (l) => emit(NotificationDeletingFailed(message: l.toString())),
          (r) => emit(NotificationDeletedState()),
        );
      }

      // get notification
      if (event is GetNotificationEvent) {
        emit(NotificationLoading());
        final notification = await getNotification(Params(
          id: event.id,
        ));
        notification.fold(
          (l) => emit(NotificationLoadingFailed(message: l.toString())),
          (r) => emit(NotificationLoadedState(notification: r)),
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
          name: '${notification.name} - (duplicated)',
          topicName: notification.topicName,
          deviceId: notification.deviceId,
          title: notification.title,
          body: notification.body,
          imageUrl: notification.imageUrl,
          dataKey: notification.dataKey,
          dataValue: notification.dataValue,
          lastSentAt: null,
          createdAt: DateTime.now(),
          notificationType: notification.notificationType,
          receiverType: notification.receiverType,
        );

        final duplicated = await createNotification(Params(
          notification: duplicatedNotification,
        ));
        duplicated.fold(
          (l) => emit(NotificationDuplicatingFailed(message: l.toString())),
          (r) => emit(NotificationDuplicatedState()),
        );
      }

      // edit notification
      if (event is EditNotificationEvent) {
        emit(NotificationLoading());
        final updated = await updateNotification(Params(
          notification: event.notification,
        ));
        updated.fold(
          (l) => emit(NotificationEditingFailed(message: l.toString())),
          (r) => emit(NotificationEditedState()),
        );
      }

      // send notification
      if (event is SendNotificationEvent) {
        emit(NotificationSendingState());
        final sent = await sendNotification(Params(
          notification: event.notification,
          serverKey: event.serverKey,
        ));
        sent.fold(
          (l) => emit(NotificationSendingFailed(message: l.toString())),
          (r) {
            NotificationEntity notification = event.notification;

            NotificationEntity updateSentNotification = NotificationEntity(
              appId: notification.appId,
              id: notification.id,
              name: notification.name,
              topicName: notification.topicName,
              deviceId: notification.deviceId,
              title: notification.title,
              body: notification.body,
              imageUrl: notification.imageUrl,
              dataKey: notification.dataKey,
              dataValue: notification.dataValue,
              lastSentAt: DateTime.now(),
              createdAt: notification.createdAt,
              notificationType: notification.notificationType,
              receiverType: notification.receiverType,
            );

            emit(NotificationSentState(notification: updateSentNotification));
          },
        );
      }

      // toggle notification sound
      if (event is ToggleNotificationSoundEvent) {
        emit(NotificationSoundLoadingState());
        emit(NotificationSoundToggledState(
            soundIsOn: (event.index == 1) ? true : false));
      }
    });
  }
}
