import 'package:paperopoli_terminal/data/models/models_status.dart';

class ShipModel {
  int id;
  ShipStatus status;
  final DateTime expectedDepartureTime;
  final DateTime actualDepartureTime;
  final DateTime expectedArrivalTime;
  final DateTime actualArrivalTime;

  ShipModel(
    this.id,
    this.status,
    this.expectedDepartureTime,
    this.actualDepartureTime,
    this.expectedArrivalTime,
    this.actualArrivalTime,
  );

  factory ShipModel.fromJson(Map<String, dynamic> json) => ShipModel(
        json['ID'] as int,
        getStatus(
          json['stato'] as String,
        ),
        DateTime.parse(
          json['partenza_prevista'],
        ),
        DateTime.parse(
          json['partenza_effettiva'],
        ),
        DateTime.parse(
          json['arrivo_previsto'],
        ),
        DateTime.parse(
          json['arrivo_effettivo'],
        ),
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
      case ShipStatus.none:
        return 'indefinito';
    }
  }

  static ShipStatus getStatus(
    String shipStatus,
  ) {
    switch (shipStatus) {
      case 'In arrivo':
        return ShipStatus.arriving;
      case 'In uscita':
        return ShipStatus.leaving;
      case 'Attraccata':
        return ShipStatus.docked;
      default:
        return ShipStatus.none;
    }
  }
}
