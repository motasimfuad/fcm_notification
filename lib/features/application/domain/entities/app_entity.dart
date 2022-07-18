import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import 'package:fcm_notification/features/notification/domain/entities/notification_entity.dart';

class AppEntity extends Equatable {
  final String id;
  final String name;
  final String serverKey;
  final Uint8List? icon;
  final List<NotificationEntity?>? notifications;
  final DateTime createdAt;

  const AppEntity({
    required this.id,
    required this.name,
    required this.serverKey,
    this.icon,
    this.notifications,
    required this.createdAt,
  });

  @override
  List<Object> get props => [id, name, serverKey, createdAt];
}
