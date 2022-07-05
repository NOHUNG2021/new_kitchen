


class UpdateItemStock {
  UpdateItemStock({
    this.status,
    this.message,
  });

  bool status;
  String message;

  factory UpdateItemStock.fromJson(Map<String, dynamic> json) =>
      UpdateItemStock(
        status: json["status"],
        message: json["message"] );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}