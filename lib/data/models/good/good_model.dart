import 'good_status.dart';

class GoodModel {
  int id;
  final String description;
  final String type;
  final Set<GoodStatus> status;

  GoodModel({
    required this.id,
    required this.status,
    required this.description,
    required this.type,
  });

  //TODO
  factory GoodModel.fromJson(Map<String, dynamic> json) => GoodModel(
        id: json['id'] as int,
        description: json['descrizione'] as String,
        type: json['tipo'],
        status: json[0].forEach(
          (item) => GoodStatus(
            id: item['id'],
            timestamp: item['timestamp'],
            name: item['tipo'],
          ),
        ).toSet(),
      );
}
