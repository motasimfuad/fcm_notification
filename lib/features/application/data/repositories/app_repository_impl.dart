import 'package:dartz/dartz.dart';

import 'package:fcm_notification/core/errors/failures.dart';
import 'package:fcm_notification/features/application/data/datasources/app_local_datasource.dart';
import 'package:fcm_notification/features/application/data/models/app_model.dart';
import 'package:fcm_notification/features/application/domain/entities/app_entity.dart';
import 'package:fcm_notification/features/application/domain/repositories/app_repository.dart';

class AppRepositoryImpl implements AppRepository {
  final AppLocalDatasource datasource;
  AppRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<Failure, void>> createApp({required AppEntity app}) async {
    var appModel = AppModel.fromEntity(app);
    try {
      final app = await datasource.createApp(app: appModel);
      return Right(app);
    } on Exception {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteApp({required String id}) async {
    try {
      final app = await datasource.deleteApp(id: id);
      return Right(app);
    } on Exception {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, List<AppEntity>>> getAllApps() async {
    try {
      final apps = await datasource.getAllApps();
      return Right(apps.map((e) => e.toEntity()).toList());
    } on Exception {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, AppEntity>> getApp({required String id}) async {
    try {
      final app = await datasource.getApp(id: id);
      return Right(app.toEntity());
    } on Exception {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateApp({required AppEntity app}) async {
    var appModel = AppModel.fromEntity(app);
    try {
      final app = await datasource.updateApp(app: appModel);
      return Right(app);
    } on Exception {
      return Left(LocalFailure());
    }
  }
}
