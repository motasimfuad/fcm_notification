import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/notification_entity.dart';
import '../repositories/notification_repository.dart';

class GetAppsNotificationsUsecase
    extends Usecase<List<NotificationEntity>, Params> {
  final NotificationRepository _notificationRepository;
  GetAppsNotificationsUsecase(this._notificationRepository);

  @override
  Future<Either<Failure, List<NotificationEntity>>> call(Params params) async {
    return await _notificationRepository.getAppsNotifications(
      appId: params.id!,
    );
  }
}
