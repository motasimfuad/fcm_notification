import 'package:fcm_notification/features/notification/domain/entities/notification_entity.dart';

abstract class NotificationLocalDatasources {
  Future<List<NotificationEntity>> getAppsNotifications(
      {required String appId});
  Future<NotificationEntity> getNotification({required String notificationId});
  Future<void> createNotification({required NotificationEntity notification});
  Future<void> updateNotification({required NotificationEntity notification});
  Future<void> deleteNotification({required String notificationId});
}

class NotificationLocalDatasourcesImpl implements NotificationLocalDatasources {
  @override
  Future<void> createNotification(
      {required NotificationEntity notification}) async {}

  @override
  Future<void> deleteNotification({required String notificationId}) {
    // TODO: implement deleteNotification
    throw UnimplementedError();
  }

  @override
  Future<List<NotificationEntity>> getAppsNotifications(
      {required String appId}) {
    // TODO: implement getAppsNotifications
    throw UnimplementedError();
  }

  @override
  Future<NotificationEntity> getNotification({required String notificationId}) {
    // TODO: implement getNotification
    throw UnimplementedError();
  }

  @override
  Future<void> updateNotification({required NotificationEntity notification}) {
    // TODO: implement updateNotification
    throw UnimplementedError();
  }
}
