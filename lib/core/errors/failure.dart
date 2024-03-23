import 'dart:js_interop';

import 'package:dio/dio.dart';

sealed class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionError:
        return ServerFailure('لا يوجد اتصال بالإنترنت');

      // case DioExceptionType.sendTimeout:
      //   return ServerFailure('انتهت مدة الانتظار أثناء إرسال الطلب إلى الخادم');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('انتهت مدة الانتظار أثناء استقبال البيانات من الخادم');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(dioError.response!.data);

      case DioExceptionType.cancel:
        return ServerFailure('تم إلغاء الاتصال بالخادم');

      case DioExceptionType.unknown:
        if (dioError.message!.contains('SocketException')) {
          return ServerFailure('لا يوجد اتصال بالإنترنت');
        }
        return ServerFailure('حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى!');
      default:
        return ServerFailure('حدث خطأ، يرجى المحاولة مرة أخرى');
    }
  }

  factory ServerFailure.fromResponse(Response response) {
    if (response.statusCode == 400 || response.statusCode == 300) {
      return ServerFailure(response.data['error']['message']);
    } else if (response.statusCode == 500) {
      return ServerFailure('خطأ في الخادم الداخلي، يرجى المحاولة لاحقاً');
    } else {
      return ServerFailure('حدث خطأ، يرجى المحاولة مرة أخرى');
    }
  }
}
