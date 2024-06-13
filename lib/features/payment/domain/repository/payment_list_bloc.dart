import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../core/common/api_constants.dart';
import '../../data/payment_data.dart';
import '../../presentation/bloc/payment_list_bloc_state.dart';
import '../../presentation/bloc/payment_list_event.dart';




class PaymentListBloc extends Bloc<PaymentListEvent, PaymentListBlocState> {
  PaymentListBloc() : super(PaymentListInitial()) {
    final Dio _dio = Dio();
    on<PaymentListShowEvent>((event, emit) async {

      var url= ApiConstants.apiPaymentListUrl;
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
        final response = await _dio.get(
            url,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $_dataToken',
              },
            )
        );
        if (response.statusCode == 200) {
          final data = response.data['data'] as List;
          final paymentList = data.map((json) => Payment.fromJson(json)).toList();

          print("paymentList.length=${paymentList.length}");
          print("paymnet order mnumber =${paymentList[0].order!.orderNo}");
          emit(PaymentListSuccessState(paymentList));
        } else {
          emit(PaymentListFailureState());
        }
      } catch (error) {
        emit(PaymentListFailureState());
      }

    });
  }
}
