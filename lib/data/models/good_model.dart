import 'package:paperopoli_terminal/data/models/models_status.dart';

class GoodModel {
  int id;
  final GoodStatus status;

  GoodModel(
    this.id,
    this.status,
  );

  factory GoodModel.fromJson(Map<String, dynamic> json) => GoodModel(
        json['id'] as int,
        GoodStatus.values[json['stato'] as int],
      );
}
