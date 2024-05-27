import 'package:bloc/bloc.dart';
import 'package:pos_application/features/home/presentation/bloc/search_bar/search_value_event.dart';
import 'package:pos_application/features/home/presentation/bloc/search_bar/search_value_state.dart';



class SearchValueBloc extends Bloc<SearchValueEvent, SearchValueState> {
  SearchValueBloc() : super(SearchValueInitial()) {
    on<SearchValuePressed>((event, emit) {

    var searchedList = event.searchedFoodItem
        .where((foodItem) => foodItem.name
        .toLowerCase()
        .contains(event.searchValue!.toLowerCase()))
        .toList();
    print("searchlist");
    print(searchedList.length);
      emit(SearchValueSuccess(searchedList));
    });
  }
}
