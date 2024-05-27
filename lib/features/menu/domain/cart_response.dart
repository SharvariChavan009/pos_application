import 'package:pos_application/features/home/data/floor_tables.dart';

class CartResponse {
  final CartData? data;

  CartResponse({this.data});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      data: CartData.fromJson(json['data']),
    );
  }
}

class CartData {
  final Cart cart;
  final CartSummary summary;
  final CartCurrency currency;

  CartData({
    required this.cart,
    required this.summary,
    required this.currency,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      cart: Cart.fromJson(json['cart']),
      summary: CartSummary.fromJson(json['summary']),
      currency: CartCurrency.fromJson(json['currency']),
    );
  }
}

class Cart {
  final int id;
  final String key;
  final int userId;
  final int? floorTableId;
  final int? promoCodeId;
  final int diners;
  final dynamic clientInfo;
  final dynamic meta;
  final String createdAt;
  final String updatedAt;
  final List<CartItem> cartItems;
  final FloorTable? floorTable;

  Cart({
    required this.id,
    required this.key,
    required this.userId,
    this.floorTableId,
    this.promoCodeId,
    required this.diners,
    this.clientInfo,
    this.meta,
    required this.createdAt,
    required this.updatedAt,
    required this.cartItems,
    this.floorTable,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {

    var cartItemsList = json['cart_items'] as List<dynamic>;
    List<CartItem> items = cartItemsList.map((itemJson) => CartItem.fromJson(itemJson)).toList();

    return Cart(
      id: json['id'],
      key: json['key'],
      userId: json['user_id'],
      floorTableId: json['floor_table_id'],
      promoCodeId: json['promo_code_id'],
      diners: json['diners'],
      clientInfo: json['client_info'],
      meta: json['meta'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      cartItems: items,
      floorTable: FloorTable.fromJson(json['floor_table']),
    );
  }
}

class CartItem {
  int requiredQuantity=0;
  final int id;
  final int cartId;
  final int menuId;
  final int quantity;
  final String? meta;
  final String createdAt;
  final String updatedAt;
  final Menu menu;

  CartItem({
    required this.id,
    required this.cartId,
    required this.menuId,
    required this.quantity,
    this.meta,
    required this.createdAt,
    required this.updatedAt,
    required this.menu,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      cartId: json['cart_id'],
      menuId: json['cartable_id'],
      quantity: json['quantity'],
      meta: json['meta'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      menu: Menu.fromJson(json['cartable']),
    );
  }
}



class CartSummary {
  final double total;
  final double subTotal;
  final CartTax tax;
  final CartDiscount discount;
  final CartPromo promo;

  CartSummary({
    required this.total,
    required this.subTotal,
    required this.tax,
    required this.discount,
    required this.promo,
  });

  factory CartSummary.fromJson(Map<String, dynamic> json) {
    return CartSummary(
      total: double.parse("${json['total']}"),
      subTotal: double.parse("${json['sub_total']}"),
      tax: CartTax.fromJson(json['tax']),
      discount: CartDiscount.fromJson(json['discount']),
      promo: CartPromo.fromJson(json['promo']),
    );
  }
}

class CartTax {
  final String text;
  final double value;

  CartTax({
    required this.text,
    required this.value,
  });

  factory CartTax.fromJson(Map<String, dynamic> json) {
    return CartTax(
      text: json['text'],
      value: double.parse("${json['value']}"),
    );
  }
}

class CartDiscount {
  final String text;
  final double value;

  CartDiscount({
    required this.text,
    required this.value,
  });

  factory CartDiscount.fromJson(Map<String, dynamic> json) {
    return CartDiscount(
      text: json['text'],
      value: double.parse("${json['value']}"),
    );
  }
}

class CartPromo {
  final String text;
  final double value;

  CartPromo({
    required this.text,
    required this.value,
  });

  factory CartPromo.fromJson(Map<String, dynamic> json) {
    return CartPromo(
      text: json['text'],
      value: double.parse("${json['value']}"),
    );
  }
}

class CartCurrency {
  final String sign;
  final String iso;
  final String text;

  CartCurrency({
    required this.sign,
    required this.iso,
    required this.text,
  });

  factory CartCurrency.fromJson(Map<String, dynamic> json) {
    return CartCurrency(
      sign: json['sign'],
      iso: json['iso'],
      text: json['text'],
    );
  }
}

class Menu {
  final int id;
  final String name;
  final String? image;
  final String? shortDesc;
  final String? description;
  final String price;
  final String offerPrice;
  final dynamic deletedAt;
  final dynamic createdAt;
  final dynamic updatedAt;
  final int ?tenantUnitId;
  final String? imageUrl;
  final List<MediaImage> ?mediaImages;
  Menu({
    required this.id,
    required this.name,
    this.image,
    required this.shortDesc,
    required this.description,
    required this.price,
    required this.offerPrice,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.tenantUnitId,
    this.imageUrl,
    this.mediaImages,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    var mediaItemList = json['media'] as List<dynamic>;
    List<MediaImage> items = mediaItemList.map((itemJson) => MediaImage.fromJson(itemJson)).toList();


    return Menu(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      shortDesc: json['short_desc'],
      description: json['description'],
      price: "${json['price']}",
      offerPrice: "${json['offer_price']}",
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      tenantUnitId: json['tenant_unit_id'],
      imageUrl: json['image_url'],
        mediaImages:items
    );
  }
}

class MediaImage{
  int id;
  String? originalUrl;

  MediaImage({
    required this.id,
    this.originalUrl,
  });

  factory MediaImage.fromJson(Map<String, dynamic> json) {
    return MediaImage(
      id: json['id'],
      originalUrl: json['original_url'],
    );
  }
}
