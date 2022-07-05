class GetOrderTrialRequest {
  bool status;
  String message;
  List<GetOrderTrialRequestData> data;

  GetOrderTrialRequest({this.status, this.message, this.data});

  GetOrderTrialRequest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<GetOrderTrialRequestData>();
      json['data'].forEach((v) {
        data.add(new GetOrderTrialRequestData.fromJson(v));
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

class GetOrderTrialRequestData {
  String orderId;
  String customerName;
  String customerMobilenumber;
  String orderNumber;
  String orderDate;
  String orderItems;
  String status;
  String deliveryAddress;
  String totalBill;

  GetOrderTrialRequestData(
      {this.orderId,
      this.customerName,
      this.customerMobilenumber,
      this.orderNumber,
      this.orderDate,
      this.orderItems,
      this.status,
      this.deliveryAddress,
      this.totalBill});

  GetOrderTrialRequestData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    customerName = json['customer_name'];
    customerMobilenumber = json['customer_mobilenumber'];
    orderNumber = json['order_number'];
    orderDate = json['order_date'];
    orderItems = json['order_items'];
    status = json['status'];
    deliveryAddress = json['delivery_address'];
    totalBill = json['total_bill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['customer_name'] = this.customerName;
    data['customer_mobilenumber'] = this.customerMobilenumber;
    data['order_number'] = this.orderNumber;
    data['order_date'] = this.orderDate;
    data['order_items'] = this.orderItems;
    data['status'] = this.status;
    data['delivery_address'] = this.deliveryAddress;
    data['total_bill'] = this.totalBill;
    return data;
  }
}
