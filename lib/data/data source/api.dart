import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:laborex_distribution_app/data/models/deliver_order_state/deliver_order_state.dart';

class ApiService {
  final String baseUrl; // Replace this with your server URL
  late Dio _dio;

  ApiService(this.baseUrl) {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<List<DeliverOrderStateModel>> fetchDataFromServer(String token) async {
    try {
      final response = await _dio.get(
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
          'https://dms.ebdaa-business.com/api/v1/order/driver-orders');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        return data
            .map((item) => DeliverOrderStateModel.fromMap(item))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
