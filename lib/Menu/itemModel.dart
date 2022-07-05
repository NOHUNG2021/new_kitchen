// To parse this JSON data, do
//
//     final itemModel = itemModelFromJson(jsonString);

import 'dart:convert';

ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
  ItemModel({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thurday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  List<Monday> monday;
  List<Tuesday> tuesday;
  List<Wednesday> wednesday;
  List<Thurday> thurday;
  List<Friday> friday;
  List<Saturday> saturday;
  List<Sunday> sunday;

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        monday:
            List<Monday>.from(json["Monday"].map((x) => Monday.fromJson(x))),
        tuesday:
            List<Tuesday>.from(json["Tuesday"].map((x) => Tuesday.fromJson(x))),
        wednesday: List<Wednesday>.from(
            json["Wednesday"].map((x) => Wednesday.fromJson(x))),
        thurday:
            List<Thurday>.from(json["Thurday"].map((x) => Thurday.fromJson(x))),
        friday:
            List<Friday>.from(json["Friday"].map((x) => Friday.fromJson(x))),
        saturday: List<Saturday>.from(
            json["Saturday"].map((x) => Saturday.fromJson(x))),
        sunday:
            List<Sunday>.from(json["Sunday"].map((x) => Sunday.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Monday": List<dynamic>.from(monday.map((x) => x.toJson())),
        "Tuesday": List<dynamic>.from(tuesday.map((x) => x.toJson())),
        "Wednesday": List<dynamic>.from(wednesday.map((x) => x.toJson())),
        "Thurday": List<dynamic>.from(thurday.map((x) => x.toJson())),
        "Friday": List<dynamic>.from(friday.map((x) => x.toJson())),
        "Saturday": List<dynamic>.from(saturday.map((x) => x.toJson())),
        "Sunday": List<dynamic>.from(sunday.map((x) => x.toJson())),
      };
}

class Monday {
  Monday({
    this.mondayImage,
    this.list,
  });

  String mondayImage;
  List<ListElement> list;

  factory Monday.fromJson(Map<String, dynamic> json) => Monday(
        mondayImage: json["monday_image"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "monday_image": mondayImage,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ListElement {
  ListElement({this.menuId, this.itemname, this.itemprice, this.quantity});

  String menuId;
  String itemname;
  String itemprice;
  int quantity;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        menuId: json["menu_id"],
        itemname: json["itemname"],
        itemprice: json["itemprice"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "menu_id": menuId,
        "itemname": itemname,
        "itemprice": itemprice,
        "quantity": quantity,
      };
}

class Friday {
  Friday({
    this.fridayImage,
    this.list,
  });

  String fridayImage;
  List<ListElement> list;

  factory Friday.fromJson(Map<String, dynamic> json) => Friday(
        fridayImage: json["friday_image"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "friday_image": fridayImage,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class Saturday {
  Saturday({
    this.saturdayImage,
    this.list,
  });

  String saturdayImage;
  List<ListElement> list;

  factory Saturday.fromJson(Map<String, dynamic> json) => Saturday(
        saturdayImage: json["saturday_image"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "saturday_image": saturdayImage,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class Sunday {
  Sunday({
    this.sundayImage,
    this.list,
  });

  String sundayImage;
  List<ListElement> list;

  factory Sunday.fromJson(Map<String, dynamic> json) => Sunday(
        sundayImage: json["sunday_image"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sunday_image": sundayImage,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class Thurday {
  Thurday({
    this.thurdayImage,
    this.list,
  });

  String thurdayImage;
  List<ListElement> list;

  factory Thurday.fromJson(Map<String, dynamic> json) => Thurday(
        thurdayImage: json["thurday_image"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "thurday_image": thurdayImage,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class Tuesday {
  Tuesday({
    this.tuesdayImage,
    this.list,
  });

  String tuesdayImage;
  List<ListElement> list;

  factory Tuesday.fromJson(Map<String, dynamic> json) => Tuesday(
        tuesdayImage: json["tuesday_image"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tuesday_image": tuesdayImage,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class Wednesday {
  Wednesday({
    this.wednesdayImage,
    this.list,
  });

  String wednesdayImage;
  List<ListElement> list;

  factory Wednesday.fromJson(Map<String, dynamic> json) => Wednesday(
        wednesdayImage: json["wednesday_image"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "wednesday_image": wednesdayImage,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}
