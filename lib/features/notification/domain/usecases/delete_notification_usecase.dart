import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/notification_repository.dart';

class DeleteNotificationUsecase extends Usecase<void, Params> {
  final NotificationRepository _notificationRepository;
  DeleteNotificationUsecase(this._notificationRepository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await _notificationRepository.deleteNotification(
      notificationId: params.id!,
    );
  }
}
