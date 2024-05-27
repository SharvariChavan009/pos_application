import 'dart:ui';

import 'package:pos_application/features/auth/presentation/bloc/password_validation_state.dart';

abstract class PasswordValidationEvent{}


final class PasswordValidationPressedEvent extends PasswordValidationEvent{
  String? password;
  PasswordValidationPressedEvent(this.password);
}

class TextFieldValidationInitial extends PasswordValidationState {
  Color? borderColor;
  TextFieldValidationInitial(this.borderColor);
}
