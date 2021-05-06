import 'package:flutter/material.dart';
import 'package:paperopoli_terminal/core/utils/constants.dart';
import 'package:paperopoli_terminal/core/utils/packages/flutter-countup/lib/countup.dart';
import 'package:paperopoli_terminal/cubits/vehicles/vehicles_cubit.dart';
import 'package:paperopoli_terminal/data/models/models_status.dart';
import 'package:paperopoli_terminal/data/models/vehicle_model.dart';
import 'package:paperopoli_terminal/presentation/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehiclesWidget extends StatefulWidget {
  @override
  _VehiclesWidgetState createState() => _VehiclesWidgetState();
}

class _VehiclesWidgetState extends State<VehiclesWidget> {
  List<VehicleModel> _vehicles = FAKE_VEHICLES;

  void _fetch() async => context.read<VehiclesCubit>().fetch(
        user: HomeScreen.of(context)!.getUser(),
      );

  _deletevehicle(
    VehicleModel vehicleModel,
  ) {
    setState(() {
      _vehicles.remove(
        vehicleModel,
      );
    });
  }

  _changeStatus(
    VehicleModel vehicleModel,
    VehicleStatus vehicleStatus,
  ) {
    setState(() {
      vehicleModel..status = vehicleStatus;
    });
  }

  Widget _itemBuilder(VehicleModel vehicleModel) => Padding(
        padding: EdgeInsets.fromLTRB(
          8,
          0,
          8,
          0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: _vehicles
                        .where(
                            (element) => element.status == vehicleModel.status)
                        .first ==
                    vehicleModel
                ? Radius.circular(
                    10,
                  )
                : Radius.zero,
            bottom: _vehicles
                        .where(
                            (element) => element.status == vehicleModel.status)
                        .last ==
                    vehicleModel
                ? Radius.circular(
                    10,
                  )
                : Radius.zero,
          ),
          child: ListTile(
            tileColor: Colors.white,
            minVerticalPadding: 20,
            title: Text(
              vehicleModel.plate,
            ),
            leading: Padding(
              padding: const EdgeInsets.only(
                top: 5,
                right: 32,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person,
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    vehicleModel.owner.name,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: VehicleStatus.values
                      .map(
                        (status) => MaterialButton(
                          elevation: 0,
                          color: vehicleModel.status == status
                              ? Colors.green
                              : null,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              25,
                            ),
                          ),
                          child: Text(
                            VehicleModel.getStatusName(
                              status,
                            ),
                            style: TextStyle(
                              color: vehicleModel.status == status
                                  ? Colors.white
                                  : null,
                            ),
                          ),
                          onPressed: () => _changeStatus(
                            vehicleModel,
                            status,
                          ),
                        ),
                      )
                      .toList()
                      .cast<Widget>() +
                  <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                        ),
                        onPressed: () async => await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'Elimina veicolo',
                            ),
                            content: Text(
                              'Vuoi davvero eliminare il veicolo con targa ${vehicleModel.plate}?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(
                                  context,
                                  false,
                                ),
                                child: Text(
                                  'Annulla',
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(
                                  context,
                                  true,
                                ),
                                child: Text(
                                  'Elimina',
                                ),
                              ),
                            ],
                          ),
                        ).then(
                          (value) => value
                              ? _deletevehicle(
                                  vehicleModel,
                                )
                              : {},
                        ),
                      ),
                    ),
                  ],
            ),
          ),
        ),
      );

  Widget _buildStatusView(
    VehicleStatus status,
  ) =>
      _vehicles
                  .where(
                    (element) => element.status == status,
                  )
                  .length >
              0
          ? Padding(
              padding: const EdgeInsets.only(
                bottom: 16,
                top: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 16,
                        ),
                        child: Text(
                          VehicleModel.getStatusName(
                            _vehicles
                                .where(
                                  (element) => element.status == status,
                                )
                                .first
                                .status,
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ] +
                    _vehicles
                        .where(
                          (element) => element.status == status,
                        )
                        .map(
                          (vehicle) => _itemBuilder(
                            vehicle,
                          ),
                        )
                        .toList(),
              ),
            )
          : SizedBox();

  @override
  Widget build(BuildContext context) => Expanded(
        child: BlocBuilder<VehiclesCubit, VehiclesState>(
          builder: (context, vehicleState) {
            if (vehicleState is VehiclesLoaded) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(
                  32,
                  32,
                  32,
                  0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Countup(
                          begin: 0,
                          end: _vehicles.length.toDouble(),
                          curve: Curves.decelerate,
                          duration: Duration(
                            milliseconds: 300,
                          ),
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                          ),
                          child: Text(
                            'Veicoli',
                            style: TextStyle(
                              fontSize: 45,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: VehicleStatus.values
                                  .map(
                                    (status) => _buildStatusView(
                                      status,
                                    ),
                                  )
                                  .toList() +
                              [
                                SizedBox(
                                  height: 64,
                                ),
                              ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (vehicleState is VehiclesError) {
              return Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Si è verificato un errore',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                      ),
                      child: TextButton(
                        onPressed: () => _fetch(),
                        child: Text(
                          'Riprova',
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
}
