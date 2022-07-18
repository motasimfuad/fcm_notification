import 'dart:convert';

import 'package:fcm_notification/features/notification/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.name,
    required super.createdAt,
    super.topicName,
    super.deviceId,
    super.title,
    super.body,
    super.dataKey,
    super.dataValue,
    super.lastSentAt,
  });

  NotificationModel copyWith({
    String? id,
    String? name,
    String? topicName,
    String? deviceId,
    String? title,
    String? body,
    String? key,
    String? value,
    DateTime? createdAt,
    DateTime? lastSentAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      topicName: topicName ?? this.topicName,
      deviceId: deviceId ?? this.deviceId,
      title: title ?? this.title,
      body: body ?? this.body,
      dataKey: key ?? dataKey,
      dataValue: value ?? dataValue,
      createdAt: createdAt ?? this.createdAt,
      lastSentAt: lastSentAt ?? this.lastSentAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'topicName': topicName,
      'deviceId': deviceId,
      'title': title,
      'body': body,
      'key': dataKey,
      'value': dataValue,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'lastSentAt': lastSentAt?.millisecondsSinceEpoch,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      topicName: map['topicName'],
      deviceId: map['deviceId'],
      title: map['title'],
      body: map['body'],
      dataKey: map['key'],
      dataValue: map['value'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      lastSentAt: map['lastSentAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastSentAt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  factory NotificationModel.fromNotificationEntity(
      NotificationEntity notificationEntity) {
    if (notificationEntity is NotificationModel) {
      return notificationEntity;
    }
    return NotificationModel(
      id: notificationEntity.id,
      name: notificationEntity.name,
      topicName: notificationEntity.topicName,
      deviceId: notificationEntity.deviceId,
      title: notificationEntity.title,
      body: notificationEntity.body,
      dataKey: notificationEntity.dataKey,
      dataValue: notificationEntity.dataValue,
      createdAt: notificationEntity.createdAt,
      lastSentAt: notificationEntity.lastSentAt,
    );
  }

  @override
  String toString() {
    return 'NotificationModel(id: $id, name: $name, topicName: $topicName, deviceId: $deviceId, title: $title, body: $body, key: $dataKey, value: $dataValue, createdAt: $createdAt, lastSentAt: $lastSentAt)';
  }
}
