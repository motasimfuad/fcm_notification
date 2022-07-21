// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationReceiverTypeAdapter
    extends TypeAdapter<NotificationReceiverType> {
  @override
  final int typeId = 3;

  @override
  NotificationReceiverType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NotificationReceiverType.single;
      case 1:
        return NotificationReceiverType.all;
      default:
        return NotificationReceiverType.single;
    }
  }

  @override
  void write(BinaryWriter writer, NotificationReceiverType obj) {
    switch (obj) {
      case NotificationReceiverType.single:
        writer.writeByte(0);
        break;
      case NotificationReceiverType.all:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationReceiverTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NotificationTypeAdapter extends TypeAdapter<NotificationType> {
  @override
  final int typeId = 4;

  @override
  NotificationType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NotificationType.notification;
      case 1:
        return NotificationType.dataMessage;
      default:
        return NotificationType.notification;
    }
  }

  @override
  void write(BinaryWriter writer, NotificationType obj) {
    switch (obj) {
      case NotificationType.notification:
        writer.writeByte(0);
        break;
      case NotificationType.dataMessage:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
