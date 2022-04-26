// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    this.data,
    this.hasMore,
  });

  List<Datum>? data;
  bool? hasMore;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        hasMore: json["hasMore"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "hasMore": hasMore,
      };
}

class Datum {
  Datum({
    this.bearing,
    this.datetime,
    this.distanceFromLast,
    this.gpsStatus,
    this.lat,
    this.lon,
    this.speed,
    this.xAcc,
    this.yAcc,
    this.zAcc,
  });

  double? bearing;
  DateTime? datetime;
  double? distanceFromLast;
  String? gpsStatus;
  double? lat;
  double? lon;
  double? speed;
  double? xAcc;
  double? yAcc;
  double? zAcc;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bearing: json["bearing"].toDouble(),
        datetime: DateTime.parse(json["datetime"]),
        distanceFromLast: json["distanceFromLast"].toDouble(),
        gpsStatus: json["gpsStatus"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        speed: json["speed"].toDouble(),
        xAcc: json["xAcc"].toDouble(),
        yAcc: json["yAcc"].toDouble(),
        zAcc: json["zAcc"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "bearing": bearing,
        "datetime": datetime?.toIso8601String(),
        "distanceFromLast": distanceFromLast,
        "gpsStatus": gpsStatus,
        "lat": lat,
        "lon": lon,
        "speed": speed,
        "xAcc": xAcc,
        "yAcc": yAcc,
        "zAcc": zAcc,
      };
}
