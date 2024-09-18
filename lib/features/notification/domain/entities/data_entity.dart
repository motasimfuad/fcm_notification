import 'package:equatable/equatable.dart';

class DataEntity extends Equatable {
  final String id;
  final String keyData;
  final dynamic valueData;

  const DataEntity({
    required this.id,
    required this.keyData,
    required this.valueData,
  });

  @override
  List<Object> get props => [id, keyData, valueData];
}
