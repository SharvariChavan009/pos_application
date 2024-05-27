import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pos_application/features/home/presentation/bloc/set_table/set_table_event.dart';
import 'package:pos_application/features/home/presentation/bloc/set_table/set_table_state.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../../core/common/api_constants.dart';

class SetTableBloc extends Bloc<SetTableEvent, SetTableState> {
  final Dio _dio = Dio();
  var url= ApiConstants.apiCartSetFloorTableUrl;
  String? _dataToken;
  SetTableBloc() : super(SetTableInitial()) {
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
    ));
    on<TableSetPressedEvent>((event, emit) async {
      var box = await Hive.openBox('userData');
      String? cartKey = box.get('cartKey');
      _dataToken = box.get("accessToken");
      try {
        final response = await _dio.post(
          url,
          data: {
            "key": cartKey,
            "diners" : 3,
            "floor_table_id": event.floorTableId
          },
          options: Options(
            headers: {'Content-Type': 'application/json',
              'Authorization': "Bearer $_dataToken"},
          ),
        );
        final success = response.data['data'] != null;
        if (success) {
          Map<String, dynamic> responseData = response.data;
          String floorTableName = responseData['data']['cart']['floor_table']['name'];
          emit(SetTableSuccessState(floorTableName));
        } else {
          emit(SetTableFailureState());
        }

      } catch (error) {
        emit(SetTableFailureState());
      }
    });
  }
}
