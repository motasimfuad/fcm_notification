import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/notification_entity.dart';
import '../repositories/notification_repository.dart';

class GetAppNotificationsUsecase
    extends Usecase<List<NotificationEntity>, Params> {
  final NotificationRepository _notificationRepository;
  GetAppNotificationsUsecase(this._notificationRepository);

  @override
  Future<Either<Failure, List<NotificationEntity>>> call(Params params) async {
    return await _notificationRepository.getAppNotifications(
      appId: params.id!,
    );
  }
}
