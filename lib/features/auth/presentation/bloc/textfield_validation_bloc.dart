import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pos_application/features/auth/presentation/bloc/textfield_validation_event.dart';
import 'package:pos_application/features/auth/presentation/bloc/textfield_validation_state.dart';

import '../../../../core/common/u_validations_all.dart';

class TextFieldValidationBloc extends Bloc<TextFieldValidation, TextfieldValidationState> {
  TextFieldValidationBloc({required borderColor}) : super(TextfieldValidationInitial()) {
    on<TextfieldValidationEvent>((event, emit) async {
      String? _value = event.textValue;
      if (ValidationsAll.isValidEmail(_value!)) {
        emit(TextFieldValidationSuccess());
      }else{
        emit(TextfieldValidationFailure());
       await Future.delayed(const Duration(seconds: 3), () {
          emit(TextFieldValidationSuccess());// Prints after 1 second.
        });
      }

    });
  }
}
