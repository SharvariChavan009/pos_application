

abstract class PaymentListEvent {}

final class PaymentListShowEvent extends PaymentListEvent{
}

//
// //sort
// final class OrderListSortEvent extends OrderListEvent{
//   String? sortBy;
//   List<Order>? orders;
//   OrderListSortEvent(this.sortBy,this.orders);
// }