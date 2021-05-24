import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paperopoli_terminal/core/utils/packages/flutter-countup/lib/countup.dart';
import 'package:paperopoli_terminal/cubits/ships/ships_cubit.dart';
import 'package:paperopoli_terminal/data/models/models_status.dart';
import 'package:paperopoli_terminal/data/models/ships_model.dart';
import 'package:paperopoli_terminal/presentation/screens/home_screen.dart';
import 'package:timelines/timelines.dart';

class ShipsWidget extends StatefulWidget {
  @override
  _ShipsWidgetState createState() => _ShipsWidgetState();
}

class _ShipsWidgetState extends State<ShipsWidget> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback(
      (timeStamp) => _fetch(),
    );
  }

  void _fetch() async => context.read<ShipsCubit>().fetch(
        user: HomeScreen.of(context)!.getUser(),
      );

  void _delete(
    ShipModel shipModel,
    List<ShipModel> ships,
  ) {
    setState(() {
      ships.remove(
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

  Widget _itemBuilder(
    ShipModel shipModel,
    List<ShipModel> ships,
  ) =>
      Padding(
        padding: EdgeInsets.fromLTRB(
          8,
          0,
          8,
          0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: ships
                        .where((element) => element.status == shipModel.status)
                        .first ==
                    shipModel
                ? Radius.circular(
                    10,
                  )
                : Radius.zero,
            bottom: ships
                        .where((element) => element.status == shipModel.status)
                        .last ==
                    shipModel
                ? Radius.circular(
                    10,
                  )
                : Radius.zero,
          ),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 16,
            ),
            backgroundColor: Colors.white,
            collapsedBackgroundColor: Colors.white,
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
                    '${shipModel.expectedArrivalTime}:${shipModel.expectedArrivalTime.minute}',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            children: [
              SizedBox(
                height: 80,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Timeline.tileBuilder(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      theme: TimelineThemeData(
                        nodePosition: 0,
                        nodeItemOverlap: true,
                        connectorTheme: ConnectorThemeData(
                          color: Color(0xffe6e7e9),
                          thickness: 15.0,
                        ),
                      ),
                      builder: TimelineTileBuilder.connected(
                        indicatorBuilder: (context, currIndex) =>
                            OutlinedDotIndicator(
                          color: shipModel.status == ShipStatus.docked
                              ? Color(0xff6ad192)
                              : Color(0xffe6e7e9),
                          backgroundColor: shipModel.status == ShipStatus.docked
                              ? Color(0xffd4f5d6)
                              : Color(0xffc2c5c9),
                          borderWidth:
                              shipModel.status == ShipStatus.docked ? 3.0 : 2.5,
                        ),
                        /*connectorBuilder: (context, index, connectorType) {
                          var color;
                          if (index + 1 < data.length - 1 &&
                              data[index].isInProgress &&
                              data[index + 1].isInProgress) {
                            color = data[index].isInProgress
                                ? Color(0xff6ad192)
                                : null;
                          }
                          return SolidLineConnector(
                            color: color,
                          );
                        },
                        contentsBuilder: (context, index) {
                          var height;
                          if (index + 1 < data.length - 1 &&
                              data[index].isInProgress &&
                              data[index + 1].isInProgress) {
                            height = kTileHeight - 10;
                          } else {
                            height = kTileHeight + 5;
                          }
                          return SizedBox(
                            height: height,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(),
                            ),
                          );
                        },*/
                        itemCount: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            /*trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: ShipStatus.values
                      .where(
                        (element) => element != ShipStatus.values.last,
                      )
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
                              ? _delete(
                                  shipModel,
                                  ships,
                                )
                              : {},
                        ),
                      ),
                    ),
                  ],
            ),
            */
          ),
        ),
      );

  Widget _buildStatusView(
    ShipStatus status,
    List<ShipModel> ships,
  ) =>
      ships
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
                            ships
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
                    ships
                        .where(
                          (element) => element.status == status,
                        )
                        .map(
                          (ship) => _itemBuilder(
                            ship,
                            ships,
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
                          end: shipState.ships.length.toDouble(),
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
                                      shipState.ships,
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
