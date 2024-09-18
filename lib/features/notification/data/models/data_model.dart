// ignore_for_file: annotate_overrides, overridden_fields

import 'package:fcm_notification/features/notification/domain/entities/data_entity.dart';
import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 2)
class DataModel extends DataEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String keyData;
  @HiveField(2)
  final dynamic valueData;

  const DataModel({
    required this.id,
    required this.keyData,
    required this.valueData,
  }) : super(
          id: id,
          keyData: keyData,
          valueData: valueData,
        );

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'] as String,
      keyData: json['key'] as String,
      valueData: json['value'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'key': keyData,
        'value': valueData,
      };

  DataEntity toDataEntity() {
    return DataEntity(
      id: id,
      keyData: keyData,
      valueData: valueData,
    );
  }

  static DataModel fromDataEntity(DataEntity dataEntity) {
    return DataModel(
      id: dataEntity.id,
      keyData: dataEntity.keyData,
      valueData: dataEntity.valueData,
    );
  }

  @override
  String toString() {
    return 'DataModel(id: $id, key: $keyData, value: $valueData)';
  }
}
