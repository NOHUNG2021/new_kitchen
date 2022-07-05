class BeanGetOrderRequest {
  bool status;
  String message;
  List<BeanGetOrderRequestData> data;

  BeanGetOrderRequest({this.status, this.message, this.data});

  BeanGetOrderRequest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<BeanGetOrderRequestData>();
      json['data'].forEach((v) {
        data.add(new BeanGetOrderRequestData.fromJson(v));
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

class BeanGetOrderRequestData {
  String orderId;
  String customerName;
  String customerMobilenumber;
  String orderNumber;
  String orderDate;
  String weeklyPlan;
  String monthlyPlan;
  String deliveryAddress;
  String totalBill;

  BeanGetOrderRequestData(
      {this.orderId,
      this.customerName,
      this.customerMobilenumber,
      this.orderNumber,
      this.orderDate,
      this.weeklyPlan,
      this.monthlyPlan,
      this.deliveryAddress,
      this.totalBill});

  BeanGetOrderRequestData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    customerName = json['customer_name'];
    customerMobilenumber = json['customer_mobilenumber'];
    orderNumber = json['order_number'];
    orderDate = json['order_date'];
    weeklyPlan = json['weekly_plan'];
    monthlyPlan = json['monthly_plan'];
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
    data['weekly_plan'] = this.weeklyPlan;
    data['monthly_plan'] = this.monthlyPlan;
    data['delivery_address'] = this.deliveryAddress;
    data['total_bill'] = this.totalBill;
    return data;
  }
}
