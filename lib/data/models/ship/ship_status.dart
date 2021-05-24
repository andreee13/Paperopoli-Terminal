class ShipStatus {
  final int id;
  final DateTime timestamp;
  final String name;

  ShipStatus({
    required this.id,
    required this.timestamp,
    required this.name,
  });
}

//TODO:REMOVE
enum ShipStatusName {
  docked,
  arriving,
  leaving,
  none,
}
