import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../core/common/api_constants.dart';
import '../../home/domain/repository/menus_repository.dart';
import '../../home/presentation/bloc/menu_list_event.dart';
import 'menu_setting_event.dart';
import 'menu_setting_state.dart';


class MenuSettingBloc extends Bloc<MenuSettingEvent, MenuSettingState> {
  MenuSettingBloc() : super(MenuSettingInitial()) {
    final Dio _dio = Dio();
    on<MenuSettingPressed>((event, emit) async {
      var url= ApiConstants.apiMenuSetting;
      String? _dataToken;
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
      ));
      var box = await Hive.openBox('userData');
      _dataToken = box.get("accessToken");
      try {
        final response = await _dio.post(
            url,
            data: {
              "menu_id" : event.menuId
            },
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $_dataToken',
              },
            )
        );
        if (response.statusCode == 200) {
          final responseData = response.data;
          final data = response.data['data'] as List;

          emit(MenuSettingSuccess());
        } else {
          emit(MenuSettingFailure());
        }
      } catch (error) {
        emit(MenuSettingFailure());
      }
    });
  }
}
