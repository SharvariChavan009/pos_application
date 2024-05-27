abstract class CancelOrderEvent {}

final class CancelOrderButtonPressed extends CancelOrderEvent{
  String? reason;
  int? floorTableId;
  CancelOrderButtonPressed(this.reason,this.floorTableId);
}
