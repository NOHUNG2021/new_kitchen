import 'dart:convert';
class GetCategories {
  bool status;
  String message;
  List<Data> data;

  GetCategories({this.status, this.message, this.data});

  GetCategories.fromJson(Map<String, dynamic> json) {
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
// "category_id": "7",
// "category_name": "Recommended",
// "description": "",
// "created_at": "2022-06-09 02:41:03"
// },
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
