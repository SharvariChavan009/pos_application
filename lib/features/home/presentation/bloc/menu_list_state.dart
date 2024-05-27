import 'package:pos_application/features/home/data/menu_list.dart';

abstract class MenuListState{}

class MenuListStateInitial extends MenuListState{}
class MenuListStateSuccess extends MenuListState{
  final List<MenuItem> menus; // List of MenuItem objects

  MenuListStateSuccess(this.menus);
}
class MenuListStateFailure extends MenuListState{}