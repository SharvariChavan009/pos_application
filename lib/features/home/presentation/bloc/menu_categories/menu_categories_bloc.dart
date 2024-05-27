import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/features/home/data/menu_list.dart';

class MenuCategoriesBloc extends Cubit<List<MenuCategories>>{
  List<MenuCategories> menuCategories;
  MenuCategoriesBloc(this.menuCategories) : super([]);

  void setCategories(List<MenuCategories> menuCategories2){
    menuCategories=[];
    menuCategories=List<MenuCategories>.from(menuCategories2);


    emit(menuCategories);
  }

  void toggleCategorySelection(int categoryId){
    bool selected=menuCategories.firstWhere((element) => element.id==categoryId).isSelected;
    menuCategories.firstWhere((element) => element.id==categoryId).isSelected=!selected;
    emit(menuCategories);
  }
}