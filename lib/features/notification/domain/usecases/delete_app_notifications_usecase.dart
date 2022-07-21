import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/notification_repository.dart';

class DeleteAppNotificationsUsecase extends Usecase<void, Params> {
  final NotificationRepository _notificationRepository;
  DeleteAppNotificationsUsecase(this._notificationRepository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await _notificationRepository.deleteAppNotifications(
      appId: params.id!,
    );
  }
}
