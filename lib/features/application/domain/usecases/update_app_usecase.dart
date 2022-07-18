import 'package:fcm_notification/core/errors/failures.dart';
import 'package:fcm_notification/core/usecases/usecase.dart';

import '../repositories/app_repository.dart';

class UpdateAppUsecase extends Usecase<void, Params> {
  final AppRepository repository;
  UpdateAppUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.updateApp(app: params.app!);
  }
}
