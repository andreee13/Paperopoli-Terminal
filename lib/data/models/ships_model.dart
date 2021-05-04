import 'package:paperopoli_terminal/data/models/models_status.dart';

class ShipModel {
  int id;
  final ShipStatus status;
  final DateTime expectedTime;
  final DateTime actualTime;

  ShipModel(this.id, this.status, this.expectedTime, this.actualTime);

  factory ShipModel.fromJson(Map<String, dynamic> json) => ShipModel(
        json['id'] as int,
        ShipStatus.values[json['stato'] as int],
        json['orario_previsto'] as DateTime,
        json['orario_effettivo'] as DateTime,
      );
}
