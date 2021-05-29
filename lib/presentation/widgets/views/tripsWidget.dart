import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:paperopoli_terminal/core/utils/constants.dart';
import 'package:paperopoli_terminal/core/utils/packages/flutter-countup/lib/countup.dart';
import 'package:paperopoli_terminal/cubits/trips/trips_cubit.dart';
import 'package:paperopoli_terminal/data/models/trip/trip_model.dart';
import 'package:paperopoli_terminal/presentation/screens/home_screen.dart';

class TripsWidget extends StatefulWidget {
  @override
  _TripsWidgetState createState() => _TripsWidgetState();
}

class _TripsWidgetState extends State<TripsWidget> {
  late List<TripModel> _trips;
  late final TextEditingController _deleteTextController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  void dispose() {
    _deleteTextController.dispose();
    super.dispose();
  }

  void _fetch() => context.read<TripsCubit>().fetch(
        user: HomeScreen.of(context)!.getUser(),
      );

  InputDecoration _getInputDecoration(
    String hintText,
    IconData icon,
  ) =>
      InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        fillColor: Colors.grey.withOpacity(0.1),
        filled: false,
        hintStyle: TextStyle(
          color: Colors.black45,
        ),
        hintText: hintText,
        prefixIcon: Icon(
          Ionicons.logo_slack,
          color: Colors.black87,
        ),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
      );

  Widget _tripsBuilder(
    BuildContext context,
    int index,
  ) =>
      Container(
        padding: const EdgeInsets.fromLTRB(
          24,
          16,
          16,
          16,
        ),
        height: 160,
        margin: const EdgeInsets.only(
          right: 24,
          bottom: 24,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: ACCENT_COLORS[index.remainder(ACCENT_COLORS.length)],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Viaggio #${_trips[index].id}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff262539),
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        _deleteTextController.clear();
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'Elimina viaggio',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'Chiudi',
                                ),
                              ),
                            ],
                            content: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Eliminando il viaggio non sarà più visibile in questa sezione e tutte le movimentazioni associate saranno rimosse dal sistema. Per confermare inserisci "${_trips[index].id}" nel campo sottostante.',
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  TextFormField(
                                    validator: (value) =>
                                        value == _trips[index].id.toString()
                                            ? null
                                            : 'Valore errato',
                                    controller: _deleteTextController,
                                    decoration: _getInputDecoration(
                                      'Email',
                                      Icons.email_outlined,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.more_horiz,
                        color: Color(0xff262539),
                      ),
                    ),
                  ],
                ),
                Text(
                  '${_trips[index].time.expectedArrivalTime.toIso8601String().substring(11, 16)} - ${_trips[index].time.actualArrivalTime.toIso8601String().substring(11, 16)}',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Color(0xff242342),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => Expanded(
        child: BlocBuilder<TripsCubit, TripsState>(
          builder: (context, tripState) {
            if (tripState is TripsLoaded) {
              _trips = tripState.trips;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    32,
                    32,
                    56,
                    32,
                  ),
                  child: Container(
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
                            Row(
                              children: [
                                Countup(
                                  begin: 0,
                                  end: _trips.length.toDouble(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff262539),
                                    fontSize: 40,
                                  ),
                                ),
                                Text(
                                  ' Viaggi',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff262539),
                                    fontSize: 40,
                                  ),
                                ),
                              ],
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
                                    size: 26,
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
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 48,
                          ),
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: _trips.length,
                            itemBuilder: _tripsBuilder,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (tripState is TripsLoading || tripState is TripsInitial) {
              return Center(
                child: Lottie.network(
                  'https://assets7.lottiefiles.com/packages/lf20_ikj1qt.json',
                  height: 100,
                  width: 100,
                ),
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

/*class _CalendarWidgetState extends State<CalendarWidget> {
  final List<TripModel> _trips = [];

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
                    end: _trips.length.toDouble(),
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
                          _trips,
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
                      child: Text(
                        'Coming soon...',
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
  OperationSource(List<TripModel> source) {
    appointments = source
        .map(
          (e) => Operation(
            e.id.toString(),
            e.time.expectedArrivalTime,
            e.time.expectedArrivalTime,
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
*/
