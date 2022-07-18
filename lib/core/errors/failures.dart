import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class LocalFailure extends Failure {
  final String? message;

  LocalFailure({this.message});

  @override
  List<Object?> get props => [message];
}
