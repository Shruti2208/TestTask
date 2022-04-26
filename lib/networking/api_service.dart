import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retry/retry.dart';

enum Method { post, get, put, delete, patch }

const baseUrl =
    "https://us-central1-mynextbase-connect.cloudfunctions.net/sampleData?page=0";

class HttpService {
  // Dio _dio;

  static header() => {"Content-Type": "application/json"};

  Future<HttpService> init() async {
    return this;
  }

  void initInterceptors(Dio dio) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (err, handler) {
          return handler.next(err);
        },
      ),
    );
  }

  Future<dynamic> request(
      {required String url,
      required Method method,
      required Map<String, dynamic> params,
      required Dio dio}) async {
    initInterceptors(dio);
    Response response;

    try {
      if (method == Method.post) {
        response = await dio.post(url, data: params);
      } else if (method == Method.delete) {
        response = await dio.delete(url);
      } else if (method == Method.patch) {
        response = await dio.patch(url);
      } else {
        const r = RetryOptions(maxAttempts: 8);
        response = await r.retry(
          // Make a GET request
          () => dio
              .get(url, queryParameters: params)
              .timeout(const Duration(seconds: 5)),
          // Retry on SocketException or TimeoutException
          retryIf: (e) =>
              e is SocketException || e is TimeoutException || e is DioError,
        );
        if (kDebugMode) {
          print(response);
        }
        if (response.statusCode == 200) {
          if (kDebugMode) {
            print('google.com is running');
          }
          return response;
        } else {
          if (kDebugMode) {
            print('google.com is not available...');
          }
        }
      }
    } finally {}
  }
}
