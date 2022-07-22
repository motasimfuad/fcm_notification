import 'package:dio/dio.dart';
import 'package:fcm_notification/core/errors/failures.dart';
import 'package:fcm_notification/core/usecases/usecase.dart';

import '../repositories/notification_repository.dart';

class SendNotificationUsecase extends Usecase<Response, Params> {
  final NotificationRepository notificationRepository;
  SendNotificationUsecase(this.notificationRepository);

  @override
  Future<Either<Failure, Response>> call(Params params) async {
    return await notificationRepository.sendNotification(
      serverKey: params.serverKey!,
      notification: params.notification!,
    );
  }
}
