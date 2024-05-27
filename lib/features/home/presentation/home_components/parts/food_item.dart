class FoodItem {
  final int? id;
  final String name;
  final String? description;
  late final String? imageUrl;
  final String? offerPrice;
  final double? amount;
  int quantity;

  FoodItem(
      {this.id,
      required this.name,
      this.description,
      this.imageUrl,
      this.offerPrice,
      this.amount,
      this.quantity = 0});
}
