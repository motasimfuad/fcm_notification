import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/notification_entity.dart';
import '../repositories/notification_repository.dart';

class GetNotificationUsecase extends Usecase<NotificationEntity, Params> {
  final NotificationRepository _notificationRepository;
  GetNotificationUsecase(this._notificationRepository);

  @override
  Future<Either<Failure, NotificationEntity>> call(Params params) async {
    return await _notificationRepository.getNotification(
      notificationId: params.id!,
    );
  }
}
