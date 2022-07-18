import 'package:dartz/dartz.dart';
import 'package:fcm_notification/features/application/domain/entities/app_entity.dart';

import '../../../../core/errors/failures.dart';

abstract class AppRepository {
  Future<Either<Failure, List<AppEntity>>> getAllApps();
  Future<Either<Failure, AppEntity>> getApp({required int id});
  Future<Either<Failure, void>> createApp({required AppEntity app});
  Future<Either<Failure, void>> updateApp({required AppEntity app});
  Future<Either<Failure, void>> deleteApp({required int id});
}
