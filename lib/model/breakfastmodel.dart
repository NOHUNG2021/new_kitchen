import 'dart:convert';

BreakfastModel breakfastModelFromJson(String str) =>
    BreakfastModel.fromJson(json.decode(str));

String breakfastModelToJson(BreakfastModel data) => json.encode(data.toJson());

class BreakfastModel {
  BreakfastModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  BreakfastModelData data;

  factory BreakfastModel.fromJson(Map<String, dynamic> json) => BreakfastModel(
        status: json["status"],
        message: json["message"],
        data: BreakfastModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class BreakfastModelData {
  BreakfastModelData({
    this.southIndian,
    this.northIndian,
    this.otherIndian,
  });

  List<Indian> southIndian;
  List<Indian> northIndian;
  List<Indian> otherIndian;

  factory BreakfastModelData.fromJson(Map<String, dynamic> json) =>
      BreakfastModelData(
        southIndian: List<Indian>.from(
            json["south_indian"].map((x) => Indian.fromJson(x))),
        northIndian: List<Indian>.from(
            json["north_indian"].map((x) => Indian.fromJson(x))),
        otherIndian: List<Indian>.from(
            json["other_indian"].map((x) => Indian.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "south_indian": List<dynamic>.from(southIndian.map((x) => x.toJson())),
        "north_indian": List<dynamic>.from(northIndian.map((x) => x.toJson())),
        "other_indian": List<dynamic>.from(otherIndian.map((x) => x.toJson())),
      };
}

class Indian {
  Indian({
    this.category,
    this.list,
  });

  String category;
  List<ListElement> list;

  factory Indian.fromJson(Map<String, dynamic> json) => Indian(
        category: json["category"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ListElement {
  ListElement({
    this.menuId,
    this.cuisinetype,
    this.itemname,
    this.itemprice,
    this.instock,
    this.menutype,
    this.image,
  });

  String menuId;
  String cuisinetype;
  String itemname;
  String menutype;
  String itemprice;
  String instock;
  String image;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        menuId: json["menu_id"],
        cuisinetype: json["cuisinetype"],
        menutype: json["menutype"],
        itemname: json["itemname"],
        itemprice: json["itemprice"],
        instock: json["instock"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "menu_id": menuId,
        "cuisinetype": cuisinetype,
        "menutype": menutype,
        "itemname": itemname,
        "itemprice": itemprice,
        "instock": instock,
        "image": image,
      };
}
