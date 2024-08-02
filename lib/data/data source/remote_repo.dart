import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:laborex_distribution_app/core/errors/custom_error.dart';
import 'package:laborex_distribution_app/presentation/cubit/authentication_cubit.dart';

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

  Future<Map> login(String phoneNumber, String password) async {
    return _handleErrors(() async {
      final response = await _dio.post(
        Constants.loginUrl,
        data: {
          "phoneNumber": phoneNumber,
          "password": password,
        },
      );
      log(response.data.toString());
      if (response.statusCode != 200) {
        throw ServerError.fromResponse(response);
      } else {
        return response.data;
      }
    });
  }

  Future<List<DeliverOrderModel>> getOrders(
      {required String token, required String tenantUUID}) async {
    return _handleErrors<List<DeliverOrderModel>>(() async {
      final response = await _dio.get(
        Constants.getOrdersUrl,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "publicKey": publicKey,
            "x-tenant-id": tenantUUID
          },
        ),
      );
      if (response.statusCode != 200) {
        throw ServerError.fromResponse(response);
      } else {
        final List<dynamic> data = response.data;
        log(data.toString());
        return data.map((item) => DeliverOrderModel.fromMap(item)).toList();
      }
    });
  }

  Future<String> startDelivery(
      {required String token,
      required String orderId,
      required String tenantUUID}) async {
    return _handleErrors<String>(() async {
      final response = await _dio.patch(
        '${Constants.deliveryStartUrl}$orderId',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "publicKey": publicKey,
            "x-tenant-id": tenantUUID
          },
        ),
      );
      if (response.statusCode != 200) {
        throw ServerError.fromResponse(response);
      } else {
        return response.data;
      }
    });
  }

  Future<String> finishOrder(
      {required String token,
      required String orderId,
      required String paymentType,
      required String returnType,
      required double returnedAmount,
      required int returnedItems,
      required String tenantUUID}) async {
    return _handleErrors<String>(() async {
      final response = await _dio.post(
        '${Constants.finishOrderUrl}$orderId',
        data: {
          "paymentType": paymentType,
          "returnType": returnType,
          "returnedAmount": returnedAmount,
          "returnedItems": returnedItems
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "publicKey": publicKey,
            "x-tenant-id": tenantUUID
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

  Future<String> createReturn(
      {required String token,
      required String orderId,
      required String paymentType,
      required String returnType,
      required double returnedAmount,
      required int returnedItems,
      required String tenantUUID}) async {
    return _handleErrors<String>(() async {
      final response = await _dio.post(
        '${Constants.createReturn}$orderId',
        data: {
          "paymentType": paymentType,
          "returnType": returnType,
          "returnedAmount": returnedAmount,
          "returnedItems": returnedItems
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "publicKey": publicKey,
            "x-tenant-id": tenantUUID
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

  Future<List<DeliverOrderModel>> filterOrderByBillNumber(
      {required String token,
      required String tenantUUID,
      required billNumber}) async {
    return _handleErrors<List<DeliverOrderModel>>(() async {
      final response = await _dio.get(
        Constants.filterUsingBillNumber,
        queryParameters: {'billNumber': billNumber},
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "publicKey": publicKey,
            "x-tenant-id": tenantUUID
          },
        ),
      );
      log(response.statusCode.toString());
      if (response.statusCode != 200) {
        throw ServerError.fromResponse(response);
      } else {
        final List<dynamic> data = response.data;
        log(data.toString());
        return data.map((item) => DeliverOrderModel.fromMap(item)).toList();
      }
    });
  }
}
