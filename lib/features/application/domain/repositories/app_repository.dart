import 'package:dartz/dartz.dart';
import 'package:fcm_notification/features/application/domain/entities/app_entity.dart';

import '../../../../core/errors/failures.dart';

abstract class AppRepository {
  Future<Either<Failure, List<AppEntity>>> getAllApps();
  Future<Either<Failure, AppEntity>> getApp({required int id});
  Future<Either<Failure, AppEntity>> createApp({required AppEntity app});
  Future<Either<Failure, AppEntity>> updateApp({required AppEntity app});
  Future<Either<Failure, AppEntity>> deleteApp({required int id});
}
