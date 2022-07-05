class GetActiveOrder {
  bool status;
  String message;
  List<GetActiveOrderData> data;

  GetActiveOrder({this.status, this.message, this.data});

  GetActiveOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<GetActiveOrderData>();
      json['data'].forEach((v) {
        data.add(new GetActiveOrderData.fromJson(v));
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

class GetActiveOrderData {
  String orderItemsId;
  String customerName;
  String customerMobilenumber;
  String orderNumber;
  String orderDate;
  String orderItems;
  String deliveryAddress;
  String status;

  GetActiveOrderData(
      {this.customerName,
      this.customerMobilenumber,
      this.orderNumber,
      this.orderDate,
      this.orderItems,
      this.deliveryAddress,
      this.status,
      this.orderItemsId});

  GetActiveOrderData.fromJson(Map<String, dynamic> json) {
    customerName = json['customer_name'];
    customerMobilenumber = json['customer_mobilenumber'];
    orderNumber = json['order_number'];
    orderDate = json['order_date'];
    orderItems = json['order_items'];
    deliveryAddress = json['delivery_address'];
    status = json['status'];
    orderItemsId = json['orderitems_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_name'] = this.customerName;
    data['customer_mobilenumber'] = this.customerMobilenumber;
    data['order_number'] = this.orderNumber;
    data['order_date'] = this.orderDate;
    data['order_items'] = this.orderItems;
    data['delivery_address'] = this.deliveryAddress;
    data['status'] = this.status;
    data['orderitems_id'] = this.orderItemsId;
    return data;
  }
}
