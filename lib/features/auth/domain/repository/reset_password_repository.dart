import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/features/auth/presentation/bloc/reset_password/reset_password_event.dart';
import 'package:pos_application/features/auth/presentation/bloc/reset_password/reset_password_state.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../../core/common/api_constants.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final Dio _dio = Dio();
  var url= ApiConstants.apiResetPassword;
  ResetPasswordBloc() : super(ResetPasswordInitial()) {
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
    ));
    on<ResetPasswordButtonPressed>((event, emit) async {
      try {
        final response = await _dio.post(
          url,
          data: {
            "email": event.email,
            "token": event.token,
          "password": event.password,
          "password_confirmation": event.password_confirmation},
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
        );
        final success = response.data['data'] != null;
        if (success) {
          var resultMessage = response.data['data']['message'];
          emit(ResetPasswordSuccess(message: resultMessage));
        } else {
          emit(ResetPasswordFailure());
        }
      } catch (error) {
        emit(ResetPasswordFailure());
      }
    });
  }
}
