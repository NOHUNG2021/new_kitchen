// To parse this JSON data, do
//
//     final getChat = getChatFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetChat getChatFromJson(String str) => GetChat.fromJson(json.decode(str));

String getChatToJson(GetChat data) => json.encode(data.toJson());

class GetChat {
  GetChat({
    @required this.status,
    @required this.message,
    @required this.data,
  });

  bool status;
  String message;
  Data data;

  factory GetChat.fromJson(Map<String, dynamic> json) => GetChat(
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

class Data {
  Data({
    @required this.adminName,
    @required this.adminEmail,
    @required this.adminImage,
    @required this.chat,
  });

  String adminName;
  String adminEmail;
  String adminImage;
  List<Chat> chat;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        adminName: json["admin_name"],
        adminEmail: json["admin_email"],
        adminImage: json["admin_image"],
        chat: List<Chat>.from(json["chat"].map((x) => Chat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "admin_name": adminName,
        "admin_email": adminEmail,
        "admin_image": adminImage,
        "chat": List<dynamic>.from(chat.map((x) => x.toJson())),
      };
}

class Chat {
  Chat({
    @required this.createddate,
    @required this.time,
    @required this.msgType,
    @required this.message,
  });

  String createddate;
  String time;
  String msgType;
  String message;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        createddate: json["createddate"],
        time: json["time"],
        msgType: json["msg_type"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "createddate": createddate,
        "time": time,
        "msg_type": msgType,
        "message": message,
      };
}
