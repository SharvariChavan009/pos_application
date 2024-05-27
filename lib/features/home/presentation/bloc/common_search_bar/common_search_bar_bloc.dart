import 'package:bloc/bloc.dart';
import 'package:pos_application/features/home/data/menu_list.dart';
import 'common_search_bar_event.dart';
import 'common_search_bar_state.dart';



class CommonSearchValueBloc extends Bloc<CommonSearchValueEvent, CommonSearchValueState> {
  CommonSearchValueBloc() : super(CommonSearchValueInitial()) {
    on<CommonSearchValuePressed>((event, emit) {
      // var foodList =
      var searchedList = event.searchedFoodItem
          .where((foodItem) => foodItem.name
          .toLowerCase()
          .contains(event.searchValue!.toLowerCase()))
          .toList();
      emit(CommonSearchValueSuccess(searchedList));
    });

  }
}
