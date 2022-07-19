import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
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

  const NotificationEntity({
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
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      createdAt,
    ];
  }
}
