import 'package:flutter/material.dart';
import 'package:flutter_annual_task/flutter_annual_task.dart';
import 'package:paperopoli_terminal/core/utils/packages/flutter-countup/lib/countup.dart';
import 'package:paperopoli_terminal/data/models/ships_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final List<ShipModel> _ships = [];

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
                      'Eventi',
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
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: Text(
                        'Calendario',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: SfCalendar(
                        allowViewNavigation: true,
                        showNavigationArrow: true,
                        showDatePickerButton: true,
                        allowedViews: [
                          CalendarView.month,
                          CalendarView.week,
                        ],
                        view: CalendarView.day,
                        firstDayOfWeek: 1,
                        appointmentBuilder:
                            (context, calendarAppointmentDetails) => Icon(
                          Icons.directions_boat,
                        ),
                        dataSource: OperationSource(
                          _ships,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 16,
                        top: 32,
                      ),
                      child: Text(
                        'Resoconto',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                      ),
                      child: AnnualTaskView(
                        _ships
                            .map(
                              (ship) => AnnualTaskItem(
                                ship.expectedArrivalTime,
                              ),
                            )
                            .toList(),
                        year: DateTime.now().year,
                        labelStyle: TextStyle(
                          fontSize: 13,
                        ),
                        weekDayLabels: [
                          'Domenica',
                          'Lunedì',
                          'Martedì',
                          'Mercoledì',
                          'Giovedì',
                          'Venerdì',
                          'Sabato',
                        ],
                        monthLabels: [
                          'Gennaio',
                          'Febbraio',
                          'Marzo',
                          'Aprile',
                          'Maggio',
                          'Giugno',
                          'Luglio',
                          'Agosto',
                          'Settembre',
                          'Ottobre',
                          'Novembre',
                          'Dicembre',
                        ],
                        activateColor: Colors.red,
                      ),
                    ),
                    SizedBox(
                      height: 64,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

class OperationSource extends CalendarDataSource {
  OperationSource(List<ShipModel> source) {
    appointments = source
        .map(
          (e) => Operation(
            e.id.toString(),
            e.expectedArrivalTime,
            e.expectedArrivalTime,
            Colors.red,
            false,
          ),
        )
        .toList();
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Operation {
  Operation(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
