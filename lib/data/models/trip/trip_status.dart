class TripStatus {
  final int id;
  final DateTime timestamp;
  final TripStatusName shipStatusName;

  TripStatus({
    required this.id,
    required this.timestamp,
    required this.shipStatusName,
  });
}

enum TripStatusName {
  //TODO
  none,
}
