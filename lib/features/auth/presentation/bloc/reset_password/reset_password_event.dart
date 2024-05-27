
abstract class ResetPasswordEvent {}

final class ResetPasswordButtonPressed extends ResetPasswordEvent{
  String? email;
  String? password;
  String? password_confirmation;
  String? token;
  ResetPasswordButtonPressed({this.email,this.password, this.password_confirmation,this.token});

}

