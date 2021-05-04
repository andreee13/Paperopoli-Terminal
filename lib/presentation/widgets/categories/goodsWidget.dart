import 'package:flutter/material.dart';
import 'package:paperopoli_terminal/core/utils/constants.dart';
import 'package:paperopoli_terminal/core/utils/packages/flutter-countup/lib/countup.dart';
import 'package:paperopoli_terminal/data/models/good_model.dart';
import 'package:paperopoli_terminal/data/models/models_status.dart';

class GoodsWidget extends StatefulWidget {
  @override
  _GoodsWidgetState createState() => _GoodsWidgetState();
}

class _GoodsWidgetState extends State<GoodsWidget> {
  List<GoodModel> _goods = FAKE_GOODS;

  _deletegood(
    GoodModel goodModel,
  ) {
    setState(() {
      _goods.remove(
        goodModel,
      );
    });
  }

  _changeStatus(
    GoodModel goodModel,
    GoodStatus goodStatus,
  ) {
    setState(() {
      goodModel..status = goodStatus;
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
                          onPressed: () => _changeStatus(
                            goodModel,
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
                              ? _deletegood(
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
        child: Padding(
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
        ),
      );
}
