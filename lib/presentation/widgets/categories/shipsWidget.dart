import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paperopoli_terminal/core/utils/packages/flutter-countup/lib/countup.dart';
import 'package:paperopoli_terminal/cubits/ships/ships_cubit.dart';
import 'package:paperopoli_terminal/data/models/models_status.dart';
import 'package:paperopoli_terminal/data/models/ships_model.dart';
import 'package:paperopoli_terminal/presentation/screens/home_screen.dart';

class ShipsWidget extends StatefulWidget {
  @override
  _ShipsWidgetState createState() => _ShipsWidgetState();
}

class _ShipsWidgetState extends State<ShipsWidget> {
  List<ShipModel> _ships = [];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<ShipsCubit>().fetch(
            user: HomeScreen.of(context)!.getUser(),
          );
    });
  }

  _deleteShip(
    ShipModel shipModel,
  ) {
    setState(() {
      _ships.remove(
        shipModel,
      );
    });
  }

  _changeStatus(
    ShipModel shipModel,
    ShipStatus shipStatus,
  ) {
    setState(() {
      shipModel..status = shipStatus;
    });
  }

  Widget _itemBuilder(ShipModel shipModel) => Padding(
        padding: EdgeInsets.fromLTRB(
          8,
          0,
          8,
          0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: _ships
                        .where((element) => element.status == shipModel.status)
                        .first ==
                    shipModel
                ? Radius.circular(
                    10,
                  )
                : Radius.zero,
            bottom: _ships
                        .where((element) => element.status == shipModel.status)
                        .last ==
                    shipModel
                ? Radius.circular(
                    10,
                  )
                : Radius.zero,
          ),
          child: ListTile(
            tileColor: Colors.white,
            minVerticalPadding: 20,
            title: Text(
              shipModel.id.toString(),
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
                    Icons.schedule,
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${shipModel.expectedTime.hour}:${shipModel.expectedTime.minute}',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: ShipStatus.values
                      .map(
                        (status) => MaterialButton(
                          elevation: 0,
                          color:
                              shipModel.status == status ? Colors.green : null,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              25,
                            ),
                          ),
                          child: Text(
                            ShipModel.getStatusName(
                              status,
                            ),
                            style: TextStyle(
                              color: shipModel.status == status
                                  ? Colors.white
                                  : null,
                            ),
                          ),
                          onPressed: () => _changeStatus(
                            shipModel,
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
                              'Elimina nave',
                            ),
                            content: Text(
                              'Vuoi davvero eliminare la nave con ID ${shipModel.id}?',
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
                              ? _deleteShip(
                                  shipModel,
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
    ShipStatus status,
  ) =>
      _ships
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
                          ShipModel.getStatusName(
                            _ships
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
                    _ships
                        .where(
                          (element) => element.status == status,
                        )
                        .map(
                          (ship) => _itemBuilder(
                            ship,
                          ),
                        )
                        .toList(),
              ),
            )
          : SizedBox();

  @override
  Widget build(BuildContext context) => Expanded(
        child: BlocBuilder<ShipsCubit, ShipsState>(
          builder: (context, shipState) {
            if (shipState is ShipsLoaded) {
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
                          end: _ships.length.toDouble(),
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
                            'Navi',
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
                          children: ShipStatus.values
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
            } else if (shipState is ShipsError) {
              return Center(
                child: Text(
                  'Si è verificato un errore\n${shipState.exception.toString()}',
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
