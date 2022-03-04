import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retry/retry.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

const BASE_URL =
    "https://us-central1-mynextbase-connect.cloudfunctions.net/sampleData?page=0";

class HttpService {
  // Dio _dio;

  static header() => {"Content-Type": "application/json"};

  Future<HttpService> init() async {
    // _dio = Dio(BaseOptions(baseUrl: BASE_URL, headers: header()));
    // initInterceptors();
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

  // Future<dynamic> request(
  //     {String url, Method method, Map<String, dynamic> params}) async {
  //   Response response;
  //
  //   try {
  //     if (method == Method.POST) {
  //       response = await _dio.post(url, data: params);
  //     } else if (method == Method.DELETE) {
  //       response = await _dio.delete(url);
  //     } else if (method == Method.PATCH) {
  //       response = await _dio.patch(url);
  //     } else {
  //       const r = RetryOptions(maxAttempts: 8);
  //       response = await r.retry(
  //         // Make a GET request
  //         () => _dio
  //             .get(url, queryParameters: params)
  //             .timeout(const Duration(seconds: 5)),
  //         // Retry on SocketException or TimeoutException
  //         retryIf: (e) =>
  //             e is SocketException || e is TimeoutException || e is DioError,
  //       );
  //       if (kDebugMode) {
  //         print(response);
  //       }
  //       if (response.statusCode == 200) {
  //         if (kDebugMode) {
  //           print('google.com is running');
  //         }
  //         return response;
  //       } else {
  //         if (kDebugMode) {
  //           print('google.com is not available...');
  //         }
  //       }
  //
  //       // response = await _dio.get(url, queryParameters: params);
  //     }
  //   } finally {}
  // }

  Future<dynamic> request(
      {String url, Method method, Map<String, dynamic> params, Dio dio}) async {
    initInterceptors(dio);
    Response response;

    try {
      if (method == Method.POST) {
        response = await dio.post(url, data: params);
      } else if (method == Method.DELETE) {
        response = await dio.delete(url);
      } else if (method == Method.PATCH) {
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

        // response = await _dio.get(url, queryParameters: params);
      }
    } finally {}
  }
}
