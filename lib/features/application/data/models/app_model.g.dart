// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppModelAdapter extends TypeAdapter<AppModel> {
  @override
  final int typeId = 0;

  @override
  AppModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppModel(
      id: fields[0] as String,
      name: fields[1] as String,
      serverKey: fields[2] as String,
      iconName: fields[3] as String?,
      notifications: (fields[4] as List?)?.cast<NotificationModel?>(),
      createdAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AppModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.serverKey)
      ..writeByte(3)
      ..write(obj.iconName)
      ..writeByte(4)
      ..write(obj.notifications)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
