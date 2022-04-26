import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:nextbase_task/networking/api_service.dart';

void main() async {
  Dio dio = Dio();
  DioAdapter dioAdapter = DioAdapter(dio: dio);

  Response<dynamic> response;

  group('api data verification', () {
    const baseUrl =
        'https://us-central1-mynextbase-connect.cloudfunctions.net/sampleData?page=0';
    var data = jsonEncode({
      "data": [
        {
          "bearing": 241.360000610352,
          "datetime": "2018-02-22T09:39:46Z",
          "distanceFromLast": 0,
          "gpsStatus": "A",
          "lat": 51.571875,
          "lon": -3.20286661783854,
          "speed": 0.48332756917646,
          "xAcc": 0.0390625,
          "yAcc": -0.046875,
          "zAcc": 0.0234375
        }
      ],
      "hasMore": true
    });

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: baseUrl));
      dioAdapter = DioAdapter(dio: dio);
    });

    test('Fetches data', () async {
      const route =
          'https://us-central1-mynextbase-connect.cloudfunctions.net/sampleData?page=0';

      dioAdapter.onGet(
        route,
        (server) => server.reply(200, data),
        // data: userCredentials,
      );

      // Returns a response with 200 Created success status response code.
      response = await dio.get(
        route,
      );
      expect(response.statusCode, 200);

      response = await HttpService()
          .request(url: baseUrl, method: Method.GET, dio: dio, params: {});
      expect(response.data, data);
    });
  });
}
