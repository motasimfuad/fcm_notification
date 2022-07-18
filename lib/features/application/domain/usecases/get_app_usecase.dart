import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/app_entity.dart';
import '../repositories/app_repository.dart';

class GetAppUsecase extends Usecase<AppEntity, Params> {
  final AppRepository repository;
  GetAppUsecase(this.repository);

  @override
  Future<Either<Failure, AppEntity>> call(Params params) async {
    return await repository.getApp(id: params.id!);
  }
}
