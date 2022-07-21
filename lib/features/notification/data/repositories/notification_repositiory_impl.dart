import 'package:dartz/dartz.dart';
import 'package:fcm_notification/core/errors/exceptions.dart';

import 'package:fcm_notification/core/errors/failures.dart';
import 'package:fcm_notification/features/notification/data/datasources/notification_local_datasource.dart';
import 'package:fcm_notification/features/notification/data/models/notification_model.dart';
import 'package:fcm_notification/features/notification/domain/entities/notification_entity.dart';
import 'package:fcm_notification/features/notification/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationLocalDatasource notificationData;
  NotificationRepositoryImpl({
    required this.notificationData,
  });

  @override
  Future<Either<Failure, void>> createNotification(
      {required NotificationEntity notification}) async {
    try {
      var created = await notificationData.createNotification(
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
      var deleted = await notificationData.deleteNotification(
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
          await notificationData.getAppNotifications(appId: appId);
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
      var deleted = await notificationData.deleteAppNotifications(appId: appId);
      return Right(deleted);
    } on LocalException {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, NotificationEntity>> getNotification(
      {required String notificationId}) async {
    try {
      var notificationModel = await notificationData.getNotification(
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
      var updated = await notificationData.updateNotification(
          notification: notificationModel);
      return Right(updated);
    } on LocalException {
      return Left(LocalFailure());
    }
  }
}
