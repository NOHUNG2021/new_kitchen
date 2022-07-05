// ignore_for_file: deprecated_member_use

class GetMenu {
  bool status;
  String message;
  Data data;

  GetMenu({this.status, this.message, this.data});

  GetMenu.fromJson(Map<String, dynamic> json) {
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
  Southindian southindian;

  Data({this.southindian});

  Data.fromJson(Map<String, dynamic> json) {
    southindian = json['southindian'] != null
        ? new Southindian.fromJson(json['southindian'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.southindian != null) {
      data['southindian'] = this.southindian.toJson();
    }
    return data;
  }
}

class Southindian {
  Breakfast breakfast;
  Lunch lunch;

  Southindian({this.breakfast, this.lunch});

  Southindian.fromJson(Map<String, dynamic> json) {
    breakfast = json['breakfast'] != null
        ? new Breakfast.fromJson(json['breakfast'])
        : null;
    lunch = json['lunch'] != null ? new Lunch.fromJson(json['lunch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breakfast != null) {
      data['breakfast'] = this.breakfast.toJson();
    }
    if (this.lunch != null) {
      data['lunch'] = this.lunch.toJson();
    }
    return data;
  }
}

class Breakfast {
  List<Veg> veg;
  List<Nonveg> nonveg;

  Breakfast({this.veg, this.nonveg});

  Breakfast.fromJson(Map<String, dynamic> json) {
    if (json['veg'] != null) {
      veg = new List<Veg>();
      json['veg'].forEach((v) {
        veg.add(new Veg.fromJson(v));
      });
    }
    if (json['nonveg'] != null) {
      nonveg = new List<Nonveg>();
      json['nonveg'].forEach((v) {
        nonveg.add(new Nonveg.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.veg != null) {
      data['veg'] = this.veg.map((v) => v.toJson()).toList();
    }
    if (this.nonveg != null) {
      data['nonveg'] = this.nonveg.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Veg {
  String image;
  String price;
  String name;

  Veg({this.image, this.price, this.name});

  Veg.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    price = json['price'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['price'] = this.price;
    data['name'] = this.name;
    return data;
  }
}

class Nonveg {
  String image;
  String price;
  String name;

  Nonveg({this.image, this.price, this.name});

  Nonveg.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    price = json['price'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['price'] = this.price;
    data['name'] = this.name;
    return data;
  }
}

class Lunch {
  List<Veg> veg;

  Lunch({this.veg});

  Lunch.fromJson(Map<String, dynamic> json) {
    if (json['Veg'] != null) {
      veg = new List<Veg>();
      json['Veg'].forEach((v) {
        veg.add(new Veg.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.veg != null) {
      data['Veg'] = this.veg.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
