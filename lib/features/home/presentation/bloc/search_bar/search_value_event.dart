import 'package:pos_application/features/home/data/menu_list.dart';


abstract class SearchValueEvent {}

class SearchValuePressed extends SearchValueEvent{
  final List<MenuItem> searchedFoodItem;
  String? searchValue;
  SearchValuePressed(this.searchedFoodItem,this.searchValue);
}
