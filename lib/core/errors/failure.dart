
import 'dart:js_interop';

import 'package:dio/dio.dart';


sealed class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError
  (DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionError:
        return ServerFailure(
          'لايوجد اتصال بالانترنت');

      // case DioExceptionType.sendTimeout:
      //   return ServerFailure('Send timeout with ApiServer');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
           
             dioError.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure
        ('تم الغاء الاتصال بالسيرفر');

      case DioExceptionType.unknown:
        if (dioError.message!.contains('SocketException')) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('Unexpected Error, Please try again!');
      default:
        return ServerFailure('Opps There was an Error, Please try again');
    }
  }

  factory ServerFailure.fromResponse
  ( Response response) {
    if (response.statusCode == 400 || 
    response.statusCode == 300 
   ) {
      return ServerFailure
      (response.data['error']['message']);
    // } else if 
    // (response.statusCode == 404) {
    //   return ServerFailure('Your request not found, Please try later!');
    } else if (
      response.statusCode == 500) {
      return ServerFailure('Internal Server error, Please try later');
    } else {
      return ServerFailure('Opps There was an Error, Please try again');
    }
  }
}
