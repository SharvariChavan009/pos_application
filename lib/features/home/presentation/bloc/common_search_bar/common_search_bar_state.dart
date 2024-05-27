import 'package:pos_application/features/home/data/menu_list.dart';

abstract class CommonSearchValueState {}

final class CommonSearchValueInitial extends CommonSearchValueState {}
final class CommonSearchValueSuccess extends CommonSearchValueState {
  final List<MenuItem> searchedFoodItem; // List of MenuItem objects
  CommonSearchValueSuccess(this.searchedFoodItem);
}
final class CommonSearchValueFailed extends CommonSearchValueState{}
