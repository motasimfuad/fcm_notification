import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:fcm_notification/features/application/domain/entities/app_entity.dart';
import 'package:fcm_notification/features/notification/domain/entities/notification_entity.dart';

import '../errors/failures.dart';

export 'package:dartz/dartz.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class Params extends Equatable {
  final int? id;
  final AppEntity? app;
  final NotificationEntity? notification;
  const Params({
    this.id,
    this.app,
    this.notification,
  });
  @override
  List<Object> get props => [];
}
