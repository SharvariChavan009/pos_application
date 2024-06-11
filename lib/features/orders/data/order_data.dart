

class Order {
  final int? id;
  final String? orderNo;
  final int? userId;
  final int? floorTableId;
  final int? diners;
  final String? code;
  final Summary? summary;
  final Customer? customer;
  final dynamic address;
  final dynamic shipping;
  final Meta? meta;
  final String? status;
  final int? tenantUnitId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final FloorTable? floorTable;
  final User? user;

  Order({
    required this.id,
    required this.orderNo,
    required this.userId,
    required this.floorTableId,
    required this.diners,
    required this.code,
    required this.summary,
    required this.customer,
    required this.address,
    required this.shipping,
    required this.meta,
    required this.status,
    required this.tenantUnitId,
    required this.createdAt,
    required this.updatedAt,
    required this.floorTable,
    required this.user,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderNo: json['order_no'],
      userId: json['user_id'],
      floorTableId: json['floor_table_id'],
      diners: json['diners'],
      code: json['code'],
      summary: Summary.fromJson(json['summary']),
      customer: Customer.fromJson(json['customer']),
      address: json['address'],
      shipping: json['shipping'],
      meta: Meta.fromJson(json['meta']),
      status: json['status'],
      tenantUnitId: json['tenant_unit_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      floorTable: FloorTable.fromJson(json['floor_table']),
      user: User.fromJson(json['user']),
    );
  }
}

class Summary {
  final Tax tax;
  final Promo promo;
  final double total;
  final Discount discount;
  final double subTotal;

  Summary({
    required this.tax,
    required this.promo,
    required this.total,
    required this.discount,
    required this.subTotal,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      tax: Tax.fromJson(json['tax']),
      promo: Promo.fromJson(json['promo']),
      total: json['total'].toDouble(),
      discount: Discount.fromJson(json['discount']),
      subTotal: json['sub_total'].toDouble(),
    );
  }
}

class Tax {
  final String text;
  final double value;

  Tax({
    required this.text,
    required this.value,
  });

  factory Tax.fromJson(Map<String, dynamic> json) {
    return Tax(
      text: json['text'],
      value: json['value'].toDouble(),
    );
  }
}

class Promo {
  final String text;
  final double value;

  Promo({
    required this.text,
    required this.value,
  });

  factory Promo.fromJson(Map<String, dynamic> json) {
    return Promo(
      text: json['text'],
      value: json['value'].toDouble(),
    );
  }
}

class Discount {
  final String text;
  final double value;

  Discount({
    required this.text,
    required this.value,
  });

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      text: json['text'],
      value: json['value'].toDouble(),
    );
  }
}

class FloorTable {
  final int? id;
  final String? name;
  final int? minCapacity;
  final int? maxCapacity;
  final String? floor;
  final bool? active;
  final int? extraCapacity;
  final int? priority;
  final int? tenantUnitId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? status;
  final int? WaiterStatus;

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
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.WaiterStatus,
  });

  factory FloorTable.fromJson(Map<String, dynamic> json) {
    return FloorTable(
      id: json['id'],
      name: json['name'],
      minCapacity: json['min_capacity'],
      maxCapacity: json['max_capacity'],
      floor: json['floor'],
      active: json['active'],
      extraCapacity: json['extra_capacity'],
      priority: json['priority'],
      tenantUnitId: json['tenant_unit_id'],
      status: json['status'],
      WaiterStatus: json['WaiterStatus'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Customer {
  final String? name;
  final String? email;
  final String? phone;

  Customer({
    this.name,
    this.email,
    this.phone,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}
class Meta {
  final String? type;


  Meta({
    this.type,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      type: json['type'],
    );
  }
}

class User {
  final String? name;
  final int? id;

  User({
    this.name,
    this.id,

  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      id: json['id']
    );
  }
}
