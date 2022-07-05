class GetLiveOffer {
  bool status;
  String message;
  List<Data> data;

  GetLiveOffer({this.status, this.message, this.data});

  GetLiveOffer.fromJson(Map<String, dynamic> json) {
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

class Data {
  String offerId;
  String userId;
  String title;
  String offercode;
  String discounttype;
  String discountValue;
  String startdate;
  String enddate;
  String starttime;
  String endtime;
  String appliesto;
  String minrequirement;
  String usagelimit;
  String createddate;
  String description;
  String minimumAmount;
  String maximumAmount;
  String uptoAmount;
  dynamic countUsage;

  Data(
      {this.offerId,
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
        this.createddate,
        this.description,
        this.minimumAmount,
        this.maximumAmount,
        this.uptoAmount,
        this.countUsage});

  Data.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id'];
    userId = json['user_id'];
    title = json['title'];
    offercode = json['offercode'];
    discounttype = json['discounttype'];
    discountValue = json['discount_value'];
    startdate = json['startdate'];
    enddate = json['enddate'];
    starttime = json['starttime'];
    endtime = json['endtime'];
    appliesto = json['appliesto'];
    minrequirement = json['minrequirement'];
    usagelimit = json['usagelimit'];
    createddate = json['createddate'];
    description = json['description'];
    minimumAmount = json['minimum_amount'];
    maximumAmount = json['maximum_amount'];
    uptoAmount = json['upto_amount'] ?? "0";
    countUsage =  json['count_usage'] != null ? json['count_usage']:"0";
      }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offer_id'] = this.offerId;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['offercode'] = this.offercode;
    data['discounttype'] = this.discounttype;
    data['discount_value'] = this.discountValue;
    data['startdate'] = this.startdate;
    data['enddate'] = this.enddate;
    data['starttime'] = this.starttime;
    data['endtime'] = this.endtime;
    data['appliesto'] = this.appliesto;
    data['minrequirement'] = this.minrequirement;
    data['usagelimit'] = this.usagelimit;
    data['createddate'] = this.createddate;
    data['description'] = this.description;
    data['minimum_amount'] = this.minimumAmount;
    data['maximum_amount'] = this.maximumAmount;
    data['upto_amount'] = this.uptoAmount;
    data['count_usage'] = this.countUsage;
    return data;
  }
}
