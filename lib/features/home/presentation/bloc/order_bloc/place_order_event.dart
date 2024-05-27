abstract class PlaceOrderEvent {}
final class CompleteOrderButtonPressed extends PlaceOrderEvent{
  int? tableId;
  CompleteOrderButtonPressed(this.tableId);
}