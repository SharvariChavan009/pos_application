import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio);

  Future<Response> get(String url, {bool auth = false}) async {
    try {
      var header = {
        'Accept': 'application/json',
      };
      if (auth) {
        var box = await Hive.openBox('authBox');
        header["Authorization"] = "Bearer ${box.get("authToken")}";
      }
      final response = await _dio.get(url,
          options: Options(
            headers: header,
          ));
      return response;
    } catch (e) {
      throw Exception('Failed to make GET request: $e');
    }
  }

  Future<Response> post(String url, dynamic data, {bool auth = false}) async {
    try {
      var header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      if (auth) {
        var box = await Hive.openBox('authBox');
        header["Authorization"] = "Bearer ${box.get("authToken")}";
      }
      final response = await _dio.post(url,
          data: data,
          options: Options(
            headers: header,
          ));

      return response;
    } catch (e) {
      if (e is DioException) {
        return e.response!;
      }

      throw Exception('Failed to make POST request: $e');
    }
  }

// Add other HTTP methods as needed (e.g., PUT, DELETE)
}
