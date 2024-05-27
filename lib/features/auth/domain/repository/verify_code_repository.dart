import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/features/auth/presentation/bloc/verify_code/verify_code_event.dart';
import 'package:pos_application/features/auth/presentation/bloc/verify_code/verify_code_state.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../../core/common/api_constants.dart';

class VerifyCodeBloc extends Bloc<VerifyCodeEvent, VerifyCodeState> {
  final Dio _dio = Dio();
  var url= ApiConstants.apiVerifyCOde;
  VerifyCodeBloc() : super(VerifyCodeInitial()) {
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
    ));
    on<VerifyCodePressedEvent>((event, emit) async{
      try {
        final response = await _dio.get(
          url,
          data: {
            "email": event.code,
            "device_name": "desktop",
          },
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
        );
        final success = response.data['data'] != null;
        if (success) {
          emit(VerifyCodeSuccess());
        } else {
          emit(VerifyCodeFailure());
        }

      } catch (error) {
        emit(VerifyCodeFailure());
      }
    });
  }
}
