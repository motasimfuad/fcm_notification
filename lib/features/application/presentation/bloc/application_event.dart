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

class AddAppIconEvent extends ApplicationEvent {}

class CreateAppEvent extends ApplicationEvent {
  final AppEntity appEntity;
  const CreateAppEvent(this.appEntity);
  @override
  List<Object> get props => [appEntity];
}

class UpdateAppEvent extends ApplicationEvent {
  final AppEntity appEntity;
  const UpdateAppEvent(this.appEntity);
  @override
  List<Object> get props => [appEntity];
}
