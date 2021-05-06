import 'package:paperopoli_terminal/data/models/models_status.dart';

class PersonModel {
  final int uid;
  final String name;
  PersonStatus status;

  PersonModel(
    this.uid,
    this.name,
    this.status,
  );

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
        json['id'] as int,
        json['name'] as String,
        PersonStatus.values[json['stato'] as int],
      );

  static String getStatusName(
    PersonStatus personStatus,
  ) {
    switch (personStatus) {
      case PersonStatus.onVehicle:
        return 'Su veicolo';
      case PersonStatus.onGround:
        return 'A terra';
      case PersonStatus.onShip:
        return 'Su nave';
      case PersonStatus.none:
        return 'indefinito';
    }
  }
}
