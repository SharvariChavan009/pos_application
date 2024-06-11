import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pos_application/features/home/presentation/bloc/floor_table_event.dart';
import 'package:pos_application/features/home/presentation/bloc/floor_table_state.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../../core/common/api_constants.dart';
import '../../data/floor_tables.dart';

class FloorTableBloc extends Bloc<FloorTableEvent, FloorTableState> {
  final Dio _dio = Dio();
  var url = ApiConstants.apiGetFloorTables;
  String? _dataToken;
  FloorTableBloc() : super(FloorTableStateInitial()) {
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
    ));
    on<FloorTableButtonPressed>((event, emit) async {
      var box = await Hive.openBox('userData');
      _dataToken = box.get("accessToken");
      try {
        final response = await _dio.get(url,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $_dataToken',
              },
            ));
        if (response.statusCode == 200) {
          final dynamic responseData = response.data;
          final List<dynamic> menuData = responseData['data'];
          List<FloorTable> floors =
              menuData.map((json) => FloorTable.fromJson(json)).toList();
          emit(FloorTableStateSuccess(floors));
        } else {
          emit(FloorTableStateFailure());
        }
      } catch (error) {
        emit(FloorTableStateFailure());
      }
    });
    on<FloorTableAddButtonPressed>((event, emit) async {
      var box = await Hive.openBox('userData');
      _dataToken = box.get("accessToken");
      var dict = {
        "name": event.floorName,
        "min_capacity": event.minCapacity,
        "max_capacity": event.maxCapacity,
        "extra_capacity": event.extraCapacity,
        "floor": event.floor,
      };

      String? bearerToken = "Bearer $_dataToken";
      try {
        final response = await _dio.post(url,
            data: dict,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $bearerToken',
              },
            ));
        if (response.statusCode == 200) {
          final dynamic responseData = response.data;
          final List<dynamic> menuData = responseData['data'];
          List<FloorTable> floors =
              menuData.map((json) => FloorTable.fromJson(json)).toList();
          emit(FloorTableStateSuccess(floors));
        } else {
          emit(FloorTableStateFailure());
        }
      } catch (error) {
        emit(FloorTableStateFailure());
      }
      add(FloorTableButtonPressed());
    });
  }
}

class FloorTableSortBloc extends Bloc<FloorTableSortEvent, FloorTableState> {
  FloorTableSortBloc() : super(FloorTableSortInitialState()) {
    on<FloorTableSortEvent>((event, emit) async {
      String? sortBy = event.sortBy;
      List<FloorTable>? floorTables = event.floorTableList;
      switch (sortBy) {
        case "Available":
          List<FloorTable> placedOrders = floorTables!
              .where((order) => order.status == "Available")
              .toList();
          emit(FloorTableSortSuccess(placedOrders));
          break;
        case "Reserved":
          List<FloorTable> placedOrders = floorTables!
              .where((order) => order.status == "Reserved")
              .toList();
          emit(FloorTableSortSuccess(placedOrders));
          break;
        case "Serving":
          List<FloorTable> placedOrders =
              floorTables!.where((order) => order.status == "Serving").toList();
          emit(FloorTableSortSuccess(placedOrders));
          break;
        case "All Tables":
          emit(FloorTableSortSuccess(floorTables!));
          break;
        default:
          emit(FloorTableSortSuccess(floorTables!));
      }
    });
  }
}
