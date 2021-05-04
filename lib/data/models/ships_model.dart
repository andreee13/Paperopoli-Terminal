import 'package:paperopoli_terminal/data/models/models_status.dart';

class ShipModel {
  int id;
  ShipStatus status;
  final DateTime expectedTime;
  final DateTime actualTime;

  ShipModel(
    this.id,
    this.status,
    this.expectedTime,
    this.actualTime,
  );

  factory ShipModel.fromJson(Map<String, dynamic> json) => ShipModel(
        json['id'] as int,
        ShipStatus.values[json['stato'] as int],
        json['orario_previsto'] as DateTime,
        json['orario_effettivo'] as DateTime,
      );

  static String getStatusName(
    ShipStatus shipStatus,
  ) {
    switch (shipStatus) {
      case ShipStatus.arriving:
        return 'In arrivo';
      case ShipStatus.leaving:
        return 'In uscita';
      case ShipStatus.docked:
        return 'Attraccata';
    }
  }
}
