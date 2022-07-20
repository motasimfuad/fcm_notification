import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/notification_repository.dart';

class UpdateNotificationUsecase extends Usecase<void, Params> {
  final NotificationRepository _notificationRepository;
  UpdateNotificationUsecase(this._notificationRepository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await _notificationRepository.updateNotification(
      notification: params.notification!,
    );
  }
}
