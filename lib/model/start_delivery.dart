// To parse this JSON data, do
//
//     final beanStartDelivery = beanStartDeliveryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BeanStartDelivery beanStartDeliveryFromJson(String str) =>
    BeanStartDelivery.fromJson(json.decode(str));

String beanStartDeliveryToJson(BeanStartDelivery data) =>
    json.encode(data.toJson());

class BeanStartDelivery {
  BeanStartDelivery({
    this.status,
    this.message,
    this.data,
  });

  final bool status;
  final String message;
  final List<BeanStartDeliveryData> data;

  factory BeanStartDelivery.fromJson(Map<String, dynamic> json) =>
      BeanStartDelivery(
        status: json["status"],
        message: json["message"],
        data: List<BeanStartDeliveryData>.from(
            json["data"].map((x) => BeanStartDeliveryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BeanStartDeliveryData {
  BeanStartDeliveryData({
    @required this.riderLatitude,
    @required this.riderLongitude,
    @required this.deliverylatitude,
    @required this.deliverylongitude,
    @required this.deliveryaddress,
  });

  final String riderLatitude;
  final String riderLongitude;
  final String deliverylatitude;
  final String deliverylongitude;
  final String deliveryaddress;

  factory BeanStartDeliveryData.fromJson(Map<String, dynamic> json) =>
      BeanStartDeliveryData(
        riderLatitude: json["rider_latitude"],
        riderLongitude: json["rider_longitude"],
        deliverylatitude: json["deliverylatitude"],
        deliverylongitude: json["deliverylongitude"],
        deliveryaddress: json["deliveryaddress"],
      );

  Map<String, dynamic> toJson() => {
        "rider_latitude": riderLatitude,
        "rider_longitude": riderLongitude,
        "deliverylatitude": deliverylatitude,
        "deliverylongitude": deliverylongitude,
        "deliveryaddress": deliveryaddress,
      };
}
