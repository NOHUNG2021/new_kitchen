// To parse this JSON data, do
//
//     final beanAddPackagePrice = beanAddPackagePriceFromJson(jsonString);

import 'dart:convert';

BeanAddPackagePrice beanAddPackagePriceFromJson(String str) =>
    BeanAddPackagePrice.fromJson(json.decode(str));

String beanAddPackagePriceToJson(BeanAddPackagePrice data) =>
    json.encode(data.toJson());

class BeanAddPackagePrice {
  BeanAddPackagePrice({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<dynamic> data;

  factory BeanAddPackagePrice.fromJson(Map<String, dynamic> json) =>
      BeanAddPackagePrice(
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
