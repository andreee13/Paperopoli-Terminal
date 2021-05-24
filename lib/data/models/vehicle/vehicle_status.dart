class VehicleStatus {
  final int id;
  final DateTime timestamp;
  final String name;

  VehicleStatus({
    required this.id,
    required this.timestamp,
    required this.name,
  });
}

//TODO: REMOVE
enum VehicleStatusName {
  onGround,
  onShip,
  leaved,
}
