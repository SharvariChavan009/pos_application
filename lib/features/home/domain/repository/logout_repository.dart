import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pos_application/features/home/presentation/bloc/logout_event.dart';
import 'package:pos_application/features/home/presentation/bloc/logout_state.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../../core/common/api_constants.dart';


class LogoutBloc  extends Bloc<LogoutEvent,LogoutState>{
  final Dio _dio = Dio();
  var url= ApiConstants.apiLogout;
  String? _accessToken;
  // String? _bearerToken;
  LogoutBloc() : super(LogoutInitial()){
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
    ));
    on<LogoutButtonPressed>((event,emit)async {
      var box = await Hive.openBox('userData');
      _accessToken = box.get("accessToken");
      String? bearerToken = "Bearer $_accessToken";
      box.put("bearerToken", bearerToken);
      try {
        final response = await _dio.post(
          url,
          options: Options(
            headers: {'Content-Type': 'application/json','Authorization': bearerToken},
          ),
        );
        final success = response.data['data'] != null;
        if (success) {
          box.delete('accessToken');
          Hive.close();
          emit(LogoutSuccess());
          await Future.delayed(const Duration(seconds: 2), () {
            emit(LogoutInitial());
          });
        } else {
          emit(LogoutFailure());
        }

      } catch (error) {
        emit(LogoutFailure());
      }
    });
  }
}
