import 'dart:convert';

GetCategoryItemDetails getCategoryItemDetailsFromJson(String str) =>
    GetCategoryItemDetails.fromJson(json.decode(str));

String getCategoryItemDetailsToJson(GetCategoryItemDetails data) => json.encode(data.toJson());

class GetCategoryItemDetails {
  GetCategoryItemDetails({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory GetCategoryItemDetails.fromJson(Map<String, dynamic> json) => GetCategoryItemDetails(
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
// "data": {
// "category_id": "7",
// "category_name": "Recommended",
// "description": "",
// "created_at": "2022-06-09 02:41:03"
// }
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
