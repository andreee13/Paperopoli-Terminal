import 'package:paperopoli_terminal/data/models/models_status.dart';
import 'package:paperopoli_terminal/data/models/ships_model.dart';

class GoodModel {
  int id;
  GoodStatus status;
  ShipModel ship;

  GoodModel(
    this.id,
    this.status,
    this.ship,
  );

  factory GoodModel.fromJson(Map<String, dynamic> json) => GoodModel(
        json['id'] as int,
        GoodStatus.values[json['stato'] as int],
        ShipModel.fromJson(
          json['ship'],
        ),
      );

  static String getStatusName(
    GoodStatus goodStatus,
  ) {
    switch (goodStatus) {
      case GoodStatus.leaved:
        return 'Spedita';
      case GoodStatus.onGround:
        return 'A terra';
      case GoodStatus.onShip:
        return 'Su nave';
      case GoodStatus.none:
        return 'indefinito';
    }
  }
}
