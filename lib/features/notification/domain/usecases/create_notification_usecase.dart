import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/notification_repository.dart';

class CreateNotificationUsecase extends Usecase<void, Params> {
  final NotificationRepository _notificationRepository;
  CreateNotificationUsecase(this._notificationRepository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await _notificationRepository.createNotification(
      notification: params.notification!,
    );
  }
}
