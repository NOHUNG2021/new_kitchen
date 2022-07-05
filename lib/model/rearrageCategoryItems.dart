class RearrangeCategoryItems {
  RearrangeCategoryItems({
    this.status,
    this.message,
  });

  bool status;
  String message;

  factory RearrangeCategoryItems.fromJson(Map<String, dynamic> json) =>
      RearrangeCategoryItems(
        status: json["status"],
        message: json["message"] );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}