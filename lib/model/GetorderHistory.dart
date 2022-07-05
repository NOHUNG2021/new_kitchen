class GetorderHistory {
  bool status;
  String message;
  Data data;

  GetorderHistory({this.status, this.message, this.data});

  GetorderHistory.fromJson(Map<String, dynamic> json) {
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
  int booked;
  int paid;
  int cancelled;
  String totalSales;
  String projectedSalesTomorrow;
  List<OrderHistory> orderHistory;

  Data(
      {this.booked,
        this.paid,
        this.cancelled,
        this.totalSales,
        this.projectedSalesTomorrow,
        this.orderHistory});

  Data.fromJson(Map<String, dynamic> json) {
    booked = json['booked'];
    paid = json['paid'];
    cancelled = json['cancelled'];
    totalSales = json['total_sales'];
    projectedSalesTomorrow = json['projected_sales_tomorrow'];
    if (json['order_history'] != null) {
      orderHistory = new List<OrderHistory>();
      json['order_history'].forEach((v) {
        orderHistory.add(new OrderHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booked'] = this.booked;
    data['paid'] = this.paid;
    data['cancelled'] = this.cancelled;
    data['total_sales'] = this.totalSales;
    data['projected_sales_tomorrow'] = this.projectedSalesTomorrow;
    if (this.orderHistory != null) {
      data['order_history'] = this.orderHistory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderHistory {
  String orderId;
  String orderType;
  String packageType;
  String customerName;
  String customerMobilenumber;
  String orderNumber;
  String orderDate;
  String weeklyPlan;
  String monthlyPlan;
  String trialOrder;
  String deliveryAddress;
  String totalBill;

  OrderHistory(
      {this.orderId,
        this.orderType,
        this.packageType,
        this.customerName,
        this.customerMobilenumber,
        this.orderNumber,
        this.orderDate,
        this.weeklyPlan,
        this.monthlyPlan,
        this.trialOrder,
        this.deliveryAddress,
        this.totalBill});

  OrderHistory.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderType = json['order_type'];
    packageType = json['package_type'];
    customerName = json['customer_name'];
    customerMobilenumber = json['customer_mobilenumber'];
    orderNumber = json['order_number'];
    orderDate = json['order_date'];
    weeklyPlan = json['weekly_plan'];
    monthlyPlan = json['monthly_plan'];
    trialOrder = json['trial_order'];
    deliveryAddress = json['delivery_address'];
    totalBill = json['total_bill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_type'] = this.orderType;
    data['package_type'] = this.packageType;
    data['customer_name'] = this.customerName;
    data['customer_mobilenumber'] = this.customerMobilenumber;
    data['order_number'] = this.orderNumber;
    data['order_date'] = this.orderDate;
    data['weekly_plan'] = this.weeklyPlan;
    data['monthly_plan'] = this.monthlyPlan;
    data['trial_order'] = this.trialOrder;
    data['delivery_address'] = this.deliveryAddress;
    data['total_bill'] = this.totalBill;
    return data;
  }
}