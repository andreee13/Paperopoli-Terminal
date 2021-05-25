import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paperopoli_terminal/cubits/trips/trips_cubit.dart';
import 'package:paperopoli_terminal/data/models/operation/operation_model.dart';
import 'package:paperopoli_terminal/data/models/trip/trip_model.dart';
import 'package:paperopoli_terminal/presentation/screens/home_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  final List<Color> _colors = [
    Color(0xffF9FEDF),
    Color(0xfff2fdff),
  ];
  late List<TripModel> _trips;
  final List<OperationsChartData> _chartData = [];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback(
      (timeStamp) => context.read<TripsCubit>().fetch(
            user: HomeScreen.of(context)!.getUser(),
          ),
    );
  }

  int checkDate(TripModel trip) {
    if (DateTime.now().year == trip.time.expectedArrivalTime.year &&
        DateTime.now().month == trip.time.expectedArrivalTime.month &&
        DateTime.now().day == trip.time.expectedArrivalTime.day) {
      return 1;
    } else if (DateTime.now().year == trip.time.expectedDepartureTime.year &&
        DateTime.now().month == trip.time.expectedDepartureTime.month &&
        DateTime.now().day == trip.time.expectedDepartureTime.day) {
      return 2;
    } else {
      return 0;
    }
  }

  Widget _tripsBuilder(
    BuildContext context,
    int index,
  ) =>
      checkDate(_trips[index]) != 0
          ? Container(
              padding: const EdgeInsets.fromLTRB(
                24,
                16,
                16,
                24,
              ),
              width: MediaQuery.of(context).size.width / 2.5 / 2 - 10,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Viaggio #${_trips[index].id.toString()}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff262539),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_horiz,
                          color: Color(0xff262539),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${checkDate(_trips[index]) == 1 ? "Arrivo" : "Partenza"} alle ${_trips[index].time.expectedArrivalTime.toIso8601String().substring(11, 16)} - ${_trips[index].time.actualArrivalTime.toIso8601String().substring(11, 16)}',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  Row(),
                ],
              ),
            )
          : SizedBox();

  void manageTrips(List<TripModel> trips) {
    _trips = trips;
    var v = <OperationModel>[];
    _trips.forEach((element) {
      v.addAll(element.operations);
    });
    var s = <DateTime>[];
    v.forEach((element) {
      s.addAll(element.status.map((e) => e.timestamp));
    });
    var t =
        groupBy(s, (DateTime obj) => obj.toIso8601String().substring(0, 10));
    t.keys.forEach((key) {
      _chartData.add(OperationsChartData(t[key]!.length, key));
    });
  }

  @override
  Widget build(BuildContext context) => Expanded(
        child: BlocBuilder<TripsCubit, TripsState>(
          builder: (context, tripState) {
            if (tripState is TripsLoaded) {
              manageTrips(tripState.trips);
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    32,
                    32,
                    32,
                    32,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 40,
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Ionicons.search,
                                    color: Colors.grey.shade400,
                                  ),
                                  hintText: 'Cerca viaggi',
                                  contentPadding: const EdgeInsets.fromLTRB(
                                    16,
                                    16,
                                    16,
                                    0,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade400,
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade200,
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade200,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade200,
                                      width: 1,
                                    ),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade200,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Viaggi di oggi',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xff262539),
                                    fontSize: 40,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    MaterialButton(
                                      onPressed: () {},
                                      elevation: 0,
                                      padding: const EdgeInsets.all(16),
                                      hoverElevation: 0,
                                      highlightElevation: 0,
                                      shape: CircleBorder(),
                                      color: Color(0xffF9F9F9),
                                      child: Icon(
                                        Icons.add,
                                        color: Color(0xff333333),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        size: 20,
                                        color: Color(0xff333333),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 20,
                                        color: Color(0xff333333),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 160,
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 24,
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _trips.length,
                                  itemBuilder: _tripsBuilder,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 32,
                                bottom: 24,
                              ),
                              child: Text(
                                'Attività giornaliera',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xff262539),
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            SfCartesianChart(
                              plotAreaBorderWidth: 0,
                              legend: Legend(
                                isVisible: true,
                                position: LegendPosition.top,
                                alignment: ChartAlignment.near,
                                legendItemBuilder: (_, __, ___, ____) =>
                                    Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 16,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 16,
                                        width: 16,
                                        margin: const EdgeInsets.only(
                                          right: 16,
                                        ),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff232343),
                                        ),
                                      ),
                                      Text(
                                        'Movimentazioni',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              primaryXAxis: CategoryAxis(
                                majorGridLines: MajorGridLines(
                                  width: 0,
                                ),
                                axisLine: AxisLine(
                                  width: 0,
                                ),
                              ),
                              primaryYAxis: NumericAxis(
                                axisLine: AxisLine(
                                  width: 0,
                                ),
                              ),
                              series: [
                                SplineSeries<OperationsChartData, String>(
                                  name: '',
                                  dataSource: _chartData,
                                  color: Color(0xff1F344A),
                                  xValueMapper: (OperationsChartData data, _) =>
                                      data.dateTime
                                          .substring(5, data.dateTime.length),
                                  yValueMapper: (OperationsChartData data, _) =>
                                      data.lenght,
                                ),
                              ],
                              tooltipBehavior: TooltipBehavior(
                                enable: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text('Right'),
                    ],
                  ),
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

class OperationsChartData {
  int lenght;
  final String dateTime;

  OperationsChartData(this.lenght, this.dateTime);
}
