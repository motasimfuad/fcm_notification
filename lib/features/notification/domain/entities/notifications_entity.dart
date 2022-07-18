import 'package:equatable/equatable.dart';

import 'package:fcm_notification/features/notification/domain/entities/notification_entity.dart';

class NotificationsEntity extends Equatable {
  final List<NotificationEntity> notifications;
  const NotificationsEntity({
    required this.notifications,
  });

  @override
  List<Object?> get props => [notifications];
}
