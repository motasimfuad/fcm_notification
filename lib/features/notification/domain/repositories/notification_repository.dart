import 'package:fcm_notification/core/errors/failures.dart';
import 'package:fcm_notification/core/usecases/usecase.dart';
import 'package:fcm_notification/features/notification/domain/entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<NotificationEntity>>> getAppNotifications(
      {required String appId});
  Future<Either<Failure, void>> deleteAppNotifications({required String appId});
  Future<Either<Failure, NotificationEntity>> getNotification(
      {required String notificationId});
  Future<Either<Failure, void>> createNotification(
      {required NotificationEntity notification});
  Future<Either<Failure, void>> updateNotification(
      {required NotificationEntity notification});
  Future<Either<Failure, void>> deleteNotification(
      {required String notificationId});
}
