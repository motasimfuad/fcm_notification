import 'package:fcm_notification/features/notification/domain/entities/notification_entity.dart';

abstract class NotificationLocalDatasources {
  Future<List<NotificationEntity>> getAppsNotifications(
      {required String appId});
  Future<NotificationEntity> getNotification({required String notificationId});
  Future<void> createNotification({required NotificationEntity notification});
  Future<void> updateNotification({required NotificationEntity notification});
  Future<void> deleteNotification({required String notificationId});
}
