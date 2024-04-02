import 'package:dio/dio.dart';

sealed class CustomError {
  final String errorMessage;

  const CustomError(this.errorMessage);
}

class ServerError extends CustomError {
  ServerError(super.errorMessage);

  factory ServerError.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionError:
        return ServerError('لا يوجد اتصال بالإنترنت');

      case DioExceptionType.sendTimeout || DioExceptionType.receiveTimeout:
        return ServerError('يوجد مشكلة في الاتصال بالانترنت');

      case DioExceptionType.badResponse:
        return ServerError.fromResponse(dioError.response!.data);

      case DioExceptionType.cancel:
        return ServerError('تم إلغاء الاتصال بالخادم');

      case DioExceptionType.unknown:
        if (dioError.message!.contains('SocketException')) {
          return ServerError('لا يوجد اتصال بالإنترنت');
        }
        return ServerError('حدث خطأ , يرجى المحاولة مرة أخرى');
      default:
        return ServerError('حدث خطأ، يرجى المحاولة مرة أخرى');
    }
  }

  factory ServerError.fromResponse(Response response) {
    if ( response.statusCode != 200 ) {
      return ServerError(response.data);
    } else if (response.statusCode == 500) {
      return ServerError('خطأ في الخادم الداخلي، يرجى المحاولة لاحقاً');
    } else {
      return ServerError('حدث خطأ، يرجى المحاولة مرة أخرى');
    }
  }

  factory ServerError.fromError(String error) {
    return ServerError(error);
  }
}
