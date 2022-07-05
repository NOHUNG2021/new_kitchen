
class BeanAddPackageMeals {

  bool status;
  String message;
  List<Data> data;
  BeanAddPackageMeals({this.status,this.message, this.data,  });


  BeanAddPackageMeals.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
      // data = List<Data>.from(
      //       json["data"].map((x) => Data.fromJson(x)));
      }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    // data['data'] = this.data;
    return data;
  }
}
class Data{
  Data({
    this.packageId,
  });
  String packageId;
  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(
        packageId: json['package_id'],
      );
      Map<String, dynamic> toJson() => {
        "package_id":packageId
      };
}
