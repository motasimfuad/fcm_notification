import 'package:fcm_notification/core/errors/failures.dart';
import 'package:fcm_notification/core/usecases/usecase.dart';

import '../repositories/app_repository.dart';

class DeleteAppUsecase extends Usecase<void, Params> {
  final AppRepository repository;
  DeleteAppUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.deleteApp(id: params.id!);
  }
}
