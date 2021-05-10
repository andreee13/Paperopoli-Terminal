import 'package:paperopoli_terminal/data/models/good_model.dart';
import 'package:paperopoli_terminal/data/models/models_status.dart';
import 'package:paperopoli_terminal/data/models/ships_model.dart';
import 'package:paperopoli_terminal/data/models/vehicle_model.dart';

class OperationModel {
  int id;
  OperationStatus status;
  ShipModel? ship;
  GoodModel? good;
  VehicleModel? vehicle;

  OperationModel(
    this.id,
    this.status,
    this.ship,
    this.good,
    this.vehicle,
  );

  factory OperationModel.fromJson(Map<String, dynamic> json) => OperationModel(
        json['ID'] as int,
        getStatus(
          json['stato'] as String,
        ),
        json['nave'],
        json['merce'],
        json['veicolo'],
      );

  static String getStatusName(
    OperationStatus operationStatus,
  ) {
    switch (operationStatus) {
      case OperationStatus.working:
        return 'In lavorazione';
      case OperationStatus.waiting:
        return 'Da eseguire';
      case OperationStatus.done:
        return 'Eseguite';
      case OperationStatus.none:
        return 'indefinito';
    }
  }

  static OperationStatus getStatus(
    String operationStatus,
  ) {
    switch (operationStatus) {
      case 'In lavorazione':
        return OperationStatus.working;
      case 'Eseguite':
        return OperationStatus.done;
      case 'Da eseguire':
        return OperationStatus.waiting;
      default:
        return OperationStatus.none;
    }
  }
}
