abstract class AddMenuCartEvent {}

final class AddMenuToCartPressed extends AddMenuCartEvent{
  int? type_id;
  int? quantity;
  int? floorTableId;
  String? methodName;
  AddMenuToCartPressed( this.type_id,  this.quantity,this.floorTableId,this.methodName);
}
  final class GetCartSummary extends AddMenuCartEvent{
    int? floorTableId;
    GetCartSummary(this.floorTableId);
  }