// class OrderData {
//   final List<Order>? data;
//
//   OrderData({
//     this.data,
//   });
//
//   factory OrderData.fromJson(Map<String, dynamic> json) {
//     return OrderData(
//       data: json['data'] != null ? List<Order>.from(json['data'].map((x) => Order.fromJson(x))) : null,
//     );
//   }
// }
//
//
// class Order {
//   final int? id;
//   final String? orderNo;
//   final int? userId;
//   final int? floorTableId;
//   final int? diners;
//   final String? code;
//   final Summary? summary;
//   final Customer? customer;
//   final dynamic address;
//   final dynamic shipping;
//   final dynamic meta;
//   final String? status;
//   final dynamic deletedAt;
//   final int? tenantUnitId;
//   final String? createdAt;
//   final String? updatedAt;
//   final FloorTable? floorTable;
//
//   Order({
//     this.id,
//     this.orderNo,
//     this.userId,
//     this.floorTableId,
//     this.diners,
//     this.code,
//     this.summary,
//     this.customer,
//     this.address,
//     this.shipping,
//     this.meta,
//     this.status,
//     this.deletedAt,
//     this.tenantUnitId,
//     this.createdAt,
//     this.updatedAt,
//     this.floorTable,
//   });
//
//   factory Order.fromJson(Map<String, dynamic> json) {
//     return Order(
//       id: json['id'],
//       orderNo: json['order_no'],
//       userId: json['user_id'],
//       floorTableId: json['floor_table_id'],
//       diners: json['diners'],
//       code: json['code'],
//       summary: json['summary'] != null ? Summary.fromJson(json['summary']) : null,
//       customer: json['customer'] != null ? Customer.fromJson(json['customer']) : null,
//       address: json['address'],
//       shipping: json['shipping'],
//       meta: json['meta'],
//       status: json['status'],
//       deletedAt: json['deleted_at'],
//       tenantUnitId: json['tenant_unit_id'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       floorTable: json['floor_table'] != null ? FloorTable.fromJson(json['floor_table']) : null,
//     );
//   }
// }
//
// class Summary {
//   final Tax? tax;
//   final Promo? promo;
//   final double? total;
//   final Discount? discount;
//   final double? subTotal;
//
//   Summary({
//     this.tax,
//     this.promo,
//     this.total,
//     this.discount,
//     this.subTotal,
//   });
//
//   factory Summary.fromJson(Map<String, dynamic> json) {
//     return Summary(
//       tax: json['tax'] != null ? Tax.fromJson(json['tax']) : null,
//       promo: json['promo'] != null ? Promo.fromJson(json['promo']) : null,
//       total: json['total'],
//       discount: json['discount'] != null ? Discount.fromJson(json['discount']) : null,
//       subTotal: json['sub_total'],
//     );
//   }
// }
//
// class Tax {
//   final String? text;
//   final double? value;
//
//   Tax({
//     this.text,
//     this.value,
//   });
//
//   factory Tax.fromJson(Map<String, dynamic> json) {
//     return Tax(
//       text: json['text'],
//       value: json['value'],
//     );
//   }
// }
//
// class Promo {
//   final String? text;
//   final double? value;
//
//   Promo({
//     this.text,
//     this.value,
//   });
//
//   factory Promo.fromJson(Map<String, dynamic> json) {
//     return Promo(
//       text: json['text'],
//       value: json['value'],
//     );
//   }
// }
//
// class Discount {
//   final String? text;
//   final double? value;
//
//   Discount({
//     this.text,
//     this.value,
//   });
//
//   factory Discount.fromJson(Map<String, dynamic> json) {
//     return Discount(
//       text: json['text'],
//       value: json['value'],
//     );
//   }
// }
//
// 
//
// class FloorTable {
//   final int? id;
//   final String? name;
//   final int? minCapacity;
//   final int? maxCapacity;
//   final String? floor;
//   final bool? active;
//   final int? extraCapacity;
//   final int? priority;
//   final int? tenantUnitId;
//   final dynamic deletedAt;
//   final String? createdAt;
//   final String? updatedAt;
//   final String? shareUrl;
//
//   FloorTable({
//     this.id,
//     this.name,
//     this.minCapacity,
//     this.maxCapacity,
//     this.floor,
//     this.active,
//     this.extraCapacity,
//     this.priority,
//     this.tenantUnitId,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.shareUrl,
//   });
//
//   factory FloorTable.fromJson(Map<String, dynamic> json) {
//     return FloorTable(
//       id: json['id'],
//       name: json['name'],
//       minCapacity: json['min_capacity'],
//       maxCapacity: json['max_capacity'],
//       floor: json['floor'],
//       active: json['active'],
//       extraCapacity: json['extra_capacity'],
//       priority: json['priority'],
//       tenantUnitId: json['tenant_unit_id'],
//       deletedAt: json['deleted_at'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       shareUrl: json['share_url'],
//     );
//   }
// }




class Order {
  final int id;
  final String orderNo;
  final int userId;
  final int floorTableId;
  final int diners;
  final String code;
  final Summary summary;
  final List<Customer> customer;
  final dynamic address;
  final dynamic shipping;
  final dynamic meta;
  final String status;
  final dynamic deletedAt;
  final int tenantUnitId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final FloorTable floorTable;

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
    required this.deletedAt,
    required this.tenantUnitId,
    required this.createdAt,
    required this.updatedAt,
    required this.floorTable,
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
      customer: (json['customer'] as List<dynamic>)
          .map((customerJson) => Customer.fromJson(customerJson))
          .toList(),
      address: json['address'],
      shipping: json['shipping'],
      meta: json['meta'],
      status: json['status'],
      deletedAt: json['deleted_at'],
      tenantUnitId: json['tenant_unit_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      floorTable: FloorTable.fromJson(json['floor_table']),
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
  final int id;
  final String name;
  final int minCapacity;
  final int maxCapacity;
  final String floor;
  final bool active;
  final int extraCapacity;
  final int priority;
  final int tenantUnitId;
  final dynamic deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String shareUrl;

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
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.shareUrl,
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
      deletedAt: json['deleted_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      shareUrl: json['share_url'],
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
