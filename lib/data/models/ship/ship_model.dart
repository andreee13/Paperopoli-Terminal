import 'package:paperopoli_terminal/data/models/ship/ship_status.dart';

class ShipModel {
  int id;
  final Set<ShipStatus> status;
  final String type;
  final String description;

  ShipModel({
    required this.id,
    required this.status,
    required this.type,
    required this.description,
  });

  //TODO
  factory ShipModel.fromJson(Map<String, dynamic> json) => ShipModel(
        id: json['id'],
        status: json[0]
            .forEach(
              (item) => ShipStatus(
                id: item['id'],
                timestamp: item['timestamp'],
                name: item['tipo'],
              ),
            )
            .toSet(),
        type: json['tipo'],
        description: json['descrizione'],
      );
}
