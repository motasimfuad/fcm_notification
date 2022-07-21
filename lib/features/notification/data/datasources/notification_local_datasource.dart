import 'package:hive/hive.dart';

import 'package:fcm_notification/features/notification/data/models/notification_model.dart';

abstract class NotificationLocalDatasource {
  Future<List<NotificationModel>> getAppNotifications({required String appId});
  Future<void> deleteAppNotifications({required String appId});
  Future<NotificationModel> getNotification({required String notificationId});
  Future<void> createNotification({required NotificationModel notification});
  Future<void> updateNotification({required NotificationModel notification});
  Future<void> deleteNotification({required String notificationId});
}

class NotificationLocalDatasourceImpl implements NotificationLocalDatasource {
  Box<NotificationModel> notificationBox;
  NotificationLocalDatasourceImpl({
    required this.notificationBox,
  });

  @override
  Future<void> createNotification(
      {required NotificationModel notification}) async {
    return await notificationBox.put(notification.id, notification);
  }

  @override
  Future<void> deleteNotification({required String notificationId}) async {
    return await notificationBox.delete(notificationId);
  }

  @override
  Future<List<NotificationModel>> getAppNotifications(
      {required String appId}) async {
    return notificationBox.values
        .where((element) => element.appId == appId)
        .toList();
  }

  @override
  Future<void> deleteAppNotifications({required String appId}) async {
    final notifications = notificationBox.values
        .where((element) => element.appId == appId)
        .map((e) => e.id);
    return await notificationBox.deleteAll(notifications);
  }

  @override
  Future<NotificationModel> getNotification(
      {required String notificationId}) async {
    return await Future.value(notificationBox.get(notificationId));
  }

  @override
  Future<void> updateNotification(
      {required NotificationModel notification}) async {
    return await notificationBox.put(notification.id, notification);
  }
}
