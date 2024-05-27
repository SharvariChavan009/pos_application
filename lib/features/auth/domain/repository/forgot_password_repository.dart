import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/features/auth/presentation/bloc/forgot_password/forgot_password_event.dart';
import 'package:pos_application/features/auth/presentation/bloc/forgot_password/forgot_password_state.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../../core/common/api_constants.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final Dio _dio = Dio();
  var url= ApiConstants.apiForgotPassword;
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
    ));
    on<ForgotPasswordButtonPressed>((event, emit) async{
      try {
        final response = await _dio.post(
          url,
          data: {
            "email": event.email,
          },
          options: Options(
            headers: {'Content-Type': 'application/json'}
          ),
        );
        final success = response.data['data'] != null;
        if (success) {
          String? successMsg = response.data['data']['message'];
          emit(ForgotPasswordSuccess(message: successMsg!));
          await Future.delayed(const Duration(seconds: 2), () {
            emit(ForgotPasswordInitial());
          });
        } else {
          emit(ForgotPasswordFailure());
        }

      } catch (error) {
        emit(ForgotPasswordFailure());
      }
    });
  }
}
