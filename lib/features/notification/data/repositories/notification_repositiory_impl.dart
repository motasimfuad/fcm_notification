import 'package:dartz/dartz.dart';
import 'package:dio/src/response.dart';

import 'package:fcm_notification/core/errors/exceptions.dart';
import 'package:fcm_notification/core/errors/failures.dart';
import 'package:fcm_notification/features/notification/data/datasources/notification_local_datasource.dart';
import 'package:fcm_notification/features/notification/data/models/notification_model.dart';
import 'package:fcm_notification/features/notification/domain/entities/notification_entity.dart';
import 'package:fcm_notification/features/notification/domain/repositories/notification_repository.dart';

import '../datasources/notification_remote_datasource.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationLocalDatasource notificationLocalData;
  final NotificationRemoteDatasource notificationRemoteData;
  NotificationRepositoryImpl({
    required this.notificationLocalData,
    required this.notificationRemoteData,
  });

  @override
  Future<Either<Failure, void>> createNotification(
      {required NotificationEntity notification}) async {
    try {
      var created = await notificationLocalData.createNotification(
          notification: NotificationModel.fromNotificationEntity(notification));
      return Right(created);
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteNotification(
      {required String notificationId}) async {
    try {
      var deleted = await notificationLocalData.deleteNotification(
          notificationId: notificationId);
      return Right(deleted);
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, List<NotificationEntity>>> getAppNotifications(
      {required String appId}) async {
    try {
      var notificationsModel =
          await notificationLocalData.getAppNotifications(appId: appId);
      var notifications =
          notificationsModel.map((e) => e.toNotificationEntity()).toList();
      return Right(notifications);
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteAppNotifications(
      {required String appId}) async {
    try {
      var deleted =
          await notificationLocalData.deleteAppNotifications(appId: appId);
      return Right(deleted);
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, NotificationEntity>> getNotification(
      {required String notificationId}) async {
    try {
      var notificationModel = await notificationLocalData.getNotification(
          notificationId: notificationId);
      var notification = notificationModel.toNotificationEntity();
      return Right(notification);
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateNotification(
      {required NotificationEntity notification}) async {
    try {
      var notificationModel =
          NotificationModel.fromNotificationEntity(notification);
      var updated = await notificationLocalData.updateNotification(
          notification: notificationModel);
      return Right(updated);
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, Response>> sendNotification(
      {required String serverKey,
      required NotificationEntity notification}) async {
    try {
      Response response = await notificationRemoteData.sendNotification(
          serverKey: serverKey,
          notification: NotificationModel.fromNotificationEntity(notification));
      Map<String, dynamic> responseData = response.data;

      if (responseData.containsKey('multicast_id')) {
        if (responseData['failure'] > 0) {
          return Left(RemoteFailure());
        } else {
          return Right(response);
        }
      } else if (response.statusCode == 200) {
        return Right(response);
      } else {
        return Left(RemoteFailure());
      }
    } on RemoteException {
      return Left(RemoteFailure());
    }
  }
}
