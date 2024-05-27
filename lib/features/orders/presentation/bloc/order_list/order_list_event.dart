import '../../../data/order_data.dart';

abstract class OrderListEvent {}

final class OrderListShowEvent extends OrderListEvent{
}

//list
final class OrderListShowDetailsEvent extends OrderListEvent{
  int? orderID;
  OrderListShowDetailsEvent(this.orderID);
}

//payment
final class OrderPaymentEvent extends OrderListEvent{
  int? orderID;
  double? amount;
  String? paymentType;
  OrderPaymentEvent(this.orderID,this.amount,this.paymentType);
}

//sort
final class OrderListSortEvent extends OrderListEvent{
  String? sortBy;
  List<Order>? orders;
  OrderListSortEvent(this.sortBy,this.orders);
}