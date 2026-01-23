class AdminTable {
  final int tableId;
  final int tableNumber;
  final int capacity;
  final String status;

  AdminTable({
    required this.tableId,
    required this.tableNumber,
    required this.capacity,
    required this.status,
  });

  factory AdminTable.fromJson(Map<String, dynamic> json) {
    return AdminTable(
      tableId: json['tableId'],
      tableNumber: json['tableNumber'],
      capacity: json['capacity'],
      status: json['status'],
    );
  }
}
