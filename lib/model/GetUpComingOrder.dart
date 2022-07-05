class GetUpComingOrder {
  bool status;
  String message;
  List<GetUpComingOrderData> data;

  GetUpComingOrder({this.status, this.message, this.data});

  GetUpComingOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<GetUpComingOrderData>();
      json['data'].forEach((v) {
        data.add(new GetUpComingOrderData.fromJson(v));
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

class GetUpComingOrderData {
  String customerName;
  String customerMobilenumber;
  String orderNumber;
  String orderDate;
  String orderItems;
  String deliveryAddress;

  GetUpComingOrderData(
      {this.customerName,
      this.customerMobilenumber,
      this.orderNumber,
      this.orderDate,
      this.orderItems,
      this.deliveryAddress});

  GetUpComingOrderData.fromJson(Map<String, dynamic> json) {
    customerName = json['customer_name'];
    customerMobilenumber = json['customer_mobilenumber'];
    orderNumber = json['order_number'];
    orderDate = json['order_date'];
    orderItems = json['order_items'];
    deliveryAddress = json['delivery_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_name'] = this.customerName;
    data['customer_mobilenumber'] = this.customerMobilenumber;
    data['order_number'] = this.orderNumber;
    data['order_date'] = this.orderDate;
    data['order_items'] = this.orderItems;
    data['delivery_address'] = this.deliveryAddress;
    return data;
  }
}
