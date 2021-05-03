import 'package:flutter/material.dart';

class ShipsWidget extends StatefulWidget {
  @override
  _ShipsWidgetState createState() => _ShipsWidgetState();
}

class _ShipsWidgetState extends State<ShipsWidget> {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            'Navi',
            style: TextStyle(
              fontSize: 36,
            ),
          ),
        ],
      );
}
