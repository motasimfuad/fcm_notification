import 'dart:convert';
import 'dart:typed_data';

import 'package:fcm_notification/features/application/domain/entities/app_entity.dart';
import 'package:fcm_notification/features/notification/data/models/notification_model.dart';
import 'package:fcm_notification/features/notification/domain/entities/notification_entity.dart';

class AppModel extends AppEntity {
  const AppModel({
    required String name,
    required String serverKey,
    required Uint8List icon,
    required List<NotificationEntity> notifications,
  }) : super(
          name: name,
          serverKey: serverKey,
          icon: icon,
          notifications: notifications,
        );

  // const AppModel({
  //   required super.name,
  //   required super.serverKey,
  //   required super.icon,
  //   required super.notifications,
  // });

  AppModel copyWith({
    String? name,
    String? serverKey,
    Uint8List? icon,
    List<NotificationEntity>? notifications,
  }) {
    return AppModel(
      name: name ?? this.name,
      serverKey: serverKey ?? this.serverKey,
      icon: icon ?? this.icon,
      notifications: notifications ?? this.notifications,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'serverKey': serverKey,
      'icon': icon.toList(),
      'notifications': notifications
          .map((x) => NotificationModel.fromNotificationEntity(x).toMap())
          .toList(),
    };
  }

  // ...toJson(){
  //     final Map<String, dynamic> data = <String, dynamic>{};
  //     if (this.items != null) {
  //     data['items'] = this.items.map((v) => ItemModel.fromItem(v).toJson()).toList();
  //     }
  //     return data;
  // }

  factory AppModel.fromMap(Map<String, dynamic> map) {
    return AppModel(
      name: map['name'] ?? '',
      serverKey: map['serverKey'] ?? '',
      icon: Uint8List.fromList(map['icon']),
      notifications: List<NotificationModel>.from(
          map['notifications']?.map((x) => NotificationModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppModel.fromJson(String source) =>
      AppModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppModel(name: $name, serverKey: $serverKey, icon: $icon, notifications: $notifications)';
  }
}
