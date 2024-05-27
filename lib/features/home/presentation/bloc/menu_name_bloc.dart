
import 'package:bloc/bloc.dart';
import 'menu_name_event.dart';
import 'menu_name_state.dart';
class MenuNameBloc extends Bloc<MenuNameEvent, MenuNameState> {
  MenuNameBloc() : super(MenuNameInitial()) {
    on<MenuNameSelected>((event, emit) async {
      String menuName = event.menuName;
        emit(MenuNameFetchedSuccess(menuName)); // Prints after 1 second.
    });
  }
}
