class PersonStatus {
  final int id;
  final DateTime timestamp;
  final String name;

  PersonStatus({
    required this.id,
    required this.timestamp,
    required this.name,
  });
}

//TODO:REMOVE
enum PersonStatusname {
  onShip,
  onGround,
  onVehicle,
  none,
}
