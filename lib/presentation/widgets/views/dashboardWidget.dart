import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:paperopoli_terminal/cubits/trips/trips_cubit.dart';
import 'package:paperopoli_terminal/data/models/operation/operation_model.dart';
import 'package:paperopoli_terminal/data/models/operation/operation_status.dart';
import 'package:paperopoli_terminal/data/models/trip/trip_model.dart';
import 'package:paperopoli_terminal/presentation/screens/home_screen.dart';

class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  final List<OperationsChartData> _operationsCounterChartData = [];
  final List<FlSpot> _completedOperationsChartSpots = [];
  final List<FlSpot> _workingOperationsChartSpots = [];
  late List<TripModel> _trips;
  late int _totalOperations;
  int _totalCompletedOperations = 0;
  int _totalWorkingOperations = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback(
      (timeStamp) => _fetch(),
    );
  }

  void _fetch() => context.read<TripsCubit>().fetch(
        user: HomeScreen.of(context)!.getUser(),
      );

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
                borderRadius: BorderRadius.circular(18),
                color: index.isEven ? Color(0xffF9FEDF) : Color(0xfff2fdff),
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
    _operationsCounterChartData.clear();
    _completedOperationsChartSpots.clear();
    _workingOperationsChartSpots.clear();
    //daily operations counter
    var count1 = <OperationModel>[];
    _trips.forEach((element) {
      count1.addAll(element.operations);
    });
    var count2 = <DateTime>[];
    count1.forEach(
      (element) {
        count2.addAll(
          element.status.map(
            (e) => e.timestamp,
          ),
        );
      },
    );
    _totalOperations = count2.length;
    var count3 = groupBy(
      count2,
      (DateTime obj) => obj.toIso8601String().substring(0, 10),
    );
    count3.keys.forEach(
      (key) {
        _operationsCounterChartData.add(
          OperationsChartData(
            count3[key]!.length,
            key,
          ),
        );
      },
    );
    //daily operations
    final work1 = <OperationStatus>[];
    count1.map(
      (e) => work1.addAll(
        e.status,
      ),
    );
    var work2 = <OperationStatus>[];
    count1.forEach(
      (element) {
        work2.addAll(
          element.status,
        );
      },
    );
    Map<String, dynamic> work3 = groupBy(
      work2,
      (OperationStatus status) =>
          status.timestamp.toIso8601String().substring(0, 10),
    );
    var work4 = <String, dynamic>{};
    work3.forEach((key, value) {
      work4[key] = groupBy(
        work3[key],
        (OperationStatus e) => e.name,
      );
    });
    work4.forEach(
      (key, value) {
        _totalCompletedOperations +=
            value['Completata'] != null ? value['Completata'].length as int : 0;
        _totalWorkingOperations += value['In lavorazione'] != null
            ? value['In lavorazione'].length as int
            : 0;
        _workingOperationsChartSpots.add(
          FlSpot(
            work4.keys.toList().indexOf(key).toDouble(),
            value['In lavorazione'] != null
                ? value['In lavorazione'].length
                : 0,
          ),
        );
        _completedOperationsChartSpots.add(
          FlSpot(
            work4.keys.toList().indexOf(key).toDouble(),
            value['Completata'] != null ? value['Completata'].length : 0,
          ),
        );
      },
    );
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
                            Row(
                              children: [
                                /*Flexible(
                                  child: SfCartesianChart(
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
                                        dataSource: _operationsCounterChartData,
                                        color: Color(0xff1F344A),
                                        xValueMapper:
                                            (OperationsChartData data, _) =>
                                                data.dateTime.substring(
                                                    5, data.dateTime.length),
                                        yValueMapper:
                                            (OperationsChartData data, _) =>
                                                data.lenght,
                                      ),
                                    ],
                                    tooltipBehavior: TooltipBehavior(
                                      enable: true,
                                    ),
                                  ),
                                ),*/
                                SizedBox(
                                  width: 600,
                                  height: 400,
                                  child: LineChart(
                                    LineChartData(
                                      gridData: FlGridData(
                                        show: false,
                                      ),
                                      titlesData: FlTitlesData(
                                        bottomTitles: SideTitles(
                                          getTitles: (value) =>
                                              value.toString(),
                                          showTitles: true,
                                          margin: 16,
                                          getTextStyles: (value) => TextStyle(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        leftTitles: SideTitles(
                                          getTitles: (value) =>
                                              value.toString(),
                                          showTitles: true,
                                          margin: 24,
                                          getTextStyles: (value) => TextStyle(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ),
                                      borderData: FlBorderData(
                                        show: false,
                                      ),
                                      minX: 0,
                                      maxX: _completedOperationsChartSpots
                                              .length
                                              .toDouble() -
                                          1,
                                      minY: 0,
                                      lineTouchData: LineTouchData(
                                        getTouchedSpotIndicator: (barData,
                                                spotIndexes) =>
                                            spotIndexes
                                                .map(
                                                  (e) =>
                                                      TouchedSpotIndicatorData(
                                                    FlLine(
                                                      color:
                                                          Colors.grey.shade400,
                                                      strokeWidth: 2,
                                                      dashArray: [
                                                        5,
                                                      ],
                                                    ),
                                                    FlDotData(
                                                      getDotPainter: (_, __,
                                                              ___, ____) =>
                                                          FlDotCirclePainter(
                                                        color: Colors.white,
                                                        strokeColor: Colors
                                                            .grey.shade100,
                                                        radius: 6,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                        touchTooltipData: LineTouchTooltipData(
                                          fitInsideVertically: true,
                                          tooltipBgColor: Colors.grey.shade100,
                                          tooltipRoundedRadius: 25,
                                          getTooltipItems: (touchedSpots) =>
                                              touchedSpots
                                                  .map(
                                                    (touchedSpot) =>
                                                        LineTooltipItem(
                                                      touchedSpot.y
                                                          .toStringAsFixed(0),
                                                      TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                        ),
                                      ),
                                      lineBarsData: [
                                        LineChartBarData(
                                          spots: _operationsCounterChartData
                                              .map(
                                                (e) => FlSpot(
                                                  _operationsCounterChartData
                                                      .indexOf(e)
                                                      .toDouble(),
                                                  e.lenght.toDouble(),
                                                ),
                                              )
                                              .toList(),
                                          isCurved: true,
                                          colors: [
                                            Color(0xff18293F),
                                          ],
                                          barWidth: 4,
                                          isStrokeCapRound: true,
                                          dotData: FlDotData(
                                            show: false,
                                          ),
                                          belowBarData: BarAreaData(
                                            show: true,
                                            colors: [
                                              Colors.white.withOpacity(0.0),
                                              Color(0xff8CE4F4),
                                            ],
                                            gradientColorStops: [0.0, 0.8],
                                            gradientFrom: Offset(0, 1),
                                            gradientTo: Offset(0, 0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 32,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 140,
                                      margin: const EdgeInsets.only(
                                        bottom: 16,
                                      ),
                                      width: MediaQuery.of(context).size.width /
                                              2.5 /
                                              3 -
                                          10,
                                      decoration: BoxDecoration(
                                        color: Color(0xff232343),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      padding: const EdgeInsets.all(24),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Totale completate',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 8,
                                                  top: 16,
                                                ),
                                                child: Text(
                                                  '${(_totalCompletedOperations / _totalOperations * 100).toInt()} %',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '$_totalCompletedOperations su $_totalOperations',
                                                style: TextStyle(
                                                  color: Colors.white60,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 16,
                                                right: 8,
                                                left: 24,
                                              ),
                                              child: LineChart(
                                                LineChartData(
                                                  gridData: FlGridData(
                                                    show: false,
                                                  ),
                                                  titlesData: FlTitlesData(
                                                    bottomTitles: SideTitles(
                                                      showTitles: false,
                                                    ),
                                                    leftTitles: SideTitles(
                                                      showTitles: false,
                                                    ),
                                                  ),
                                                  borderData: FlBorderData(
                                                    show: false,
                                                  ),
                                                  minX: 0,
                                                  maxX:
                                                      _completedOperationsChartSpots
                                                              .length
                                                              .toDouble() -
                                                          1,
                                                  minY: 0,
                                                  lineTouchData: LineTouchData(
                                                    getTouchedSpotIndicator:
                                                        (barData,
                                                                spotIndexes) =>
                                                            spotIndexes
                                                                .map(
                                                                  (e) =>
                                                                      TouchedSpotIndicatorData(
                                                                    FlLine(
                                                                      color: Colors
                                                                          .white54,
                                                                      strokeWidth:
                                                                          2,
                                                                      dashArray: [
                                                                        5,
                                                                      ],
                                                                    ),
                                                                    FlDotData(
                                                                      getDotPainter: (_,
                                                                              __,
                                                                              ___,
                                                                              ____) =>
                                                                          FlDotCirclePainter(
                                                                        color: Colors
                                                                            .white,
                                                                        strokeColor:
                                                                            Colors.white,
                                                                        radius:
                                                                            6,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                    touchTooltipData:
                                                        LineTouchTooltipData(
                                                      fitInsideVertically: true,
                                                      tooltipBgColor: Colors
                                                          .white
                                                          .withOpacity(0.9),
                                                      tooltipRoundedRadius: 25,
                                                      getTooltipItems:
                                                          (touchedSpots) =>
                                                              touchedSpots
                                                                  .map(
                                                                    (touchedSpot) =>
                                                                        LineTooltipItem(
                                                                      touchedSpot
                                                                          .y
                                                                          .toStringAsFixed(
                                                                              0),
                                                                      TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  )
                                                                  .toList(),
                                                    ),
                                                  ),
                                                  lineBarsData: [
                                                    LineChartBarData(
                                                      spots:
                                                          _completedOperationsChartSpots,
                                                      //isCurved: true,
                                                      colors: [Colors.white70],
                                                      barWidth: 4,
                                                      isStrokeCapRound: true,
                                                      dotData: FlDotData(
                                                        show: false,
                                                      ),
                                                      belowBarData: BarAreaData(
                                                        show: true,
                                                        colors: [
                                                          Colors.white
                                                              .withOpacity(0.0),
                                                          Colors.white30,
                                                        ],
                                                        gradientColorStops: [
                                                          0.2,
                                                          0.8
                                                        ],
                                                        gradientFrom:
                                                            Offset(0, 1),
                                                        gradientTo:
                                                            Offset(0, 0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 140,
                                      width: MediaQuery.of(context).size.width /
                                              2.5 /
                                              3 -
                                          10,
                                      decoration: BoxDecoration(
                                        color: Color(0xff232343),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      padding: const EdgeInsets.all(24),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Totale in lavorazione',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 8,
                                                  top: 16,
                                                ),
                                                child: Text(
                                                  '${(_totalWorkingOperations / _totalOperations * 100).toInt()} %',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '$_totalWorkingOperations su $_totalOperations',
                                                style: TextStyle(
                                                  color: Colors.white60,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 16,
                                                right: 8,
                                                left: 24,
                                              ),
                                              child: LineChart(
                                                LineChartData(
                                                  gridData: FlGridData(
                                                    show: false,
                                                  ),
                                                  titlesData: FlTitlesData(
                                                    bottomTitles: SideTitles(
                                                      showTitles: false,
                                                    ),
                                                    leftTitles: SideTitles(
                                                      showTitles: false,
                                                    ),
                                                  ),
                                                  borderData: FlBorderData(
                                                    show: false,
                                                  ),
                                                  minX: 0,
                                                  maxX:
                                                      _workingOperationsChartSpots
                                                              .length
                                                              .toDouble() -
                                                          1,
                                                  minY: 0,
                                                  lineTouchData: LineTouchData(
                                                    getTouchedSpotIndicator:
                                                        (barData,
                                                                spotIndexes) =>
                                                            spotIndexes
                                                                .map(
                                                                  (e) =>
                                                                      TouchedSpotIndicatorData(
                                                                    FlLine(
                                                                      color: Colors
                                                                          .white54,
                                                                      strokeWidth:
                                                                          2,
                                                                      dashArray: [
                                                                        5,
                                                                      ],
                                                                    ),
                                                                    FlDotData(
                                                                      getDotPainter: (
                                                                        _,
                                                                        __,
                                                                        ___,
                                                                        ____,
                                                                      ) =>
                                                                          FlDotCirclePainter(
                                                                        color: Colors
                                                                            .white,
                                                                        strokeColor:
                                                                            Colors.white,
                                                                        radius:
                                                                            6,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                    touchTooltipData:
                                                        LineTouchTooltipData(
                                                      fitInsideVertically: true,
                                                      tooltipBgColor: Colors
                                                          .white
                                                          .withOpacity(0.9),
                                                      tooltipRoundedRadius: 25,
                                                      getTooltipItems:
                                                          (touchedSpots) =>
                                                              touchedSpots
                                                                  .map(
                                                                    (touchedSpot) =>
                                                                        LineTooltipItem(
                                                                      touchedSpot
                                                                          .y
                                                                          .toStringAsFixed(
                                                                              0),
                                                                      TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  )
                                                                  .toList(),
                                                    ),
                                                  ),
                                                  lineBarsData: [
                                                    LineChartBarData(
                                                      spots:
                                                          _workingOperationsChartSpots,
                                                      //isCurved: true,
                                                      colors: [Colors.white70],
                                                      barWidth: 4,
                                                      isStrokeCapRound: true,
                                                      dotData: FlDotData(
                                                        show: false,
                                                      ),
                                                      belowBarData: BarAreaData(
                                                        show: true,
                                                        colors: [
                                                          Colors.white
                                                              .withOpacity(0.0),
                                                          Colors.white30,
                                                        ],
                                                        gradientColorStops: [
                                                          0.2,
                                                          0.8
                                                        ],
                                                        gradientFrom:
                                                            Offset(0, 1),
                                                        gradientTo:
                                                            Offset(0, 0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text('Right'),
                    ],
                  ),
                ),
              );
            } else if (tripState is TripsInitial || tripState is TripsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.grey.shade800,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Si è verificato un errore. ',
                            ),
                            TextSpan(
                              text: 'Riprova',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => _fetch(),
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
