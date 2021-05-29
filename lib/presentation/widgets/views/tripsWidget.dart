import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_animated/auto_animated.dart';
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
  final TextEditingController _deleteTextController = TextEditingController();
  TripModel? _tripToEdit;

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
          Icons.tag,
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

  Widget _getInfoWidgets(int index, TripModel trip) {
    switch (index) {
      case 0:
        return Text(
          'Orario arrivo: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade600,
          ),
        );
      case 1:
        return Text(
          '${trip.time.expectedArrivalTime.toIso8601String().substring(11, 16)} - ${trip.time.actualArrivalTime.toIso8601String().substring(11, 16)}',
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        );
      case 2:
        return Text(
          'Orario partenza: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade600,
          ),
        );
      case 3:
        return Text(
          '${trip.time.expectedDepartureTime.toIso8601String().substring(11, 16)} - ${trip.time.actualDepartureTime.toIso8601String().substring(11, 16)}',
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        );
      case 4:
        return Text(
          'Banchina: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade600,
          ),
        );
      case 5:
        return Text(
          trip.quay.description,
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        );
      case 6:
        return Text(
          'Movimentazioni: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade600,
          ),
        );
      case 7:
        return Text(
          trip.operations.length.toString(),
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        );
      default:
        return SizedBox();
    }
  }

  Widget _tripsBuilder(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) =>
      FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          child: GestureDetector(
            onTap: () => setState(() {
              _tripToEdit = _trips[index];
            }),
            child: Container(
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
                          PopupMenuButton(
                            elevation: 48,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            icon: Icon(
                              Icons.more_horiz,
                              color: Color(0xff262539),
                            ),
                            onSelected: (value) async {
                              switch (value) {
                                case 0:
                                  _deleteTextController.clear();
                                  return await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      actionsPadding: const EdgeInsets.only(
                                        right: 16,
                                      ),
                                      title: Text(
                                        'Elimina viaggio',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            'Annulla',
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            'ELIMINA',
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                      content: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.20,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Eliminando il viaggio non sarà più visibile in questa sezione e tutte le movimentazioni associate saranno rimosse dal sistema.\n\nPer confermare inserisci "${_trips[index].id}" nel campo sottostante.',
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            TextFormField(
                                              validator: (value) => value ==
                                                      _trips[index]
                                                          .id
                                                          .toString()
                                                  ? null
                                                  : 'Valore errato',
                                              controller: _deleteTextController,
                                              decoration: _getInputDecoration(
                                                'ID',
                                                Icons.email_outlined,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                default:
                                  break;
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem<int>(
                                value: 0,
                                enabled: true,
                                height: 40,
                                child: Text(
                                  'Elimina',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: 8,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 8,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 0,
                        ),
                        itemBuilder: (context, grid_index) => _getInfoWidgets(
                          grid_index,
                          _trips[index],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
                  child: AnimatedSwitcher(
                    duration: Duration(
                      milliseconds: 500,
                    ),
                    child: _tripToEdit == null
                        ? Column(
                            key: ValueKey('Column 1'),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Countup(
                                        begin: 0,
                                        end: _trips.length.toDouble(),
                                        duration: Duration(
                                          seconds: 1,
                                        ),
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
                                child: LiveGrid(
                                  shrinkWrap: true,
                                  showItemDuration: Duration(
                                    milliseconds: 300,
                                  ),
                                  showItemInterval: Duration(
                                    microseconds: 200,
                                  ),
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
                          )
                        : FutureBuilder(
                            future: Future.delayed(
                              Duration(
                                milliseconds: 500,
                              ),
                            ),
                            builder: (context, snapshot) => snapshot
                                        .connectionState ==
                                    ConnectionState.done
                                ? Column(
                                    key: ValueKey('Column 2'),
                                    children: [
                                      Row(
                                        children: [
                                          MaterialButton(
                                            onPressed: () => setState(
                                              () => _tripToEdit = null,
                                            ),
                                            elevation: 0,
                                            padding: const EdgeInsets.all(16),
                                            hoverElevation: 0,
                                            highlightElevation: 0,
                                            shape: CircleBorder(),
                                            color: Color(0xffF9F9F9),
                                            child: Icon(
                                              Icons.arrow_back_ios_new,
                                              color: Color(0xff333333),
                                              size: 24,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Text(
                                            'Viaggio #${_tripToEdit!.id}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff262539),
                                              fontSize: 40,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 64,
                                          left: 32,
                                        ),
                                        child: GridView.count(
                                          shrinkWrap: true,
                                          crossAxisCount: 2,
                                          childAspectRatio: 10,
                                          mainAxisSpacing: 0,
                                          crossAxisSpacing: 0,
                                          children: [
                                            Text(
                                              'ID',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade600,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              _tripToEdit!.id.toString(),
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              'Banchina',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade600,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              _tripToEdit!.quay.description,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              'Arrivo previsto',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade600,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                MaterialButton(
                                                  onPressed: () =>
                                                      showDatePicker(
                                                    context: context,
                                                    initialDate: _tripToEdit!
                                                        .time
                                                        .expectedArrivalTime,
                                                    firstDate: _tripToEdit!.time
                                                        .expectedArrivalTime,
                                                    lastDate: _tripToEdit!.time
                                                        .expectedDepartureTime,
                                                  ),
                                                  elevation: 0,
                                                  highlightElevation: 0,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 12,
                                                    horizontal: 24,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  color: Color(0xffF9F9F9),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          right: 16,
                                                        ),
                                                        child: Icon(
                                                          Icons.calendar_today,
                                                        ),
                                                      ),
                                                      Text(
                                                        _tripToEdit!.time
                                                            .expectedArrivalTime
                                                            .toIso8601String()
                                                            .substring(0, 10),
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 24,
                                                ),
                                                MaterialButton(
                                                  onPressed: () =>
                                                      showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.fromDateTime(
                                                      _tripToEdit!.time
                                                          .expectedArrivalTime,
                                                    ),
                                                  ),
                                                  elevation: 0,
                                                  highlightElevation: 0,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 12,
                                                    horizontal: 24,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  color: Color(0xffF9F9F9),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          right: 16,
                                                        ),
                                                        child: Icon(
                                                          Icons.schedule,
                                                        ),
                                                      ),
                                                      Text(
                                                        _tripToEdit!.time
                                                            .expectedArrivalTime
                                                            .toIso8601String()
                                                            .substring(11, 19),
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Arrivo effettivo',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade600,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                MaterialButton(
                                                  onPressed: () =>
                                                      showDatePicker(
                                                    context: context,
                                                    initialDate: _tripToEdit!
                                                        .time
                                                        .expectedArrivalTime,
                                                    firstDate: _tripToEdit!
                                                        .time.actualArrivalTime,
                                                    lastDate: _tripToEdit!
                                                        .time.actualArrivalTime,
                                                  ),
                                                  elevation: 0,
                                                  highlightElevation: 0,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 12,
                                                    horizontal: 24,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  color: Color(0xffF9F9F9),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          right: 16,
                                                        ),
                                                        child: Icon(
                                                          Icons.calendar_today,
                                                        ),
                                                      ),
                                                      Text(
                                                        _tripToEdit!.time
                                                            .actualArrivalTime
                                                            .toIso8601String()
                                                            .substring(0, 10),
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 24,
                                                ),
                                                MaterialButton(
                                                  onPressed: () =>
                                                      showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.fromDateTime(
                                                      _tripToEdit!.time
                                                          .actualArrivalTime,
                                                    ),
                                                  ),
                                                  elevation: 0,
                                                  highlightElevation: 0,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 12,
                                                    horizontal: 24,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  color: Color(0xffF9F9F9),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          right: 16,
                                                        ),
                                                        child: Icon(
                                                          Icons.schedule,
                                                        ),
                                                      ),
                                                      Text(
                                                        _tripToEdit!.time
                                                            .actualArrivalTime
                                                            .toIso8601String()
                                                            .substring(11, 19),
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Partenza prevista',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade600,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                MaterialButton(
                                                  onPressed: () =>
                                                      showDatePicker(
                                                    context: context,
                                                    initialDate: _tripToEdit!
                                                        .time
                                                        .expectedDepartureTime,
                                                    firstDate: _tripToEdit!.time
                                                        .expectedArrivalTime,
                                                    lastDate: _tripToEdit!.time
                                                        .expectedDepartureTime,
                                                  ),
                                                  elevation: 0,
                                                  highlightElevation: 0,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 12,
                                                    horizontal: 24,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  color: Color(0xffF9F9F9),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          right: 16,
                                                        ),
                                                        child: Icon(
                                                          Icons.calendar_today,
                                                        ),
                                                      ),
                                                      Text(
                                                        _tripToEdit!.time
                                                            .expectedDepartureTime
                                                            .toIso8601String()
                                                            .substring(0, 10),
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 24,
                                                ),
                                                MaterialButton(
                                                  onPressed: () =>
                                                      showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.fromDateTime(
                                                      _tripToEdit!.time
                                                          .expectedDepartureTime,
                                                    ),
                                                  ),
                                                  elevation: 0,
                                                  highlightElevation: 0,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 12,
                                                    horizontal: 24,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  color: Color(0xffF9F9F9),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          right: 16,
                                                        ),
                                                        child: Icon(
                                                          Icons.schedule,
                                                        ),
                                                      ),
                                                      Text(
                                                        _tripToEdit!.time
                                                            .expectedDepartureTime
                                                            .toIso8601String()
                                                            .substring(11, 19),
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Partenza effettiva',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade600,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                MaterialButton(
                                                  onPressed: () =>
                                                      showDatePicker(
                                                    context: context,
                                                    initialDate: _tripToEdit!
                                                        .time
                                                        .expectedArrivalTime,
                                                    firstDate: _tripToEdit!.time
                                                        .expectedArrivalTime,
                                                    lastDate: _tripToEdit!.time
                                                        .actualDepartureTime,
                                                  ),
                                                  elevation: 0,
                                                  highlightElevation: 0,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 12,
                                                    horizontal: 24,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  color: Color(0xffF9F9F9),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          right: 16,
                                                        ),
                                                        child: Icon(
                                                          Icons.calendar_today,
                                                        ),
                                                      ),
                                                      Text(
                                                        _tripToEdit!.time
                                                            .actualDepartureTime
                                                            .toIso8601String()
                                                            .substring(0, 10),
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 24,
                                                ),
                                                MaterialButton(
                                                  onPressed: () =>
                                                      showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.fromDateTime(
                                                      _tripToEdit!.time
                                                          .actualDepartureTime,
                                                    ),
                                                  ),
                                                  elevation: 0,
                                                  highlightElevation: 0,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 12,
                                                    horizontal: 24,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  color: Color(0xffF9F9F9),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          right: 16,
                                                        ),
                                                        child: Icon(
                                                          Icons.schedule,
                                                        ),
                                                      ),
                                                      Text(
                                                        _tripToEdit!.time
                                                            .actualDepartureTime
                                                            .toIso8601String()
                                                            .substring(11, 19),
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Center(
                                    child: Text(
                                      'Viaggio #${_tripToEdit!.id}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff262539),
                                        fontSize: 40,
                                      ),
                                    ),
                                  ),
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
