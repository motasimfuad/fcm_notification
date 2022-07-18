part of 'application_bloc.dart';

abstract class ApplicationState extends Equatable {
  const ApplicationState();

  @override
  List<Object> get props => [];
}

class ApplicationInitial extends ApplicationState {}

class AppListLoading extends ApplicationState {}

class AppListLoaded extends ApplicationState {
  final List<AppEntity> apps;
  const AppListLoaded({required this.apps});
  @override
  List<Object> get props => [apps];
}

class AppListLoadingFailed extends ApplicationState {
  final String message;
  const AppListLoadingFailed({required this.message});
  @override
  List<Object> get props => [message];
}
