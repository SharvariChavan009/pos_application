import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
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
      var box = await Hive.openBox('LanguageData');
      _appLocale = event.type;
      if(event.type == Locale('en')){
        // await sp.setString("language", 'en');
        box.put("language", 'en');
        emit(ChangeLanguageSuccess(Locale('en')));
      }else{
        // await sp.setString("language", 'ar');
        box.put("language", 'ar');
        emit(ChangeLanguageSuccess(Locale('ar')));
      }
    });
  }
}
