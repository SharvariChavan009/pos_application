class MenuItem {
  int requiredQuantity=0;
  final int id;
  final String name;
  final String description;
  final int price;
  final int minQty;
  final int priority;
  final String type;
  final bool active;
  final String? resc;
  final String? meta;
  final int? taxClassId;
  final String? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? appliedPrice;
  final List<String> tagNames;
  final List<String> images;
  final List<TenantUnit> tenantUnits;
  final List<MenuCategories> menuCategories;
  final List<dynamic> tags;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.minQty,
    required this.priority,
    required this.type,
    required this.active,
    required this.resc,
    required this.meta,
    required this.taxClassId,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.appliedPrice,
    required this.tagNames,
    required this.tenantUnits,
    required this.menuCategories,
    required this.tags,
    required this.images,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      name: json['name'],
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
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      appliedPrice: json['applied_price'],
      tagNames: List<String>.from(json['tagNames']),
      images: List<String>.from(json['images']),
      tenantUnits: List<TenantUnit>.from(
          json['tenant_units'].map((x) => TenantUnit.fromJson(x))),
      menuCategories: List<MenuCategories>.from(
          json['menu_categories'].map((x) => MenuCategories.fromJson(x))),
      tags: List<dynamic>.from(json['tags']),
    );
  }
}

class TenantUnit {
  final int id;
  final String tenantableType;
  final int tenantableId;
  final int tenantUnitId;
  final DateTime createdAt;
  final DateTime updatedAt;

  TenantUnit({
    required this.id,
    required this.tenantableType,
    required this.tenantableId,
    required this.tenantUnitId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TenantUnit.fromJson(Map<String, dynamic> json) {
    return TenantUnit(
      id: json['id'],
      tenantableType: json['tenantable_type'],
      tenantableId: json['tenantable_id'],
      tenantUnitId: json['tenant_unit_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class MenuCategories {
  bool isSelected = false;
  final int id;
  final String name;


  MenuCategories({
    required this.id,
    required this.name,
  });

  factory MenuCategories.fromJson(Map<String, dynamic> json) {
    return MenuCategories(
      id: json['id'],
      name: json['name'],
    );
  }
}



