import 'dart:convert';
class GetCategoryItems {
  bool status;
  String message;
  List<Data> data;

  GetCategoryItems({this.status, this.message, this.data});

  GetCategoryItems.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
// "data": [
// {
// "menu_id": "11",
// "item_name": "Tandoori Chicken",
// "item_price": "299",
// "description": "",
// "meal_for": [
// "Dinner"
// ],
// "item_type": "nonveg",
// "cuisine_type": [
// "Other Cuisine"
// ],
// "dish_type": "mild",
// "image": "https://nohungkitchen.notionprojects.tech/assets/image/noimage.jpg",
// "instock": "y",
// "created_at": "2022-06-09 02:42:26"
// },
class Data {
  Data({
    this.menuId,
    this.itemName,
    this.itemPrice,
    this.mealFor,
    this.itemType,
    this.cuisineType,
    this.dishType,
    this.image,
    this.instock,
    this.description,
    this.createddate,
  });

  String menuId;
  String itemName;
  String itemPrice;
  List<String> mealFor;
  String itemType;
  List<String> cuisineType;
  String dishType;
  String image;
  String instock;
  String description;
  DateTime createddate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        menuId: json["menu_id"],
        itemName: json["item_name"],
        itemPrice: json["item_price"],
        mealFor: new List<String>.from(json["meal_for"]),
        itemType: json["item_type"],
        cuisineType: new List<String>.from(json["cuisine_type"]),
        dishType: json["dish_type"],
        image: json["image"],
        instock: json["instock"],
        description: json["description"],
        createddate: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "menu_id": menuId,
        "item_name": itemName,
        "item_price": itemPrice,
        "meal_for": mealFor,
        "item_type": itemType,
        "cuisine_type": cuisineType,
        "dish_type": dishType,
        "image": image,
        "instock": instock,
        "description": description,
        "createddate": createddate.toIso8601String(),
      };
}