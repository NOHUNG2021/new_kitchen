class BeanSignUp {
  bool status;
  String message;
  Data data;

  BeanSignUp({this.status, this.message, this.data});

  BeanSignUp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? json['data'] is List?null :new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String kitchenname;
  String email;
  String address;
  String stateid;
  String cityid;
  String pincode;
  String contactname;
  String role;
  String mobilenumber;
  String kitchencontactnumber;
  String fssailicenceno;
  String expirydate;
  String panno;
  String gstno;
  dynamic userstatus;
  dynamic status;
  String createddate;
  String modifieddate;
  dynamic kitchenid;
  String password;
  String menuFile;
  String documentFile;
  String userId;

  Data(
      {this.kitchenname,
      this.email,
      this.address,
      this.stateid,
      this.cityid,
      this.pincode,
      this.contactname,
      this.role,
      this.mobilenumber,
      this.kitchencontactnumber,
      this.fssailicenceno,
      this.expirydate,
      this.panno,
      this.gstno,
      this.userstatus,
      this.status,
      this.createddate,
      this.modifieddate,
      this.kitchenid,
      this.password,
      this.menuFile,
      this.documentFile,
      this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    kitchenname = json['kitchenname'];
    email = json['email'];
    address = json['address'];
    stateid = json['stateid'];
    cityid = json['cityid'];
    pincode = json['pincode'];
    contactname = json['contactname'];
    role = json['role'];
    mobilenumber = json['mobilenumber'];
    kitchencontactnumber = json['kitchencontactnumber'];
    fssailicenceno = json['fssailicenceno'];
    expirydate = json['expirydate'];
    panno = json['panno'];
    gstno = json['gstno'];
    userstatus = json['userstatus'];
    status = json['status'];
    createddate = json['createddate'];
    modifieddate = json['modifieddate'];
    kitchenid = json['kitchenid'];
    password = json['password'];
    menuFile = json['menu_file'];
    documentFile = json['document_file'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kitchenname'] = this.kitchenname;
    data['email'] = this.email;
    data['address'] = this.address;
    data['stateid'] = this.stateid;
    data['cityid'] = this.cityid;
    data['pincode'] = this.pincode;
    data['contactname'] = this.contactname;
    data['role'] = this.role;
    data['mobilenumber'] = this.mobilenumber;
    data['kitchencontactnumber'] = this.kitchencontactnumber;
    data['fssailicenceno'] = this.fssailicenceno;
    data['expirydate'] = this.expirydate;
    data['panno'] = this.panno;
    data['gstno'] = this.gstno;
    data['userstatus'] = this.userstatus;
    data['status'] = this.status;
    data['createddate'] = this.createddate;
    data['modifieddate'] = this.modifieddate;
    data['kitchenid'] = this.kitchenid;
    data['password'] = this.password;
    data['menu_file'] = this.menuFile;
    data['document_file'] = this.documentFile;
    data['user_id'] = this.userId;
    return data;
  }
}
