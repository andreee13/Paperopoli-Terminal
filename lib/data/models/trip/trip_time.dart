class TripTime {
  final DateTime expectedDepartureTime;
  final DateTime expectedArrivalTime;
  late DateTime actualDepartureTime;
  late DateTime actualArrivalTime;

  TripTime({
    required this.expectedDepartureTime,
    required this.expectedArrivalTime,
    required this.actualArrivalTime,
    required this.actualDepartureTime,
  });
}
