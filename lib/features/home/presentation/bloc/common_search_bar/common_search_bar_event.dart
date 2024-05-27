import 'package:pos_application/features/home/data/menu_list.dart';


abstract class CommonSearchValueEvent {}

class CommonSearchValuePressed extends CommonSearchValueEvent{
  final List<MenuItem> searchedFoodItem;
  String? searchValue;
  CommonSearchValuePressed(this.searchedFoodItem,this.searchValue);
}