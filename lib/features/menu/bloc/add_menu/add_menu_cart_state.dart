import 'package:pos_application/features/menu/domain/cart_response.dart';

abstract class AddMenuCartState {}

final class AddMenuCartInitial extends AddMenuCartState {}
final class AddMenuCartSuccessState extends AddMenuCartState {
  CartResponse cartResponse;
  AddMenuCartSuccessState(this.cartResponse);
}
final class AddMenuCartFailureState extends AddMenuCartState {}
