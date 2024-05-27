import 'package:bloc/bloc.dart';
import 'package:pos_application/features/home/presentation/bloc/table_bloc/set_selected_floor_table_event.dart';
import 'package:pos_application/features/home/presentation/bloc/table_bloc/set_selected_floor_table_state.dart';



class SetSelectedFloorTableBloc extends Bloc<SetSelectedFloorTableEvent, SetSelectedFloorTableState> {
  SetSelectedFloorTableBloc() : super(SetSelectedFloorTableInitial()) {
    on<setSelectedFloorPressed>((event, emit) {
      // TODO: implement event handler
      String? name = event.floorName;
      emit(SetSelectedFloorTableSuccess(name));
    });
  }
}
