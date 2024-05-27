abstract class PlaceOrderState {}

final class PlaceOrderInitial extends PlaceOrderState {}

final class PlaceOrderLoading extends PlaceOrderState {}

final class PlaceOrderSuccess extends PlaceOrderState {
  String? orderNo;
  PlaceOrderSuccess(this.orderNo);
}

final class PlaceOrderFailure extends PlaceOrderState {}
