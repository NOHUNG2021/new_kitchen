import 'dart:convert';

ReadyToPickupOrder readyToPickupOrderFromJson(String str) =>
    ReadyToPickupOrder.fromJson(json.decode(str));

String readyToPickupOrderToJson(ReadyToPickupOrder data) =>
    json.encode(data.toJson());

class ReadyToPickupOrder {
  ReadyToPickupOrder({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<dynamic> data;

  factory ReadyToPickupOrder.fromJson(Map<String, dynamic> json) =>
      ReadyToPickupOrder(
        status: json["status"],
        message: json["message"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}
