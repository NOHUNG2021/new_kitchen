// To parse this JSON data, do
//
//     final beanAddMenu = beanAddMenuFromJson(jsonString);

import 'dart:convert';

BeanAddMenu beanAddMenuFromJson(String str) =>
    BeanAddMenu.fromJson(json.decode(str));

String beanAddMenuToJson(BeanAddMenu data) => json.encode(data.toJson());

class BeanAddMenu {
  BeanAddMenu({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory BeanAddMenu.fromJson(Map<String, dynamic> json) => BeanAddMenu(
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
    this.packagename,
    this.cuisinetype,
    this.mealtype,
    this.mealfor,
    this.weeklyDetail,
    this.weeklyPlanType,
    this.monthlyPlanType,
    this.startDate,
    this.includingSaturday,
    this.includingSunday,
  });

  String packageId;
  String packagename;
  String cuisinetype;
  // List<String> cuisinetype;
  String mealtype;
  String mealfor;
  String weeklyPlanType;
  String monthlyPlanType;
  String startDate;
  String includingSaturday;
  String includingSunday;
  List<WeeklyDetail> weeklyDetail;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        packageId: json["package_id"],
        packagename: json["packagename"],
        cuisinetype: json["cuisinetype"],
        // cuisinetype: new List<String>.from(json["cuisinetype"]),
        mealtype: json["mealtype"],
        mealfor: json["mealfor"],
        weeklyPlanType: json["weeklyplantype"],
        monthlyPlanType: json["monthlyplantype"],
        startDate: json["startdate"],
        includingSaturday:json["including_saturday"],
        includingSunday:json["including_sunday"],
        weeklyDetail: List<WeeklyDetail>.from(
            json["weekly_detail"].map((x) => WeeklyDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "package_id": packageId,
        "packagename": packagename,
        "cuisinetype": cuisinetype,
        "mealtype": mealtype,
        "mealfor": mealfor,
        "weeklyplantype":weeklyPlanType,
        "monthlyplantype": monthlyPlanType,
        "startdate":startDate,
        "including_saturday":includingSaturday,
        "including_sunday":includingSunday,
        "weekly_detail":
            List<dynamic>.from(weeklyDetail.map((x) => x.toJson())),
      };
}

class WeeklyDetail {
  WeeklyDetail({
    this.day,
    this.image,
    this.itemName,
  });

  int day;

  String image;
  String itemName;

  factory WeeklyDetail.fromJson(Map<String, dynamic> json) => WeeklyDetail(
        day: json["day"],
        image: json["image"],
        itemName: json["item_name"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "image": image,
        "item_name": itemName,
      };
}
