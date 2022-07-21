// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationModelAdapter extends TypeAdapter<NotificationModel> {
  @override
  final int typeId = 1;

  @override
  NotificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationModel(
      appId: fields[0] as String,
      id: fields[1] as String,
      name: fields[2] as String,
      topicName: fields[3] as String?,
      deviceId: fields[4] as String?,
      title: fields[5] as String?,
      body: fields[6] as String?,
      imageUrl: fields[7] as String?,
      dataKey: fields[8] as String?,
      dataValue: fields[9] as String?,
      createdAt: fields[10] as DateTime,
      lastSentAt: fields[11] as DateTime?,
      receiverType: fields[12] as NotificationReceiverType?,
      notificationType: fields[13] as NotificationType?,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.appId)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.topicName)
      ..writeByte(4)
      ..write(obj.deviceId)
      ..writeByte(5)
      ..write(obj.title)
      ..writeByte(6)
      ..write(obj.body)
      ..writeByte(7)
      ..write(obj.imageUrl)
      ..writeByte(8)
      ..write(obj.dataKey)
      ..writeByte(9)
      ..write(obj.dataValue)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.lastSentAt)
      ..writeByte(12)
      ..write(obj.receiverType)
      ..writeByte(13)
      ..write(obj.notificationType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
