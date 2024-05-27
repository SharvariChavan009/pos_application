import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pos_application/core/common/common_messages.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../core/common/api_constants.dart';
import '../../presentation/bloc/order_bloc/cancel_order_event.dart';
import '../../presentation/bloc/order_bloc/cancel_order_state.dart';


class CancelOrderBloc extends Bloc<CancelOrderEvent, CancelOrderState> {
  final Dio _dio = Dio();
  var url= ApiConstants.apiOrderBaseUrl;
  String? _dataToken;
  CancelOrderBloc() : super(CancelOrderInitial()) {
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
    ));
    on<CancelOrderButtonPressed>((event, emit) async {
      var box = await Hive.openBox('userData');
      _dataToken = box.get("accessToken");
      String? bearerToken = "Bearer $_dataToken";
      try {
        final response = await _dio.post(
          "$url/${event.floorTableId}/cancel",
          data: {
            "reason": CustomMessages.cancelCodeReasonMessage,
          },
          options: Options(
            headers: {'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': bearerToken
            },
          ),
        );
        final success = response.data['data'] != null;
        if (success) {
          emit(CancelOrderSuccess());
          await Future.delayed(const Duration(seconds: 3), () {
            emit(CancelOrderInitial());// Prints after 1 second.
          });
        } else {
          emit(CancelOrderFailure());
        }
      } catch (error) {
        emit(CancelOrderFailure());
      }
    });
  }
}
