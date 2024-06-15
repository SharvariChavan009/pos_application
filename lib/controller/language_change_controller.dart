
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeController with ChangeNotifier{
Locale? _appLocale;
Locale? get  appLocale => _appLocale;
void changeLanguage(Locale type)async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  _appLocale = type;
  if(type == Locale('en')){
    await sp.setString("language", 'en');
  }else{
    await sp.setString("language", 'es');
  }
  notifyListeners();
}
}