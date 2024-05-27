abstract class CancelOrderState {}

final class CancelOrderInitial extends CancelOrderState {}
final class CancelOrderSuccess extends CancelOrderState {}
final class CancelOrderFailure extends CancelOrderState {}
