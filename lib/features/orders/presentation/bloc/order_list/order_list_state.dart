import 'package:pos_application/features/orders/data/order_data.dart';
import 'package:pos_application/features/orders/data/order_details.dart';

abstract class OrderListDisplayState {}

//list
final class OrderListInitial extends OrderListDisplayState {}
final class OrderListSuccessState extends OrderListDisplayState{
   List<Order>? orderList;
  OrderListSuccessState(this.orderList);
}
final class OrderListFailureState extends OrderListDisplayState{}

//details
final class OrderListShowDetailsInitial extends OrderListDisplayState{}
final class OrderListShowDetailsSuccessState extends OrderListDisplayState{
  OrderDetailsData? orderDetails;
  OrderListShowDetailsSuccessState(this.orderDetails);
}
final class OrderListShowDetailsFailureState extends OrderListDisplayState{}

//payment
final class OrderPaymentInitial extends OrderListDisplayState{}
final class OrderPaymentSuccessState extends OrderListDisplayState{}
final class OrderPaymentFailureState extends OrderListDisplayState{}

//sort
final class OrderListSortInitial extends OrderListDisplayState{}
final class OrderListSortSuccessState extends OrderListDisplayState{
  List<Order>? sortedOrders;
  OrderListSortSuccessState(this.sortedOrders);

}
final class OrderListSortFailureState extends OrderListDisplayState{}
