import 'package:paperopoli_terminal/data/models/operation/operation_model.dart';
import 'package:paperopoli_terminal/data/models/operation/operation_status.dart';
import 'package:paperopoli_terminal/data/models/quay/quay_model.dart';
import 'package:paperopoli_terminal/data/models/trip/trip_time.dart';

class TripModel {
  int id;
  final Quay quay;
  final TripTime time;
  final List<OperationModel> operations;

  TripModel({
    required this.operations,
    required this.id,
    required this.quay,
    required this.time,
  });

  @override
  bool operator ==(Object other) => other is TripModel && other.id == id;

  factory TripModel.fromJson(List json) {
    var _operations = <OperationModel>[];
    if (json[0]['ID'] != null) {
      json.forEach(
        (e) => _operations.where((element) => e['ID'] == element.id).isEmpty
            ? _operations.add(
                OperationModel.fromJson(
                  e,
                ),
              )
            : {},
      );
      _operations.forEach(
        (op) {
          op.status.addAll(
            json.where((element) => element['ID'] == op.id).map(
                  (e) => OperationStatus(
                    timestamp: DateTime.parse(e['timestamp']),
                    name: e['nome_stato'],
                  ),
                ),
          );
        },
      );
    }
    return TripModel(
      operations: _operations,
      id: json[0]['viaggio_id'],
      quay: Quay(
        description: json[0]['banchina_descrizione'],
        id: json[0]['banchina_id'],
      ),
      time: TripTime(
        actualArrivalTime: DateTime.parse(json[0]['arrivo_effettivo']),
        actualDepartureTime: DateTime.parse(json[0]['partenza_effettiva']),
        expectedDepartureTime: DateTime.parse(json[0]['partenza_prevista']),
        expectedArrivalTime: DateTime.parse(json[0]['arrivo_previsto']),
      ),
    );
  }
}
