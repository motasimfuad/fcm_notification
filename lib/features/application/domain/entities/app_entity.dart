import 'package:equatable/equatable.dart';

import 'package:fcm_notification/features/notification/domain/entities/notification_entity.dart';

class AppEntity extends Equatable {
  final String id;
  final String name;
  final String serverKey;
  final String? iconName;
  final List<NotificationEntity?>? notifications;
  final DateTime createdAt;

  const AppEntity({
    required this.id,
    required this.name,
    required this.serverKey,
    this.iconName,
    this.notifications,
    required this.createdAt,
  });

  @override
  List<Object> get props => [id, name, serverKey, createdAt];
}
