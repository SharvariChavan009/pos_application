import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'change_language_event.dart';
import 'change_language_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChangeLanguageBloc extends Bloc<ChangeLanguageEvent, ChangeLanguageState> {
  ChangeLanguageBloc() : super(ChangeLanguageInitial()) {
    Locale? _appLocale;
    // Locale? get  appLocale => _appLocale;
    on<ChangeLanguagePressed>((event, emit) async {
      SharedPreferences sp = await SharedPreferences.getInstance();
      _appLocale = event.type;
      if(event.type == Locale('en')){
        await sp.setString("language", 'en');
        emit(ChangeLanguageSuccess(Locale('en')));
      }else{
        await sp.setString("language", 'ar');
        emit(ChangeLanguageSuccess(Locale('ar')));
      }
    });
  }
}
