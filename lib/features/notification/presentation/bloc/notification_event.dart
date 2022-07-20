part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class GetAppsNotificationEvent extends NotificationEvent {
  final String appId;
  const GetAppsNotificationEvent({required this.appId});
  @override
  List<Object> get props => [appId];
}
