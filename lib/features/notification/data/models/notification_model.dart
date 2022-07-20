// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:convert';

import 'package:fcm_notification/features/notification/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  final String appId;
  final String id;
  final String name;
  final String? topicName;
  final String? deviceId;

  final String? title;
  final String? body;
  final String? imageUrl;

  final String? dataKey;
  final String? dataValue;

  final DateTime createdAt;
  final DateTime? lastSentAt;

  const NotificationModel({
    required this.appId,
    required this.id,
    required this.name,
    this.topicName,
    this.deviceId,
    this.title,
    this.body,
    this.imageUrl,
    this.dataKey,
    this.dataValue,
    required this.createdAt,
    this.lastSentAt,
  }) : super(
          appId: appId,
          id: id,
          name: name,
          createdAt: createdAt,
          topicName: topicName,
          deviceId: deviceId,
          title: title,
          body: body,
          imageUrl: imageUrl,
          dataKey: dataKey,
          dataValue: dataValue,
          lastSentAt: lastSentAt,
        );

  NotificationModel copyWith({
    String? appId,
    String? id,
    String? name,
    String? topicName,
    String? deviceId,
    String? title,
    String? body,
    String? imageUrl,
    String? key,
    String? value,
    DateTime? createdAt,
    DateTime? lastSentAt,
  }) {
    return NotificationModel(
      appId: appId ?? this.appId,
      id: id ?? this.id,
      name: name ?? this.name,
      topicName: topicName ?? this.topicName,
      deviceId: deviceId ?? this.deviceId,
      title: title ?? this.title,
      body: body ?? this.body,
      imageUrl: imageUrl ?? this.imageUrl,
      dataKey: key ?? dataKey,
      dataValue: value ?? dataValue,
      createdAt: createdAt ?? this.createdAt,
      lastSentAt: lastSentAt ?? this.lastSentAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'appId': appId,
      'id': id,
      'name': name,
      'topicName': topicName,
      'deviceId': deviceId,
      'title': title,
      'body': body,
      'imageUrl': imageUrl,
      'key': dataKey,
      'value': dataValue,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'lastSentAt': lastSentAt?.millisecondsSinceEpoch,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      appId: map['appId'] ?? '',
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      topicName: map['topicName'],
      deviceId: map['deviceId'],
      title: map['title'],
      body: map['body'],
      imageUrl: map['imageUrl'],
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
      appId: notificationEntity.appId,
      id: notificationEntity.id,
      name: notificationEntity.name,
      topicName: notificationEntity.topicName,
      deviceId: notificationEntity.deviceId,
      title: notificationEntity.title,
      body: notificationEntity.body,
      imageUrl: notificationEntity.imageUrl,
      dataKey: notificationEntity.dataKey,
      dataValue: notificationEntity.dataValue,
      createdAt: notificationEntity.createdAt,
      lastSentAt: notificationEntity.lastSentAt,
    );
  }

  NotificationEntity toNotificationEntity() {
    return NotificationEntity(
      appId: appId,
      id: id,
      name: name,
      topicName: topicName,
      deviceId: deviceId,
      title: title,
      body: body,
      imageUrl: imageUrl,
      dataKey: dataKey,
      dataValue: dataValue,
      createdAt: createdAt,
      lastSentAt: lastSentAt,
    );
  }

  @override
  String toString() {
    return 'NotificationModel(appId: $appId ,id: $id, name: $name, topicName: $topicName, deviceId: $deviceId, title: $title, body: $body, imageUrl: $imageUrl, key: $dataKey, value: $dataValue, createdAt: $createdAt, lastSentAt: $lastSentAt)';
  }
}
