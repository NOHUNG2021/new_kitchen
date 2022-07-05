import 'dart:convert';

import 'package:flutter/cupertino.dart';

MealScreenItems mealScreenItemsFromJson(String str) =>
    MealScreenItems.fromJson(json.decode(str));
String mealScreenItemsToJson(MealScreenItems data) =>
    json.encode(data.toJson());

MealScreenItemsData mealScreenItemsDataFromJson(String str) =>
    MealScreenItemsData.fromJson(json.decode(str));
String mealScreenItemsDataToJson(MealScreenItemsData data) =>
    json.encode(data.toJson());

Menuitem menuitemFromJson(String str) => Menuitem.fromJson(json.decode(str));
String menuitemToJson(Menuitem data) => json.encode(data.toJson());

class MealScreenItems {
  MealScreenItems({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<MealScreenItemsData> data;

  factory MealScreenItems.fromJson(Map<String, dynamic> json) =>
      MealScreenItems(
        status: json["status"],
        message: json["message"],
        data: List<MealScreenItemsData>.from(
            json["data"].map((x) => MealScreenItemsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MealScreenItemsData {
  MealScreenItemsData({
    this.category,
    this.menuitems,
  });

  String category;
  List<Menuitem> menuitems;

  factory MealScreenItemsData.fromJson(Map<String, dynamic> json) =>
      MealScreenItemsData(
        category: json["category"],
        menuitems: List<Menuitem>.from(
            json["menuitems"].map((x) => Menuitem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "menuitems": List<dynamic>.from(menuitems.map((x) => x.toJson())),
      };
}

class Menuitem {
  Menuitem(
      {this.menuId,
      this.itemname,
      this.itemprice,
      this.isChecked = false,
      this.quantity = 1,
      this.isdefault = false});

  String menuId;
  String itemname;
  String itemprice;
  bool isChecked;
  int quantity;
  bool isdefault;

  factory Menuitem.fromJson(Map<String, dynamic> json) => Menuitem(
        menuId: json["menu_id"],
        itemname: json["itemname"],
        itemprice: json["itemprice"],
        quantity: 1,
      );

  Map<String, dynamic> toJson() => {
        "menu_id": menuId,
        "itemname": itemname,
        "itemprice": itemprice,
        "quantity": quantity,
      };
}
