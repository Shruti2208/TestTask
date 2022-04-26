import 'package:dio/dio.dart' as d;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nextbase_task/common/constants.dart';
import 'package:nextbase_task/data_model.dart';

import 'networking/api_service.dart';

class APIRepository {
  static header() => {"Content-Type": "application/json"};

  int pageNum = 0;
  Future<DataModel> getData(String baseUrl) async {
    List<Datum> graphData = [];
    HttpService httpService = HttpService();
    httpService.init();
    graphData = await concatenatedGraphData(
        httpService, graphData, baseUrl + "$pageNum");
    DataModel completeData = DataModel(data: graphData);
    return completeData;
  }

  Future<List<Datum>> concatenatedGraphData(
      HttpService httpService, List<Datum> graphData, String baseUrl) async {
    Dio _dio;
    _dio = Dio(BaseOptions(baseUrl: BASE_URL, headers: header()));
    final result = await httpService
        .request(url: baseUrl, method: Method.GET, dio: _dio, params: {});
    if (kDebugMode) {
      print(baseUrl);
    }
    if (result != null) {
      if (result is d.Response) {
        var data = DataModel.fromJson(result.data);
        graphData.addAll(data.data);
        if (data.hasMore) {
          pageNum += 1;
          await concatenatedGraphData(
              httpService, graphData, Constants.baseUrl + "$pageNum");
        }
      }
    }
    return graphData;
  }
}
