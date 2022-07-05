import 'dart:convert';

import 'package:flutter/cupertino.dart';


class KitchenStatus {
  KitchenStatus({
    this.status,
    this.message,
  });

  bool status;
  String message;

  factory KitchenStatus.fromJson(Map<String, dynamic> json) =>
      KitchenStatus(
        status: json["status"],
        message: json["message"] );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}