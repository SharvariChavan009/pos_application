
abstract class VerifyCodeEvent {}

final class VerifyCodePressedEvent extends VerifyCodeEvent{
  String? code;
  VerifyCodePressedEvent({this.code});
}