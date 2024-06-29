import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pos_application/features/home/presentation/bloc/menu_list_event.dart';
import 'package:pos_application/features/home/presentation/bloc/menu_list_state.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../../core/common/api_constants.dart';
import '../../data/menu_list.dart';


class MenuListBloc  extends Bloc<MenuListEvent,MenuListState>{
  final Dio _dio = Dio();
  var url= ApiConstants.apiGetMenus;
  String? _dataToken;
  MenuListBloc() : super(MenuListStateInitial()){
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
    ));
    on<MenuListButtonPressed>((event,emit)async {
      var box = await Hive.openBox('userData');
      _dataToken = box.get("accessToken");
      try {
        final response = await _dio.get(
            url,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': "Bearer $_dataToken",
              },
            )
        );
        if (response.statusCode == 200) {
          final dynamic responseData = response.data;
          final List<dynamic> menuData = responseData['data'];
          List<MenuItem> floors = menuData.map((json) => MenuItem.fromJson(json)).toList();

              emit(MenuListStateSuccess(floors));
        } else {
          emit(MenuListStateFailure());
        }
      } catch (error) {
        emit(MenuListStateFailure());
      }
    });
  }
}
