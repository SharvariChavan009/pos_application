enum TableStatus { available, reserved, servicing }
class FloorTable {
  // TableStatus tableStatus = TableStatus.available;
  int tableUsersCount=1;
  bool isSelected = false;
  final int id;
  final String name;
  final int minCapacity;
  final int maxCapacity;
  final String floor;
  final bool active;
  final int extraCapacity;
  final int priority;
  final int tenantUnitId;
   String? status;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;
  final String shareUrl;
  final String? xCord;
  final String? yCord;

  FloorTable({
    required this.id,
    required this.name,
    required this.minCapacity,
    required this.maxCapacity,
    required this.floor,
    required this.active,
    required this.extraCapacity,
    required this.priority,
    required this.tenantUnitId,
    required this.status,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.shareUrl,
     this.xCord,
     this.yCord,
  });

  factory FloorTable.fromJson(Map<String, dynamic> json) {
    return FloorTable(
      id: json['id'],
      name: "${json['name']}",
      minCapacity: json['min_capacity'],
      maxCapacity: json['max_capacity'],
      floor: "${json['floor']}",
      active: json['active'],
      extraCapacity: json['extra_capacity'],
      priority: json['priority'],
      tenantUnitId: json['tenant_unit_id'],
      status: json['status'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      shareUrl: json['share_url'],
      xCord: json['x_cord'],
      yCord: json['y_cord'],
    );
  }
}
