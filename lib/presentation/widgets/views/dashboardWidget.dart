import 'package:flutter/material.dart';

class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  final List<Color> _colors = [
    Color(0xfff9fede),
    Color(0xfff2fdff),
  ];

  Widget _tripsBuilder(
    BuildContext context,
    int index,
  ) =>
      Container(
        padding: const EdgeInsets.all(16),
        margin: index.isOdd
            ? null
            : EdgeInsets.only(
                right: 20,
              ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _colors[index],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Viaggio #363322',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff262539),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz,
                  ),
                ),
              ],
            ),
            Text(
              '30 Maggio 2021',
            ),
            Row(),
          ],
        ),
      );

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
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Viaggi di oggi',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xff262539),
                      fontSize: 35,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xff333333),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xff333333),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                  ),
                  child: SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: _tripsBuilder,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
