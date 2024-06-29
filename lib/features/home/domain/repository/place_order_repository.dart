import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../core/common/api_constants.dart';
import '../../presentation/bloc/order_bloc/place_order_event.dart';
import '../../presentation/bloc/order_bloc/place_order_state.dart';

class PlaceOrderBloc extends Bloc<PlaceOrderEvent, PlaceOrderState> {
  final Dio _dio = Dio();
  var url= ApiConstants.apiOrderPlaceUrl;
  String? _dataToken;
  PlaceOrderBloc() : super(PlaceOrderInitial()) {
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
    ));
    on<CompleteOrderButtonPressed>((event, emit) async {
      var box = await Hive.openBox('userData');
      String? cartKey = box.get('cartKey');
      _dataToken = box.get("accessToken");
      try {
        final response = await _dio.post(
          url,
          data: {
            "key": cartKey,
            "floor_table_id": event.tableId,
            "customer":
              {"name": "Swapnil Kondekar",
                "amount": 121.0,
                "is_modified": 0}

          },
          options: Options(
            headers: {'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': "Bearer $_dataToken"
            },
          ),
        );
        final success = response.data['data'] != null;
        if (success) {
          emit(PlaceOrderSuccess(response.data['data']['order_no']));
          await Future.delayed(const Duration(seconds: 10), () {
            emit(PlaceOrderInitial());
          });
        } else {
          emit(PlaceOrderFailure());
        }
      } catch (error) {
        emit(PlaceOrderFailure());
      }
    });
  }
}
