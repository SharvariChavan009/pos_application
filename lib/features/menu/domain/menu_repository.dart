import 'package:dio/dio.dart';
import 'package:pos_application/core/common/api_constants.dart';
import 'package:pos_application/features/menu/domain/cart_response.dart';
import 'package:pos_application/features/menu/domain/dio_client.dart';

abstract class CartRepository {
  Future<CartResponse> adjustCart(Map<String, dynamic> data);
  Future<CartResponse> cartFloor(Map<String, dynamic> data);
  Future<CartResponse> cartSummary(Map<String, dynamic> data);
}

class ConcreteCartDataRepository implements CartRepository {
  @override
  Future<CartResponse> adjustCart(Map<String, dynamic> data) async {
    DioClient dioClient = DioClient(Dio());

    final response =
        await dioClient.post("${ApiConstants.apiCartUrl}/adjust", data, auth: true);

    if (response.statusCode == 200) {
      // logger.i("Cart Data");
      // logger.i(response.data["data"]);
      CartResponse responseHolder = CartResponse.fromJson(response.data);

      return responseHolder;
    } else {
      CartResponse responseHolder = CartResponse(data: response.data);
      // logger.e('Failed to fetch cart data: ${response.statusCode}');
      return responseHolder;
    }
  }

  @override
  Future<CartResponse> cartFloor(Map<String, dynamic> data) async {
    DioClient dioClient = DioClient(Dio());

    // Logger logger = Logger();
    final response =
        await dioClient.post(ApiConstants.apiCartSetFloorTableUrl, data, auth: true);

    if (response.statusCode == 200) {
      // logger.i("Cart floor Data");
      // logger.i(response.data["data"]);
      CartResponse responseHolder = CartResponse.fromJson(response.data);

      return responseHolder;
    } else {
      CartResponse responseHolder = CartResponse();
      // logger.e('Failed to fetch cart data: ${response.statusCode}');
      return responseHolder;
    }
  }

  @override
  Future<CartResponse> cartSummary(Map<String, dynamic> data) async {
    DioClient dioClient = DioClient(Dio());

    // Logger logger = Logger();
    final response =
        await dioClient.post(ApiConstants.apiCartSummaryUrl, data, auth: true);

    if (response.statusCode == 200) {
      // logger.i("Cart Summary Data");
      // logger.i(response.data["data"]);
      CartResponse responseHolder = CartResponse(data: response.data);

      return responseHolder;
    } else {
      CartResponse responseHolder = CartResponse(data: response.data);
      // logger.e('Failed to fetch summary data: ${response.statusCode}');
      return responseHolder;
    }
  }
}
