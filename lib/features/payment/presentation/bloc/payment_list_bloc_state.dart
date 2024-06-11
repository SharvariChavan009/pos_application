




import 'package:pos_application/features/payment/data/payment_data.dart';

abstract class PaymentListBlocState {}

//list
final class PaymentListInitial extends PaymentListBlocState {}
final class PaymentListSuccessState extends PaymentListBlocState{
  List<Payment>? paymentList;
  PaymentListSuccessState(this.paymentList);
}
final class PaymentListFailureState extends PaymentListBlocState{}

//
// //sort
// final class OrderListSortInitial extends OrderListDisplayState{}
// final class OrderListSortSuccessState extends OrderListDisplayState{
//   List<Order>? sortedOrders;
//   OrderListSortSuccessState(this.sortedOrders);
//
// }
// final class OrderListSortFailureState extends OrderListDisplayState{}
