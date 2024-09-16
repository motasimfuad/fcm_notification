// ignore_for_file: overridden_fields, annotate_overrides

import 'dart:convert';

import 'package:fcm_notification/core/constants/constants.dart';
import 'package:fcm_notification/features/application/domain/entities/app_entity.dart';
import 'package:fcm_notification/features/notification/data/models/notification_model.dart';
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
  final List<NotificationModel?>? notifications;
  @HiveField(5)
  final DateTime createdAt;
  @HiveField(6)
  final FcmApiType apiType;

  const AppModel({
    required this.id,
    required this.name,
    required this.serverKey,
    this.iconName,
    this.notifications,
    required this.createdAt,
    this.apiType = FcmApiType.legacy,
  }) : super(
          id: id,
          name: name,
          serverKey: serverKey,
          iconName: iconName,
          notifications: notifications,
          createdAt: createdAt,
          apiType: apiType,
        );

  AppModel copyWith({
    String? id,
    String? name,
    String? serverKey,
    String? iconName,
    List<NotificationModel>? notifications,
    DateTime? createdAt,
    FcmApiType? apiType,
  }) {
    return AppModel(
      id: id ?? this.id,
      name: name ?? this.name,
      serverKey: serverKey ?? this.serverKey,
      iconName: iconName ?? this.iconName,
      notifications: notifications ?? this.notifications,
      createdAt: createdAt ?? this.createdAt,
      apiType: apiType ?? this.apiType,
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
      'apiType': apiType ?? FcmApiType.legacy,
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
      apiType: map['apiType'] == null
          ? FcmApiType.legacy
          : map['apiType'] ?? FcmApiType.legacy,
    );
  }

  factory AppModel.fromEntity(AppEntity entity) {
    return AppModel(
      id: entity.id,
      name: entity.name,
      serverKey: entity.serverKey,
      iconName: entity.iconName,
      notifications:
          (entity.notifications != null && entity.notifications!.isNotEmpty)
              ? entity.notifications
                  ?.map((e) => NotificationModel.fromNotificationEntity(e!))
                  .toList()
              : null,
      createdAt: entity.createdAt,
      apiType: entity.apiType,
    );
  }

  AppEntity toEntity() {
    return AppEntity(
      id: id,
      name: name,
      serverKey: serverKey,
      iconName: iconName,
      notifications: (notifications != null && notifications!.isNotEmpty)
          ? notifications!.map((e) => e!.toNotificationEntity()).toList()
          : null,
      createdAt: createdAt,
      apiType: apiType,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppModel.fromJson(String source) =>
      AppModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppModel(id: $id, name: $name, serverKey: $serverKey, iconName: $iconName, notifications: $notifications), createdAt: $createdAt, apiType: $apiType)';
  }
}
