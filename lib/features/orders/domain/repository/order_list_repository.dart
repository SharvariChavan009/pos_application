import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pos_application/features/orders/data/order_details.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../../core/common/api_constants.dart';
import '../../data/order_data.dart';
import '../../presentation/bloc/order_list/order_list_event.dart';
import '../../presentation/bloc/order_list/order_list_state.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListDisplayState> {
  final Dio _dio = Dio();
  OrderListBloc() : super(OrderListInitial()) {

    on<OrderListShowEvent>((event, emit) async {

      var url= ApiConstants.apiPendingOrderUrl;
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
          final responseData = response.data;
          final data = response.data['data'] as List;
          final orders = data.map((json) => Order.fromJson(json)).toList();

          print(orders);
          emit(OrderListSuccessState(orders));
        } else {
          emit(OrderListFailureState());
        }
      } catch (error) {
        emit(OrderListFailureState());
      }
    });

    on<OrderListShowDetailsEvent>((event , emit)async{
      var url= ApiConstants.apiOrderBaseUrl;
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
            "$url/${event.orderID}/show",
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $_dataToken',
              },
            )
        );
        if (response.statusCode == 200) {
          final responseData = response.data;
          OrderDetailsData orders = OrderDetailsData.fromJson(responseData['data']);
          emit(OrderListShowDetailsSuccessState(orders));
        } else {
          emit(OrderListShowDetailsFailureState());
        }
      } catch (error) {
        emit(OrderListShowDetailsFailureState());
      }
    });

    on<OrderListSortEvent>((event,emit){
      String? orderBy = event.sortBy;
      List<Order>? orders = event.orders;

      switch (orderBy!) {
        case "All":
          emit(OrderListSortSuccessState(event.orders!));
          break;
        case "Ready":
          List<Order> placedOrders = orders!.where((order) =>
          order.status == "Ready").toList();
          emit(OrderListSortSuccessState(placedOrders));
          break;
        case "Preparing":
          List<Order> placedOrders = orders!.where((order) =>
          order.status == "Preparing").toList();
          emit(OrderListSortSuccessState(placedOrders));
          break;
        case "Cancelled":
          List<Order> placedOrders = orders!.where((order) =>
          order.status == "Cancelled").toList();
          emit(OrderListSortSuccessState(placedOrders));
          break;
        case "Placed":
          List<Order> placedOrders = orders!.where((order) =>
          order.status == "Placed").toList();
          emit(OrderListSortSuccessState(placedOrders));
        case "Completed":
          List<Order> placedOrders = orders!.where((order) =>
          order.status == "Completed").toList();
          emit(OrderListSortSuccessState(placedOrders));
          break;
      }
    });

    on<OrderPaymentEvent>((event,emit) async {
      var url= ApiConstants.apiOrderBaseUrl;
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
      String type = "${event.paymentType}";
      print("payment type = ${event.paymentType}");
      try {
        final response = await _dio.post(
            "$url/${event.orderID}/payment",
            data: {
              "amount": event.amount,
              "provider": type,
            },
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $_dataToken',
              },
            )
        );
        if (response.statusCode == 201) {
          print(response.data);
         emit(OrderPaymentSuccessState());
        } else {
          emit(OrderPaymentFailureState());
        }
      } catch (error) {
        emit(OrderPaymentFailureState());
      }
    });
  }

}
