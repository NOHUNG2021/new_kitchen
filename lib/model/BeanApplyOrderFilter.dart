// To parse this JSON data, do
//
//     final beanApplyOrderFilter = beanApplyOrderFilterFromJson(jsonString);

import 'dart:convert';

BeanApplyOrderFilter beanApplyOrderFilterFromJson(String str) =>
    BeanApplyOrderFilter.fromJson(json.decode(str));

String beanApplyOrderFilterToJson(BeanApplyOrderFilter data) =>
    json.encode(data.toJson());

class BeanApplyOrderFilter {
  BeanApplyOrderFilter({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<dynamic> data;

  factory BeanApplyOrderFilter.fromJson(Map<String, dynamic> json) =>
      BeanApplyOrderFilter(
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
