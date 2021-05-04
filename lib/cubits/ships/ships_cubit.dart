import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:paperopoli_terminal/data/models/ships_model.dart';
import 'package:paperopoli_terminal/data/repositories/ships_repository.dart';

part 'ships_state.dart';

class VehiclesCubit extends Cubit<ShipsState> {
  final ShipsRepository repository;

  VehiclesCubit({
    required this.repository,
  }) : super(
          ShipsInitial(),
        );
}
