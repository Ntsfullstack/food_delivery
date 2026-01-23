class AdminTableStatus {
  final int tableId;
  final int tableNumber;
  final int capacity;
  final String status;
  final bool isOccupied;
  final String? customerName;
  final int? currentOrderId;

  AdminTableStatus({
    required this.tableId,
    required this.tableNumber,
    required this.capacity,
    required this.status,
    required this.isOccupied,
    this.customerName,
    this.currentOrderId,
  });

  factory AdminTableStatus.fromJson(Map<String, dynamic> json) {
    return AdminTableStatus(
      tableId: json['tableId'],
      tableNumber: json['tableNumber'],
      capacity: json['capacity'],
      status: json['status'],
      isOccupied: json['isOccupied'] ?? false,
      customerName: json['currentOrder'] != null ? json['currentOrder']['customerName'] : json['customerName'],
      currentOrderId: json['currentOrder'] != null ? json['currentOrder']['orderId'] : json['currentOrderId'],
    );
  }
}
