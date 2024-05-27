import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pos_application/features/menu/bloc/add_menu/add_menu_cart_event.dart';
import 'package:pos_application/features/menu/bloc/add_menu/add_menu_cart_state.dart';
import 'package:pos_application/features/menu/domain/cart_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../core/common/api_constants.dart';

  class AddMenuToCartBloc extends Bloc<AddMenuCartEvent, AddMenuCartState> {
  final Dio _dio = Dio();
  var url= ApiConstants.apiCartUrl;
  String? _dataToken;
  AddMenuToCartBloc() : super(AddMenuCartInitial()) {
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
    ));
    on<AddMenuToCartPressed>((event, emit) async {
      var box = await Hive.openBox('userData');
      String? cartKey = box.get('cartKey');
      _dataToken = box.get("accessToken");
      box.put("floorTableID", event.floorTableId);
      try {
        final response = await _dio.post(
          "$url/adjust",
          data: {
              "type": "Menu",
              "key": cartKey,
              "type_id": event.type_id,
              "quantity": event.quantity,
              'floor_table_id': event.floorTableId,
              "method": event.methodName
          },
          options: Options(
            headers: {'Content-Type': 'application/json','Accept': 'application/json',
            'Authorization': 'Bearer $_dataToken'},
          ),
        );
        final success = response.data['data'] != null;
        if (success) {
          final dynamic responseData = response.data;

          final dynamic cartResponse = CartResponse.fromJson(responseData);
          emit(AddMenuCartSuccessState(cartResponse));
        } else {
          emit(AddMenuCartFailureState());
        }

      } catch (error) {
        emit(AddMenuCartFailureState());
      }
    });

    on<GetCartSummary>((event,emit)async{
      var box = await Hive.openBox('userData');
      String? cartKey = box.get('cartKey');
      _dataToken = box.get("accessToken");
      String?  bearerToken = "$_dataToken";
      try {

        final response = await _dio.post(
          "$url/summary",
          data: {
            "key": cartKey,
            'floor_table_id': event.floorTableId,
          },
          options: Options(
            headers: {'Content-Type': 'application/json','Accept': 'application/json',
              'Authorization': 'Bearer $bearerToken'},
          ),
        );
        final success = response.data['data'] != null;
        if (success) {
          final dynamic responseData = response.data;

          final dynamic cartResponse = CartResponse.fromJson(responseData);


          emit(AddMenuCartSuccessState(cartResponse));
        } else {
          emit(AddMenuCartFailureState());
        }

      } catch (error) {
        emit(AddMenuCartFailureState());
      }
    });
  }
}
