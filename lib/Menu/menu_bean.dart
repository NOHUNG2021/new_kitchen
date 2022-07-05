

class MenuBean {
  bool status;
  String message;
  Data data;

  MenuBean({this.status, this.message, this.data});

  MenuBean.fromJson(Map<String, dynamic> json) {
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
  String mealName;
  Map<String,List<MealType>> mealTypes={};

  Breakfast({this.mealTypes,this.mealName});

  Breakfast.fromJson(Map<String, dynamic> json) {
    if(json!=null)
    {
      int firstTime=0;
      json.forEach((key, value) {
       if(firstTime==0)
        mealName=key;
       firstTime+=1;
        List<MealType> meals=[];

        json[key].forEach((v) {
          meals.add(MealType.fromJson(v));

        });
        mealTypes[key]=meals;
      });
    }
    else
    {
      mealTypes={};
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (this.mealTypes.isNotEmpty) {
      data=mealTypes;
    }
    return data;
  }
}

class MealType {
  String image;
  String price;
  String name;

  MealType({this.image, this.price, this.name});

  MealType.fromJson(Map<String, dynamic> json) {
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
  String mealName;
  Map<String,List<MealType>> mealTypes={};

  Lunch({this.mealTypes,this.mealName});

  Lunch.fromJson(Map<String, dynamic> json) {
    if(json!=null)
    {
      int firstTime=0;
      json.forEach((key, value) {
        if(firstTime==0)
          mealName=key;
        firstTime+=1;
        List<MealType> meals=[];

        json[key].forEach((v) {
          meals.add(MealType.fromJson(v));

        });
        mealTypes[key]=meals;
      });
    }
    else
    {
      mealTypes={};
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (this.mealTypes.isNotEmpty) {
      data=mealTypes;
    }
    return data;
  }
}