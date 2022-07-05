// To parse this JSON data, do
//
//     final getAccountDetails = getAccountDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetAccountDetails getAccountDetailsFromJson(String str) =>
    GetAccountDetails.fromJson(json.decode(str));

String getAccountDetailsToJson(GetAccountDetails data) =>
    json.encode(data.toJson());

class GetAccountDetails {
  GetAccountDetails({
    @required this.status,
    @required this.message,
    @required this.data,
  });

  bool status;
  String message;
  Data data;

  factory GetAccountDetails.fromJson(Map<String, dynamic> json) =>
      GetAccountDetails(
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
    @required this.userId,
    @required this.kitchenName,
    @required this.description,
    @required this.address,
    @required this.email,
    @required this.mobileNumber,
    @required this.password,
    @required this.typeOfFirm,
    @required this.typeOfFood,
    @required this.fromTime,
    @required this.toTime,
    @required this.openDays,
    @required this.typeOfMeals,
    @required this.totalrating,
    @required this.menufile,
    @required this.documentfile,
    @required this.profileImage,
    @required this.availableStatus,
    @required this.kitchenId,
  });

  String userId;
  String kitchenName;
  String description;
  String address;
  String email;
  String mobileNumber;
  String password;
  String typeOfFirm;
  List<String> typeOfFood;
  String fromTime;
  String toTime;
  List<String> openDays;
  List<String> typeOfMeals;
  String totalrating;
  String menufile;
  String documentfile;
  String profileImage;
  String availableStatus;
  String kitchenId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        kitchenName: json["kitchen_name"],
        description: json["description"],
        address: json["address"],
        email: json["email"],
        mobileNumber: json["mobile_number"],
        password: json["password"],
        typeOfFirm: json["type_of_firm"],
        typeOfFood: List<String>.from(json["type_of_food"].map((x) => x)),
        fromTime: json["from_time"],
        toTime: json["to_time"],
        openDays: List<String>.from(json["open_days"].map((x) => x)),
        typeOfMeals: List<String>.from(json["type_of_meals"].map((x) => x)),
        totalrating: json["totalrating"],
        menufile: json["menufile"],
        documentfile: json["documentfile"],
        profileImage: json["profile_image"],
        availableStatus : json["available_status"],
        kitchenId: json['kitchenid'],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "kitchen_name": kitchenName,
        "description": description,
        "address": address,
        "email": email,
        "mobile_number": mobileNumber,
        "password": password,
        "type_of_firm": typeOfFirm,
        "type_of_food": List<dynamic>.from(typeOfFood.map((x) => x)),
        "from_time": fromTime,
        "to_time": toTime,
        "open_days": List<dynamic>.from(openDays.map((x) => x)),
        "type_of_meals": List<dynamic>.from(typeOfMeals.map((x) => x)),
        "totalrating": totalrating,
        "menufile": menufile,
        "documentfile": documentfile,
        "profile_image": profileImage,
        "available_status": availableStatus,
        "kitchenid": kitchenId,
      };
}
