class RearrangeCategory {
  RearrangeCategory({
    this.status,
    this.message,
  });

  bool status;
  String message;

  factory RearrangeCategory.fromJson(Map<String, dynamic> json) =>
      RearrangeCategory(
        status: json["status"],
        message: json["message"] );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}