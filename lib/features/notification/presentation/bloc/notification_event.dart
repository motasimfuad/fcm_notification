part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class GetAppNotificationsEvent extends NotificationEvent {
  final String appId;
  const GetAppNotificationsEvent({required this.appId});
  @override
  List<Object> get props => [appId];
}

class DeleteAppNotificationsEvent extends NotificationEvent {
  final String appId;
  const DeleteAppNotificationsEvent({required this.appId});
  @override
  List<Object> get props => [appId];
}

class GetNotificationEvent extends NotificationEvent {
  final String id;
  const GetNotificationEvent({required this.id});
  @override
  List<Object> get props => [id];
}

class CreateNotificationEvent extends NotificationEvent {
  final NotificationEntity notification;
  const CreateNotificationEvent({required this.notification});
  @override
  List<Object> get props => [notification];
}

class DeleteNotificationEvent extends NotificationEvent {
  final String id;
  const DeleteNotificationEvent({required this.id});
  @override
  List<Object> get props => [id];
}

class DuplicateNotificationEvent extends NotificationEvent {
  final NotificationEntity notification;
  const DuplicateNotificationEvent({required this.notification});
  @override
  List<Object> get props => [notification];
}
