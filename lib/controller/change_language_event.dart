import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ChangeLanguageEvent {}

final class ChangeLanguagePressed extends ChangeLanguageEvent{
  Locale? type;
  ChangeLanguagePressed( this.type);
}