import 'package:paperopoli_terminal/data/models/models_status.dart';
import 'package:paperopoli_terminal/data/models/person_model.dart';

class VehicleModel {
  String plate;
  final PersonModel owner;
  VehicleStatus status;

  VehicleModel(
    this.plate,
    this.owner,
    this.status,
  );

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        json['id'] as String,
        PersonModel.fromJson(
          json['owner'],
        ),
        VehicleStatus.values[json['stato'] as int],
      );

  static String getStatusName(
    VehicleStatus vehicleStatus,
  ) {
    switch (vehicleStatus) {
      case VehicleStatus.inside:
        return 'Dentro';
      case VehicleStatus.outside:
        return 'Fuori';
      case VehicleStatus.none:
        return 'indefinito';
    }
  }
}
