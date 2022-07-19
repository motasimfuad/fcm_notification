// ignore_for_file: overridden_fields, annotate_overrides

import 'dart:convert';

import 'package:fcm_notification/features/application/domain/entities/app_entity.dart';
import 'package:fcm_notification/features/notification/data/models/notification_model.dart';
import 'package:fcm_notification/features/notification/domain/entities/notification_entity.dart';
import 'package:hive/hive.dart';

part 'app_model.g.dart';

@HiveType(typeId: 0)
class AppModel extends AppEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String serverKey;
  @HiveField(3)
  final String? iconName;
  @HiveField(4)
  final List<NotificationEntity?>? notifications;
  @HiveField(5)
  final DateTime createdAt;

  const AppModel({
    required this.id,
    required this.name,
    required this.serverKey,
    this.iconName,
    this.notifications,
    required this.createdAt,
  }) : super(
          id: id,
          name: name,
          serverKey: serverKey,
          iconName: iconName,
          notifications: notifications,
          createdAt: createdAt,
        );

  AppModel copyWith({
    String? id,
    String? name,
    String? serverKey,
    String? iconName,
    List<NotificationEntity>? notifications,
    DateTime? createdAt,
  }) {
    return AppModel(
      id: id ?? this.id,
      name: name ?? this.name,
      serverKey: serverKey ?? this.serverKey,
      iconName: iconName ?? this.iconName,
      notifications: notifications ?? this.notifications,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'serverKey': serverKey,
      'iconName': iconName,
      'notifications': (notifications != null && notifications!.isNotEmpty)
          ? notifications!
              .map((x) => NotificationModel.fromNotificationEntity(x!).toMap())
              .toList()
          : null,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory AppModel.fromMap(Map<String, dynamic> map) {
    return AppModel(
      id: map['id'],
      name: map['name'] ?? '',
      serverKey: map['serverKey'] ?? '',
      iconName: map['iconName'] ?? '',
      notifications: List<NotificationModel>.from(
          map['notifications']?.map((x) => NotificationModel.fromMap(x))),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  factory AppModel.fromEntity(AppEntity entity) {
    return AppModel(
      id: entity.id,
      name: entity.name,
      serverKey: entity.serverKey,
      iconName: entity.iconName,
      notifications: entity.notifications,
      createdAt: entity.createdAt,
    );
  }

  AppEntity toEntity() {
    return AppEntity(
      id: id,
      name: name,
      serverKey: serverKey,
      iconName: iconName,
      notifications: notifications,
      createdAt: createdAt,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppModel.fromJson(String source) =>
      AppModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppModel(id: $id, name: $name, serverKey: $serverKey, iconName: $iconName, notifications: $notifications), createdAt: $createdAt)';
  }
}
