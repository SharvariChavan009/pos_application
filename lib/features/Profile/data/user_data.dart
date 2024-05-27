class UserDataResponse {
  final UserData user;
  final CartItem cart;
  final CurrencyData currency;

  UserDataResponse({
    required this.user,
    required this.cart,
    required this.currency,
  });

  factory UserDataResponse.fromJson(Map<String, dynamic> json) {
    return UserDataResponse(
      user: UserData.fromJson(json['data']['user']),
     cart: CartItem.fromJson(json['data']['cart']),
      currency: CurrencyData.fromJson(json['data']['currency']),
    );
  }
}

class UserData {
  final int id;
  final String name;
  final String email;
  final String phone;
  final DateTime? emailVerifiedAt;
  final String? profilePhotoPath;
  final String? profilePhotoUrl;
  final bool active;
  final dynamic tz;
  final dynamic meta;
  final dynamic deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Tenant> tenants;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.emailVerifiedAt,
    required this.profilePhotoPath,
    required this.active,
    required this.tz,
    required this.meta,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.tenants,
    required this.profilePhotoUrl,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    List<Tenant> tenantList = [];
    try {
      if (json['user_tenant_units'] != null) {
        tenantList = List<Tenant>.from(json['user_tenant_units'].map((tenantJson) => Tenant.fromJson(tenantJson)));
      }
      // print(tenantList);
    } catch (e) {
    }
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      emailVerifiedAt: json['email_verified_at'] != null ? DateTime.parse(json['email_verified_at']) : null,
      profilePhotoPath: json['profile_photo_path'],
      active: json['active'],
      tz: json['tz'],
      meta: json['meta'],
      deletedAt: json['deleted_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      tenants: tenantList,
      profilePhotoUrl: json['profile_photo_url'],
    );
  }
}

class CartItem {
  final int id;
  final String key;
  final int user_id;
  final DateTime updated_at;
  final DateTime created_at;

  CartItem({
    required this.id,
    required this.key,
    required this.user_id,
    required this.updated_at,
    required this.created_at,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      key: json['key'],
      user_id: json['user_id'],
      updated_at: DateTime.parse(json['updated_at']),
      created_at: DateTime.parse(json['created_at']),
    );
  }
}

class Tenant {
  final int id;
  final int tenant_unit_id;
  final int active;
  final dynamic meta;
  final dynamic deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Tenant({
    required this.id,
    required this.tenant_unit_id,
    required this.active,
    required this.meta,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Tenant.fromJson(Map<String, dynamic> json) {
    return Tenant(
      id: json['id'],
      tenant_unit_id: json['tenant_unit_id'],
      active: json['active'],
      meta: json['meta'],
      deletedAt: json['deleted_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class CurrencyData{
  final String sign;
  final String ISO;
  final String currencyName;
 CurrencyData({
   required this.sign,
   required this.ISO,
   required this.currencyName,
 });

  factory CurrencyData.fromJson(Map<String, dynamic> json) {
    return CurrencyData(
      sign: json['sign'],
        ISO: json['iso'],
        currencyName: json['text']
    );
  }
}