import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:paperopoli_terminal/data/models/vehicle_model.dart';
import 'package:paperopoli_terminal/data/repositories/vehicles_repository.dart';

part 'vehicles_state.dart';

class VehiclesCubit extends Cubit<VehiclesState> {
  final VehiclesRepository repository;

  VehiclesCubit({
    required this.repository,
  }) : super(
          VehiclesInitial(),
        );
}
