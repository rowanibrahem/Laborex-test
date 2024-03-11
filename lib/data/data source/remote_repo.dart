import 'package:dio/dio.dart';

import '../../core/constants.dart';
import '../models/deliver_order_model.dart';

class RemoteRepo {
  final Dio _dio;

  RemoteRepo(
    this._dio,
  );
  set token(String? value) => token = value;

  Future <String> login(String phoneNumber, String password) async {
    try {
      final response = await _dio.post(
        Constants.loginUrl,
        data: {
          "phoneNumber": phoneNumber,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<List<DeliverOrderModel>> getOrders(String token) async {
    try {
      final response = await _dio.get(
        Constants.getOrdersUrl,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      // final response = await _dio.getUri(
      //   Uri.https("dms.ebdaa-business.com", 'api/v1/driver-orders'),
      //   options: Options(
      //     contentType: "application/json",
      //     headers: {
      //       'Authorization': "Bearer $token"
      //     },
      //   ),
      // );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        return data.map((item) => DeliverOrderModel.fromMap(item)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
