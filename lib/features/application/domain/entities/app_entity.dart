import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import 'package:fcm_notification/features/notification/domain/entities/notification_entity.dart';

class AppEntity extends Equatable {
  final String name;
  final String serverKey;
  final Uint8List icon;
  final List<NotificationEntity> notifications;

  const AppEntity({
    required this.name,
    required this.serverKey,
    required this.icon,
    required this.notifications,
  });

  @override
  List<Object> get props => [name, serverKey, icon, notifications];
}
