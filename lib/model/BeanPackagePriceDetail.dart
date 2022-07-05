// To parse this JSON data, do
//
//     final beanPackagePriceDetail = beanPackagePriceDetailFromJson(jsonString);

import 'dart:convert';

BeanPackagePriceDetail beanPackagePriceDetailFromJson(String str) =>
    BeanPackagePriceDetail.fromJson(json.decode(str));

String beanPackagePriceDetailToJson(BeanPackagePriceDetail data) =>
    json.encode(data.toJson());

class BeanPackagePriceDetail {
  BeanPackagePriceDetail({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory BeanPackagePriceDetail.fromJson(Map<String, dynamic> json) =>
      BeanPackagePriceDetail(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.packageId,
    this.actualWeeklyPackage,
    this.actualMonthlyPackage,
    this.weeklyPrice,
    this.monthlyPrice,
  });

  String packageId;
  String actualWeeklyPackage;
  String actualMonthlyPackage;
  String weeklyPrice;
  String monthlyPrice;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        packageId: json["package_id"],
        actualWeeklyPackage: json["actual_weekly_package"],
        actualMonthlyPackage: json["actual_monthly_package"],
        weeklyPrice: json["weekly_price"],
        monthlyPrice: json["monthly_price"],
      );

  Map<String, dynamic> toJson() => {
        "package_id": packageId,
        "actual_weekly_package": actualWeeklyPackage,
        "actual_monthly_package": actualMonthlyPackage,
        "weekly_price": weeklyPrice,
        "monthly_price": monthlyPrice,
      };
}
