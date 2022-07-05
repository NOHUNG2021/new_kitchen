import 'dart:convert';

GetCategoryDetails getCategoryDetailsFromJson(String str) =>
    GetCategoryDetails.fromJson(json.decode(str));

String getCategoryDetailsToJson(GetCategoryDetails data) => json.encode(data.toJson());

class GetCategoryDetails {
  GetCategoryDetails({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory GetCategoryDetails.fromJson(Map<String, dynamic> json) => GetCategoryDetails(
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
    this.categoryId,
    this.categoryName,
    this.description,
    this.createddate,
  });

  String categoryId;
  String categoryName;
  String description;
  DateTime createddate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        description: json["description"],
        createddate: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "offer_id": categoryId,
        "user_id": categoryName,
        "description": description,
        "createddate": createddate.toIso8601String(),
      };
}
