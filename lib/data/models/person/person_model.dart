import 'person_status.dart';

class PersonModel {
  final int id;
  final Set<PersonStatus> operations;
  final String fullname;
  final String cf;
  final String type;

  PersonModel({
    required this.id,
    required this.operations,
    required this.fullname,
    required this.cf,
    required this.type,
  });

  //TODO
  //factory PersonModel.fromJson(Map<String, dynamic> json) => Object();
}
