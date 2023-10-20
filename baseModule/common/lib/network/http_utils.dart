import 'dart:io';

import 'package:common/network/base_response.dart';
import 'package:common/network/common_response.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class HttpUtils {
  static late Dio _dio;
  static bool debug = false;

  static void init() {
    _dio = Dio(BaseOptions(
        baseUrl: "https://baobab.kaiyanapp.com",
        headers: {"Content-Type": "application/json;Charset=UTF-8", "connect": "get"},

        ///连接超时
        connectTimeout: const Duration(milliseconds: 15000),

        ///接收超时
        receiveTimeout: const Duration(milliseconds: 5000),
        contentType: 'application/json;Charset=UTF-8',
        responseType: ResponseType.json));

    ///添加一个拦截器
    _dio.interceptors.add(LogInterceptor());
    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    if (debug) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
        client.findProxy = (uri) {
          return 'PROXY 172.19.34.172:9090';
        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  static Future<BaseResponse> get(String url, {Map<String, String>? params}) async {
    try {
      Response response = await _dio.get(url, queryParameters: params);
      return CommonResponse.handleResponse(response);
    } on Exception catch (e) {
      return CommonResponse.handleException(e);
    }
  }

  static Future<BaseResponse> post(String url, {Map<String, String>? params}) async {
    try {
      Response response = await _dio.post(url, queryParameters: params);
      return CommonResponse.handleResponse(response);
    } on Exception catch (e) {
      return CommonResponse.handleException(e);
    }
  }
}
