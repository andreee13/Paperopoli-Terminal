import 'package:flutter/material.dart';
import 'package:paperopoli_terminal/core/utils/packages/flutter-countup/lib/countup.dart';
import 'package:paperopoli_terminal/data/models/category_model.dart';
import 'package:paperopoli_terminal/data/models/models_status.dart';
import 'package:paperopoli_terminal/data/models/ships_model.dart';

class ShipsWidget extends StatefulWidget {
  final CategoryModel categoryModel;

  const ShipsWidget({
    required this.categoryModel,
  });

  @override
  _ShipsWidgetState createState() => _ShipsWidgetState(
        categoryModel,
      );
}

class _ShipsWidgetState extends State<ShipsWidget> {
  final CategoryModel _categoryModel;
  List<ShipModel> _ships = [
    ShipModel(
      8630,
      ShipStatus.arriving,
      DateTime.now(),
      DateTime.now(),
    ),
    ShipModel(
      1412,
      ShipStatus.docked,
      DateTime.now(),
      DateTime.now(),
    ),
    ShipModel(
      3212,
      ShipStatus.leaving,
      DateTime.now(),
      DateTime.now(),
    ),
    ShipModel(
      1592,
      ShipStatus.docked,
      DateTime.now(),
      DateTime.now(),
    ),
  ];

  _ShipsWidgetState(
    this._categoryModel,
  );

  Widget _itemBuilder(_, int index) => ListTile(
        title: Text(
          _ships[index].id.toString(),
        ),
        leading: Icon(
          _categoryModel.icons[ShipStatus.values.indexOf(
            _ships[index].status,
          )],
        ),
        trailing: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.delete_outlined,
              ),
              onPressed: () {},
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(
            16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Countup(
                    begin: 0,
                    end: _ships.length.toDouble(),
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
              ListView.builder(
                itemCount: _ships.length,
                itemBuilder: _itemBuilder,
              ),
            ],
          ),
        ),
      );
}
