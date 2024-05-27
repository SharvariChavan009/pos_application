import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pos_application/features/auth/presentation/bloc/login_event.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../../core/common/api_constants.dart';
import '../../presentation/bloc/login_state.dart';


class LoginBloc  extends Bloc<LoginEvent,LoginState>{
  final Dio _dio = Dio();
  var url= ApiConstants.apiLoginUrl;
  String? _accessToken;
  LoginBloc() : super(LoginInitial()){
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
    ));
    on<LoginButtonPressed>((event,emit)async {
      var box = await Hive.openBox('userData');
      var authBox = await Hive.openBox('authBox');
      try {
        final response = await _dio.post(
          url,
          data: {
            "email": event.email,
            "password": event.password,
            "device_name": "desktop",
          },
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
        );
        final success = response.data['data'] != null;
        if (success) {
         _accessToken = response.data['data'];
          box.put("accessToken", _accessToken);
          authBox.put("authToken",_accessToken);
         emit(LoginSuccess(_accessToken));
        } else {
          emit(LoginFailure());
        }

      } catch (error) {
        emit(LoginFailure());
      }
    });
  }
}
