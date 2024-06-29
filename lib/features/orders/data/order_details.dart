import 'order_data.dart';

class OrderDetailsData {
  final int? id;
  final String? orderNo;
  final int? userId;
  final int? floorTableId;
  final int? diners;
  final String? code;
  final Summary? summary;
  final List<Customer>? customer;
  final String? address;
  final String? shipping;
  final dynamic meta;
  final String? status;
  final DateTime? deletedAt;
  final int? tenantUnitId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final FloorTable? floorTable;
  final List<OrderItem>? orderItems;
  final List<dynamic>? orderPayments;
  final List<OrderHistory>? orderHistories;

  OrderDetailsData({
    this.id,
    this.orderNo,
    this.userId,
    this.floorTableId,
    this.diners,
    this.code,
    this.summary,
    this.customer,
    this.address,
    this.shipping,
    this.meta,
    this.status,
    this.deletedAt,
    this.tenantUnitId,
    this.createdAt,
    this.updatedAt,
    this.floorTable,
    this.orderItems,
    this.orderPayments,
    this.orderHistories,
  });

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) {
    return OrderDetailsData(
      id: json['id'],
      orderNo: json['order_no'],
      userId: json['user_id'],
      floorTableId: json['floor_table_id'],
      diners: json['diners'],
      code: json['code'],
      summary: json['summary'] != null ? Summary.fromJson(json['summary']) : null,
      customer: json['customer'] != null
    ? (json['customer'] as List).map((item) {
      if (item is Map<String, dynamic>) {
        return Customer.fromJson(item);
      } else if (item is String) {
        return Customer(name: item);
      } else {
        throw TypeError(); // Handle unexpected item types
      }
    }).toList()
        : null,
      address: json['address'],
      shipping: json['shipping'],
      meta: json['meta'],
      status: json['status'],
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
      tenantUnitId: json['tenant_unit_id'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      floorTable: json['floor_table'] != null ? FloorTable.fromJson(json['floor_table']) : null,
      orderItems: json['order_items'] != null
          ? (json['order_items'] as List).map((item) => OrderItem.fromJson(item)).toList()
          : null,
      orderPayments: json['order_payments'],
      orderHistories: json['order_histories'] != null
          ? (json['order_histories'] as List).map((item) => OrderHistory.fromJson(item)).toList()
          : null,
    );
  }
}


class Customer {
  final String? name;
  final int? amount;
  final int? is_modified;

  Customer({
    this.name,
    this.amount,
    this.is_modified,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json['name'],
      amount: json['amount'],
      is_modified: json['is_modified'],
    );
  }
}


class OrderItem {
  final int? id;
  final int? orderId;
  final String? orderableType;
  final int? orderableId;
  final dynamic summary;
  final double? price;
  final int? quantity;
  final dynamic meta;
  final int? tenantUnitId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Menu? orderable;

  OrderItem({
    this.id,
    this.orderId,
    this.orderableType,
    this.orderableId,
    this.summary,
    this.price,
    this.quantity,
    this.meta,
    this.tenantUnitId,
    this.createdAt,
    this.updatedAt,
    this.orderable,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      orderId: json['order_id'],
      orderableType: json['orderable_type'],
      orderableId: json['orderable_id'],
      summary: json['summary'],
      price: json['price'],
      quantity: json['quantity'],
      meta: json['meta'],
      tenantUnitId: json['tenant_unit_id'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      orderable: json['orderable'] != null ? Menu.fromJson(json['orderable']) : null,
    );
  }
}

class Menu {
  final int? id;
  final String? name;
  final dynamic menuCode;
  final dynamic description;
  final double? price;
  final int? minQty;
  final int? priority;
  final String? type;
  final bool? active;
  final dynamic resc;
  final dynamic meta;
  final dynamic taxClassId;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double? appliedPrice;
  final List<Media>? media;

  Menu({
    this.id,
    this.name,
    this.menuCode,
    this.description,
    this.price,
    this.minQty,
    this.priority,
    this.type,
    this.active,
    this.resc,
    this.meta,
    this.taxClassId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.appliedPrice,
    this.media,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      name: json['name'],
      menuCode: json['menu_code'],
      description: json['description'],
      price: json['price'],
      minQty: json['min_qty'],
      priority: json['priority'],
      type: json['type'],
      active: json['active'],
      resc: json['resc'],
      meta: json['meta'],
      taxClassId: json['tax_class_id'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      appliedPrice: json['applied_price'],
      media: json['media']!= null
    ? (json['media'] as List).map((item) => Media.fromJson(item)).toList()
        : null,
    );
  }
}

class Media {
  final int id;
  final String modelType;
  final int modelId;
  final String uuid;
  final String collectionName;
  final String name;
  final String fileName;
  final String mimeType;
  final String disk;
  final String conversionsDisk;
  final int size;
  final List<dynamic> manipulations;
  final List<dynamic> customProperties;
  final List<dynamic> generatedConversions;
  final List<dynamic> responsiveImages;
  final int orderColumn;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String originalUrl;
  final String previewUrl;

  Media({
    required this.id,
    required this.modelType,
    required this.modelId,
    required this.uuid,
    required this.collectionName,
    required this.name,
    required this.fileName,
    required this.mimeType,
    required this.disk,
    required this.conversionsDisk,
    required this.size,
    required this.manipulations,
    required this.customProperties,
    required this.generatedConversions,
    required this.responsiveImages,
    required this.orderColumn,
    required this.createdAt,
    required this.updatedAt,
    required this.originalUrl,
    required this.previewUrl,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'],
      modelType: json['model_type'],
      modelId: json['model_id'],
      uuid: json['uuid'],
      collectionName: json['collection_name'],
      name: json['name'],
      fileName: json['file_name'],
      mimeType: json['mime_type'],
      disk: json['disk'],
      conversionsDisk: json['conversions_disk'],
      size: json['size'],
      manipulations: json['manipulations'],
      customProperties: json['custom_properties'],
      generatedConversions: json['generated_conversions'],
      responsiveImages: json['responsive_images'],
      orderColumn: json['order_column'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      originalUrl: json['original_url'],
      previewUrl: json['preview_url'],
    );
  }
}



class OrderHistory {
  final int? id;
  final int? orderId;
  final String? title;
  final dynamic subtitle;
  final String? status;
  final int? tenantUnitId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  OrderHistory({
    this.id,
    this.orderId,
    this.title,
    this.subtitle,
    this.status,
    this.tenantUnitId,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) {
    return OrderHistory(
      id: json['id'],
      orderId: json['order_id'],
      title: json['title'],
      subtitle: json['subtitle'],
      status: json['status'],
      tenantUnitId: json['tenant_unit_id'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }
}
