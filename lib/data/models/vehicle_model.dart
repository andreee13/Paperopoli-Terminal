import 'package:paperopoli_terminal/data/models/models_status.dart';

class VehicleModel {
  String plate;
  final VehicleStatus status;

  VehicleModel(
    this.plate,
    this.status,
  );

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        json['id'] as String,
        VehicleStatus.values[json['stato'] as int],
      );
}
