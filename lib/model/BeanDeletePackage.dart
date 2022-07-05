// To parse this JSON data, do
//
//     final beanDeletePackage = beanDeletePackageFromJson(jsonString);

import 'dart:convert';

BeanDeletePackage beanDeletePackageFromJson(String str) =>
    BeanDeletePackage.fromJson(json.decode(str));

String beanDeletePackageToJson(BeanDeletePackage data) =>
    json.encode(data.toJson());

class BeanDeletePackage {
  BeanDeletePackage({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<dynamic> data;

  factory BeanDeletePackage.fromJson(Map<String, dynamic> json) =>
      BeanDeletePackage(
        status: json["status"],
        message: json["message"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}
