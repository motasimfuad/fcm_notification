part of 'application_bloc.dart';

abstract class ApplicationEvent extends Equatable {
  const ApplicationEvent();

  @override
  List<Object> get props => [];
}

class GetAllAppsEvent extends ApplicationEvent {}

class GetAppEvent extends ApplicationEvent {
  final String appId;
  const GetAppEvent(this.appId);
  @override
  List<Object> get props => [appId];
}

class DeleteAppEvent extends ApplicationEvent {
  final String appId;
  const DeleteAppEvent(this.appId);
  @override
  List<Object> get props => [appId];
}
