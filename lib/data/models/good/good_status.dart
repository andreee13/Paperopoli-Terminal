class GoodStatus {
  final int id;
  final DateTime timestamp;
  final String name;

  GoodStatus({
    required this.id,
    required this.timestamp,
    required this.name,
  });
}

//TODO: REMOVE
enum GoodStatusName {
  onShip,
  onGround,
  leaved,
  none,
}
