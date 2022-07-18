import 'package:fcm_notification/core/usecases/usecase.dart';

import '../../../../core/errors/failures.dart';
import '../entities/app_entity.dart';
import '../repositories/app_repository.dart';

class GetAllAppsUsecase extends Usecase<List<AppEntity>, NoParams> {
  final AppRepository repository;
  GetAllAppsUsecase(this.repository);

  @override
  Future<Either<Failure, List<AppEntity>>> call(NoParams params) async {
    return await repository.getAllApps();
  }
}
