part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationListLoading extends NotificationState {}

class NotificationListLoaded extends NotificationState {
  final List<NotificationEntity> notifications;
  const NotificationListLoaded({required this.notifications});
  @override
  List<Object> get props => [notifications];
}

class NotificationListLoadingFailed extends NotificationState {
  final String message;
  const NotificationListLoadingFailed({required this.message});
  @override
  List<Object> get props => [message];
}
