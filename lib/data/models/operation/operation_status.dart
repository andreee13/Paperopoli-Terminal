class OperationStatus {
  final DateTime timestamp;
  final String name;

  OperationStatus({
    required this.timestamp,
    required this.name,
  });
}


//TODO: remove
enum OperationStatusname {
  working,
  waiting,
  done,
  none,
}
