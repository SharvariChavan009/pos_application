import 'package:flutter/cupertino.dart';


abstract class ChangeLanguageEvent {}

final class ChangeLanguagePressed extends ChangeLanguageEvent{
  Locale? type;
  ChangeLanguagePressed( this.type);
}