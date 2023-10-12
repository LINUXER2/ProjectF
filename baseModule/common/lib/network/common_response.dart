import 'dart:io';
import 'package:dio/dio.dart';
import 'base_response.dart';

/// https://juejin.cn/post/7048998930595446821
class CommonResponse {
  static BaseResponse handleResponse(
    Response response, {
    CancelToken? cancelToken,
  }) {
    // 返回值异常
    if (response.statusCode != 200) {
      return handleException(
        HttpException(response.statusMessage ?? ""),
        cancelToken: cancelToken,
      );
    }
    return BaseResponse(
      true,
      response.statusMessage,
      response.data,
    );
  }

  ///处理异常
  static BaseResponse handleException(
    Exception exception, {
    CancelToken? cancelToken,
  }) {
    HttpException _parseException;
    if (exception is HttpException) {
      _parseException = exception;
    } else {
      _parseException = parseException(exception);
    }
    return BaseResponse(false, _parseException.message, null);
  }

  ///解析异常
  static HttpException parseException(Exception exception) {
    if (exception is DioException) {
      switch (exception.type) {
        case DioExceptionType.connectionTimeout:
          return const HttpException("连接超时，请重试");
        case DioExceptionType.sendTimeout:
          return const HttpException("请求超时，请稍后重试");
        case DioExceptionType.receiveTimeout:
          return const HttpException("请求失败，请稍后重试");
        case DioExceptionType.cancel: //请求被取消
          return HttpException(exception.message ?? "");
        default: //未知异常
          return HttpException(exception.message ?? "");
      }
    } else {
      return HttpException(exception.toString());
    }
  }
}
