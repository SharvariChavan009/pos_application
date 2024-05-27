import 'package:bloc/bloc.dart';
import 'package:pos_application/features/auth/presentation/bloc/update_timer_event.dart';
import 'package:pos_application/features/auth/presentation/bloc/update_timer_state.dart';



class UpdateTimerBloc extends Bloc<UpdateTimerEvent, UpdateTimerState> {
  UpdateTimerBloc() : super(UpdateTimerInitial()) {
    on<UpdateTimerEvent>((event, emit)async {

      await Future.delayed(const Duration(seconds: 2), () {
        emit(UpdateTimerSuccess()); // Prints after 1 second.
      });
    });
  }
}
