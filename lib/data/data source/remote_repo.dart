import 'package:dio/dio.dart';
import 'package:laborex_distribution_app/core/errors/custom_error.dart';

import '../../core/constants.dart';
import '../models/deliver_order_model.dart';

class RemoteRepo {
  final Dio _dio;

  RemoteRepo(
    this._dio,
  );
  set token(String? value) => token = value;

  Future<T> _handleErrors<T>(Future<T> Function() action) async {
    try {
      return await action();
    } catch (error) {

      if (error is DioException) {
        throw ServerError.fromDioError(error);
      } else if (error is CustomError) {
        rethrow;
      } else {
        //TODO neeed better handeling for other type of errors
        throw ServerError.fromError(error.toString());
      }
    }
  }

  Future<String> login(String phoneNumber, String password) async {
    return _handleErrors<String>(() async {
      final response = await _dio.post(
        Constants.loginUrl,
        data: {
          "phoneNumber": phoneNumber,
          "password": password,
        },
      );
      if (response.statusCode != 200) {
        throw ServerError.fromResponse(response);
      }

      else  {
        return response.data['token'];
      }
    });
  }

  Future<List<DeliverOrderModel>> getOrders(String token) async {
    return _handleErrors<List<DeliverOrderModel>>(() async {
      final response = await _dio.get(
        Constants.getOrdersUrl,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

        if (response.statusCode != 200) {
        throw ServerError.fromResponse(response);
      }
      else {
        final List<dynamic> data = response.data;
        return data.map((item) => DeliverOrderModel.fromMap(item)).toList();
      }
    });
  }

  Future<String> startDelivery(String token, String orderId) async {
    return _handleErrors<String>(() async {
      final response = await _dio.patch(
        '${Constants.deliveryStartUrl}$orderId',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
        if (response.statusCode != 200) {
        throw ServerError.fromResponse(response);
      }
      else {
        return response.data;
      }
    });
  }

  Future<String> finishOrder(
    String token,
    String orderId,
    String paymentType,
    String returnType,
    String description,
  ) async {
    return _handleErrors<String>(() async {
      final response = await _dio.post(
        '${Constants.finishOrderUrl}$orderId',
        data: {
          "paymentType": paymentType,
          "returnType": returnType,
          "description": description,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerError.fromResponse(response);
      }
    });
  }
}
