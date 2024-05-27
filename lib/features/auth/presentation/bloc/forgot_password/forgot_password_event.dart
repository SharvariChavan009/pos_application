
abstract class ForgotPasswordEvent {}

final class ForgotPasswordButtonPressed extends ForgotPasswordEvent{
  String? email;
  ForgotPasswordButtonPressed({this.email});
}