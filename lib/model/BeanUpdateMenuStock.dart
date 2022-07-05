// To parse this JSON data, do
//
//     final beanUpdateMenuStock = beanUpdateMenuStockFromJson(jsonString);

import 'dart:convert';

BeanUpdateMenuStock beanUpdateMenuStockFromJson(String str) =>
    BeanUpdateMenuStock.fromJson(json.decode(str));

String beanUpdateMenuStockToJson(BeanUpdateMenuStock data) =>
    json.encode(data.toJson());

class BeanUpdateMenuStock {
  BeanUpdateMenuStock({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<dynamic> data;

  factory BeanUpdateMenuStock.fromJson(Map<String, dynamic> json) =>
      BeanUpdateMenuStock(
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
