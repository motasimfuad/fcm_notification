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

class NotificationLoading extends NotificationState {}

class NotificationLoadedState extends NotificationState {
  final NotificationEntity notification;
  const NotificationLoadedState({required this.notification});
  @override
  List<Object> get props => [notification];
}

class NotificationLoadingFailed extends NotificationState {
  final String message;
  const NotificationLoadingFailed({required this.message});
  @override
  List<Object> get props => [message];
}

class NotificationCreatedState extends NotificationState {}

class NotificationCreatingFailed extends NotificationState {
  final String message;
  const NotificationCreatingFailed({required this.message});
  @override
  List<Object> get props => [message];
}

class NotificationDeletedState extends NotificationState {}

class NotificationDeletingFailed extends NotificationState {
  final String message;
  const NotificationDeletingFailed({required this.message});
  @override
  List<Object> get props => [message];
}

class NotificationDuplicatedState extends NotificationState {}

class NotificationDuplicatingFailed extends NotificationState {
  final String message;
  const NotificationDuplicatingFailed({required this.message});
  @override
  List<Object> get props => [message];
}

class NotificationSoundLoadingState extends NotificationState {}

class NotificationSoundToggledState extends NotificationState {
  final bool soundIsOn;
  const NotificationSoundToggledState({required this.soundIsOn});
  @override
  List<Object> get props => [soundIsOn];
}

class NotificationEditedState extends NotificationState {}

class NotificationEditingFailed extends NotificationState {
  final String message;
  const NotificationEditingFailed({required this.message});
  @override
  List<Object> get props => [message];
}

class NotificationSendingState extends NotificationState {
  final String notificationId;
  const NotificationSendingState({required this.notificationId});
  @override
  List<Object> get props => [notificationId];
}

class NotificationSentState extends NotificationState {
  final NotificationEntity notification;
  const NotificationSentState({required this.notification});
  @override
  List<Object> get props => [notification];
}

class NotificationSendingFailed extends NotificationState {
  final String message;
  const NotificationSendingFailed({required this.message});
  @override
  List<Object> get props => [message];
}
