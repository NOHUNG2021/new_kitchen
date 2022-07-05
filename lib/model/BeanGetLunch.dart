class BeanGetLunch {
  bool status;
  String message;
  Data data;

  BeanGetLunch({this.status, this.message, this.data});

  BeanGetLunch.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  OtherIndian otherIndian;

  Data({this.otherIndian});

  Data.fromJson(Map<String, dynamic> json) {
    otherIndian = json['other_indian'] != null
        ? new OtherIndian.fromJson(json['other_indian'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.otherIndian != null) {
      data['other_indian'] = this.otherIndian.toJson();
    }
    return data;
  }
}

class OtherIndian {
  List<Dal> dal;

  OtherIndian({this.dal});

  OtherIndian.fromJson(Map<String, dynamic> json) {
    if (json['Dal'] != null) {
      dal = new List<Dal>();
      json['Dal'].forEach((v) {
        dal.add(new Dal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dal != null) {
      data['Dal'] = this.dal.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dal {
  String menuId;
  String cuisinetype;
  String itemname;
  String itemprice;
  String instock;
  String image;

  Dal(
      {this.menuId,
        this.cuisinetype,
        this.itemname,
        this.itemprice,
        this.instock,
        this.image});

  Dal.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    cuisinetype = json['cuisinetype'];
    itemname = json['itemname'];
    itemprice = json['itemprice'];
    instock = json['instock'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['cuisinetype'] = this.cuisinetype;
    data['itemname'] = this.itemname;
    data['itemprice'] = this.itemprice;
    data['instock'] = this.instock;
    data['image'] = this.image;
    return data;
  }
}