import 'dart:convert';

GetOfferDetail getOfferDetailFromJson(String str) =>
    GetOfferDetail.fromJson(json.decode(str));

String getOfferDetailToJson(GetOfferDetail data) => json.encode(data.toJson());

class GetOfferDetail {
  GetOfferDetail({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory GetOfferDetail.fromJson(Map<String, dynamic> json) => GetOfferDetail(
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
    this.offerId,
    this.userId,
    this.title,
    this.offercode,
    this.discounttype,
    this.discountValue,
    this.startdate,
    this.enddate,
    this.starttime,
    this.endtime,
    this.appliesto,
    this.minrequirement,
    this.usagelimit,
    this.maxAmount,
    this.minAmount,
    this.description,
    this.uptoAmount,
    this.createddate,
  });

  String offerId;
  String userId;
  String title;
  String offercode;
  String discounttype;
  String discountValue;
  DateTime startdate;
  DateTime enddate;
  String starttime;
  String endtime;
  String appliesto;
  String minrequirement;
  String usagelimit;
  String maxAmount;
  String minAmount;
  String description;
  String uptoAmount;
  DateTime createddate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        offerId: json["offer_id"],
        userId: json["user_id"],
        title: json["title"],
        offercode: json["offercode"],
        discounttype: json["discounttype"],
        discountValue: json["discount_value"],
        startdate: DateTime.parse(json["startdate"]),
        enddate: DateTime.parse(json["enddate"]),
        starttime: json["starttime"],
        endtime: json["endtime"],
        appliesto: json["appliesto"],
        minrequirement: json["minrequirement"],
        usagelimit: json["usagelimit"],
        maxAmount: json["maximum_amount"],
        minAmount: json["minimum_amount"],
        description: json["description"],
        uptoAmount : json['upto_amount'] ?? "0",
        createddate: DateTime.parse(json["createddate"]),
      );

  Map<String, dynamic> toJson() => {
        "offer_id": offerId,
        "user_id": userId,
        "title": title,
        "offercode": offercode,
        "discounttype": discounttype,
        "discount_value": discountValue,
        "startdate":
            "${startdate.year.toString().padLeft(4, '0')}-${startdate.month.toString().padLeft(2, '0')}-${startdate.day.toString().padLeft(2, '0')}",
        "enddate":
            "${enddate.year.toString().padLeft(4, '0')}-${enddate.month.toString().padLeft(2, '0')}-${enddate.day.toString().padLeft(2, '0')}",
        "starttime": starttime,
        "endtime": endtime,
        "appliesto": appliesto,
        "minrequirement": minrequirement,
        "usagelimit": usagelimit,
        "upto_amount": uptoAmount,
        "createddate": createddate.toIso8601String(),
      };
}
