import 'package:pos_application/features/home/data/menu_list.dart';

abstract class SearchValueState {}

final class SearchValueInitial extends SearchValueState {}
final class SearchValueSuccess extends SearchValueState {
  final List<MenuItem> searchedFoodItem; // List of MenuItem objects
  SearchValueSuccess(this.searchedFoodItem);
}
final class SearchValueFailed extends SearchValueState{}
