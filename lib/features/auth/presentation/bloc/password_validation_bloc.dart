import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pos_application/features/auth/presentation/bloc/password_validation_event.dart';
import 'package:pos_application/features/auth/presentation/bloc/password_validation_state.dart';
import '../../../../core/common/u_validations_all.dart';

class PasswordValidationBloc extends Bloc<PasswordValidationEvent, PasswordValidationState> {
  PasswordValidationBloc({required borderColor}) : super(PasswordValidationInitial()) {
    on<PasswordValidationPressedEvent>((event, emit) async {
      String? _password = event.password;
      if (ValidationsAll.isValidPassword(_password!) && _password.isNotEmpty) {
        emit(PasswordValidationSuccess());
      } else {
        emit(PasswordValidationFailure());
        await Future.delayed(const Duration(seconds: 3), () {
          emit(PasswordValidationSuccess()); // Prints after 1 second.
        });
      }
    });
  }
}
