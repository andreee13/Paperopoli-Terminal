import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paperopoli_terminal/cubits/goods/goods_cubit.dart';
import 'package:paperopoli_terminal/data/models/good/good_model.dart';
import 'package:paperopoli_terminal/presentation/screens/home_screen.dart';

class GoodsWidget extends StatefulWidget {
  @override
  _GoodsWidgetState createState() => _GoodsWidgetState();
}

class _GoodsWidgetState extends State<GoodsWidget> {
  final List<GoodModel> _goods = [];

  void _fetch() async => context.read<GoodsCubit>().fetch(
        user: HomeScreen.of(context)!.getUser(),
      );

  void _delete(
    GoodModel goodModel,
  ) {
    setState(() {
      _goods.remove(
        goodModel,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  /*void _changeStatus(
    GoodModel goodModel,
    GoodStatus goodStatus,
  ) {
    setState(() {
      goodModel.status = goodStatus;
    });
  }

  Widget _itemBuilder(GoodModel goodModel) => Padding(
        padding: EdgeInsets.fromLTRB(
          8,
          0,
          8,
          0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: _goods
                        .where((element) => element.status == goodModel.status)
                        .first ==
                    goodModel
                ? Radius.circular(
                    10,
                  )
                : Radius.zero,
            bottom: _goods
                        .where((element) => element.status == goodModel.status)
                        .last ==
                    goodModel
                ? Radius.circular(
                    10,
                  )
                : Radius.zero,
          ),
          child: ListTile(
            tileColor: Colors.white,
            minVerticalPadding: 20,
            title: Text(
              goodModel.id.toString(),
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
                    Icons.directions_boat,
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    goodModel.ship.id.toString(),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: GoodStatus.values
                      .map(
                        (status) => MaterialButton(
                          elevation: 0,
                          color:
                              goodModel.status == status ? Colors.green : null,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              25,
                            ),
                          ),
                          onPressed: () => _changeStatus(
                            goodModel,
                            status,
                          ),
                          child: Text(
                            GoodModel.getStatusName(
                              status,
                            ),
                            style: TextStyle(
                              color: goodModel.status == status
                                  ? Colors.white
                                  : null,
                            ),
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
                              'Elimina merce',
                            ),
                            content: Text(
                              'Vuoi davvero eliminare la merce con ID ${goodModel.id}?',
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
                                  goodModel,
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
    GoodStatus status,
  ) =>
      _goods
                  .where(
                    (element) => element.status == status,
                  ).isNotEmpty
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
                          GoodModel.getStatusName(
                            _goods
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
                    _goods
                        .where(
                          (element) => element.status == status,
                        )
                        .map(
                          (good) => _itemBuilder(
                            good,
                          ),
                        )
                        .toList(),
              ),
            )
          : SizedBox();

  @override
  Widget build(BuildContext context) => Expanded(
        child: BlocBuilder<GoodsCubit, GoodsState>(
          builder: (context, goodState) {
            if (goodState is GoodsLoaded) {
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
                          end: _goods.length.toDouble(),
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
                            'Merci',
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
                          children: GoodStatus.values
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
            } else if (goodState is GoodsError) {
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
      );*/
}
