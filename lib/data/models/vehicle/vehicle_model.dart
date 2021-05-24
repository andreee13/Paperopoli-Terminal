
import 'vehicle_status.dart';

class VehicleModel {
  String plate;
  final String type;
  final Set<VehicleStatus> status;

  VehicleModel({
    required this.plate,
    required this.status,
    required this.type,
  });

  //TODO
  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        plate: json['targa'] as String,
        type: json['tipo'],
        status: json[0].forEach(
          (item) => VehicleStatus(
            id: item['id'],
            timestamp: item['timestamp'],
            name: item['tipo'],
          ),
        ).toSet(),
      );
}
