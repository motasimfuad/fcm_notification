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

class ToggleNotificationSoundEvent extends NotificationEvent {
  final int index;
  const ToggleNotificationSoundEvent({required this.index});
  @override
  List<Object> get props => [index];
}

class EditNotificationEvent extends NotificationEvent {
  final NotificationEntity notification;
  const EditNotificationEvent({required this.notification});
  @override
  List<Object> get props => [notification];
}

class SendNotificationEvent extends NotificationEvent {
  final String serverKey;
  final NotificationEntity notification;
  const SendNotificationEvent({
    required this.serverKey,
    required this.notification,
  });
  @override
  List<Object> get props => [notification];
}
