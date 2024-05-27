
abstract class PasswordValidationState {}

final class PasswordValidationInitial extends PasswordValidationState {}
final class PasswordValidationSuccess extends PasswordValidationState {}
final class PasswordValidationFailure extends PasswordValidationState {}
