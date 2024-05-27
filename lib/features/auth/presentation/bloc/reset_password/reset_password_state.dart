abstract class ResetPasswordState {}

final class ResetPasswordInitial extends ResetPasswordState {}
final class ResetPasswordSuccess extends ResetPasswordState {
  String? message;
  ResetPasswordSuccess({required this.message});
}
final class ResetPasswordFailure extends ResetPasswordState {}
