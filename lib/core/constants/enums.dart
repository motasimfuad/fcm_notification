import 'package:hive/hive.dart';

part 'enums.g.dart';

@HiveType(typeId: 3)
enum NotificationReceiverType {
  @HiveField(0)
  single,
  @HiveField(1)
  all,
}

@HiveType(typeId: 4)
enum NotificationType {
  @HiveField(0)
  notification,
  @HiveField(1)
  dataMessage,
}
