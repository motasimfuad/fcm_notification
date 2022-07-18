import 'package:fcm_notification/core/errors/failures.dart';
import 'package:fcm_notification/core/usecases/usecase.dart';

import '../repositories/app_repository.dart';

class CreateAppUsecase extends Usecase<void, Params> {
  final AppRepository repository;
  CreateAppUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.createApp(app: params.app!);
  }
}
