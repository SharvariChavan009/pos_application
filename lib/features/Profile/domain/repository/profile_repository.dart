import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pos_application/features/Profile/presentation/bloc/profile_event.dart';
import 'package:pos_application/features/Profile/presentation/bloc/profile_state.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../../core/common/api_constants.dart';
import '../../data/user_data.dart';


class ProfileBloc  extends Bloc<ProfileEvent,ProfileState>{
  final Dio _dio = Dio();
  var url= ApiConstants.apiGetProfileData;
  String? _dataToken;
  ProfileBloc() : super(ProfileStateInitial()){
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
    ));
    on<ProfileButtonPressed>((event,emit)async {
      var box = await Hive.openBox('userData');
      _dataToken = box.get("accessToken");
      try {
        final response = await _dio.get(
          url,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $_dataToken',
            },
          )
        );
        if (response.statusCode == 200){
         final responseData = response.data;
          UserDataResponse user = UserDataResponse.fromJson(responseData);
          box.put("userName", user.user.name);
          box.put("cartKey", user.cart.key);
          box.put("currency", user.currency.sign);
         emit(ProfileStateSuccess(user: user));
        } else {
          emit(ProfileStateFailure());
        }

      } catch (error) {
        emit(ProfileStateFailure());
      }
    });
  }
}
