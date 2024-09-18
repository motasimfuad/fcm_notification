// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:convert';

import 'package:fcm_notification/features/notification/data/models/data_model.dart';
import 'package:fcm_notification/features/notification/domain/entities/notification_entity.dart';
import 'package:hive/hive.dart';

import '../../../../core/constants/enums.dart';

part 'notification_model.g.dart';

@HiveType(typeId: 1)
class NotificationModel extends NotificationEntity {
  @HiveField(0)
  final String appId;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String? topicName;
  @HiveField(4)
  final String? deviceId;

  @HiveField(5)
  final String? title;
  @HiveField(6)
  final String? body;
  @HiveField(7)
  final String? imageUrl;

  @HiveField(8)
  final String? dataKey;
  @HiveField(9)
  final String? dataValue;

  @HiveField(10)
  final DateTime createdAt;
  @HiveField(11)
  final DateTime? lastSentAt;
  @HiveField(12)
  final NotificationReceiverType? receiverType;
  @HiveField(13)
  final NotificationType? notificationType;
  @HiveField(14)
  final List<DataModel>? data;

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
    this.receiverType,
    this.notificationType,
    this.data,
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
          receiverType: receiverType,
          notificationType: notificationType,
          data: data,
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
    NotificationReceiverType? receiverType,
    NotificationType? notificationType,
    List<DataModel>? data,
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
      receiverType: receiverType ?? this.receiverType,
      notificationType: notificationType ?? this.notificationType,
      data: data ?? this.data,
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
      'receiverType': receiverType?.index,
      'notificationType': notificationType?.index,
      'data': data?.map((e) => e.toJson()).toList(),
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
      receiverType: map['receiverType'] != null
          ? NotificationReceiverType.values[map['receiverType']]
          : null,
      notificationType: map['notificationType'] != null
          ? NotificationType.values[map['notificationType']]
          : null,
      data: (map['data'] as List<dynamic>?)
          ?.map((e) => e is Map<String, dynamic> ? DataModel.fromJson(e) : null)
          .whereType<DataModel>()
          .toList(),
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
      receiverType: notificationEntity.receiverType,
      notificationType: notificationEntity.notificationType,
      data: (notificationEntity.data?.isNotEmpty ?? false)
          ? notificationEntity.data!
              .map((e) => DataModel.fromDataEntity(e))
              .toList()
          : null,
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
      receiverType: receiverType,
      notificationType: notificationType,
      data: data,
    );
  }

  List<DataModel> get combinedData {
    if (data?.isNotEmpty ?? false) data!.whereType<DataModel>().toList();
    if (dataKey != null && dataValue != null) {
      return [
        DataModel(
          id: id,
          keyData: dataKey!,
          valueData: dataValue!,
        )
      ];
    }
    return [];
  }

  @override
  String toString() {
    return 'NotificationModel(appId: $appId ,id: $id, name: $name, topicName: $topicName, deviceId: $deviceId, title: $title, body: $body, imageUrl: $imageUrl, key: $dataKey, value: $dataValue, createdAt: $createdAt, lastSentAt: $lastSentAt, receiverType: $receiverType, notificationType: $notificationType, data: $data)';
  }
}
