import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../errors/exceptions.dart';

class DioClient {
  final Dio _dio = Dio();
  final Options _options = Options();

  Future post(
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
  }) async {
    _setDioInterceptorList();
    _options.headers = <String, dynamic>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    _options.responseType = ResponseType.json;

    if (headers != null) {
      _options.headers?.addAll(headers);
    }

    try {
      final Response response = await _dio.post(
        path,
        data: data,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      throw RemoteException(message: e.message);
    }
  }

  void _setDioInterceptorList() async {
    List<Interceptor> interceptorList = [];
    _dio.interceptors.clear();

    if (kDebugMode) {
      interceptorList.add(_CustomLoggerInterceptor());
    }

    _dio.interceptors.addAll(interceptorList);
  }
}

class _CustomLoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('Request: ${options.path}, ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('Response: ${response.statusCode}, ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('Error: ${err.message}');
    super.onError(err, handler);
  }
}
