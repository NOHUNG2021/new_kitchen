class BeanGetDashboard {
  bool status;
  String message;
  Data data;

  BeanGetDashboard({this.status, this.message, this.data});

  BeanGetDashboard.fromJson(Map<String, dynamic> json) {
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
  String kitchenName;
  String kitchenAddress;
  String profile_image;
  int activeOrders;
  int upcomingOrders;
  int pendingOrders;
  int completedOrders;
  int activeDeliveries;
  int preparing;
  int ready;
  int outForDelivery;
  int profit;
  int loss;
  String description;

  Data(
      {this.kitchenName,
      this.kitchenAddress,
      this.activeOrders,
      this.profile_image,
      this.upcomingOrders,
      this.pendingOrders,
      this.completedOrders,
      this.activeDeliveries,
      this.preparing,
      this.ready,
      this.outForDelivery,
      this.profit,
      this.loss,
      this.description});

  Data.fromJson(Map<String, dynamic> json) {
    kitchenName = json['kitchen_name'];
    kitchenAddress = json['kitchen_address'];
    activeOrders = json['active_orders'];
    profile_image = json['profile_image'];
    upcomingOrders = json['upcoming_orders'];
    pendingOrders = json['pending_orders'];
    completedOrders = json['completed_orders'];
    activeDeliveries = json['active_deliveries'];
    preparing = json['preparing'];
    ready = json['ready'];
    outForDelivery = json['out_for_delivery'];
    profit = json['profit'];
    loss = json['loss'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kitchen_name'] = this.kitchenName;
    data['kitchen_address'] = this.kitchenAddress;
    data['profile_image'] = this.profile_image;
    data['active_orders'] = this.activeOrders;
    data['upcoming_orders'] = this.upcomingOrders;
    data['pending_orders'] = this.pendingOrders;
    data['completed_orders'] = this.completedOrders;
    data['active_deliveries'] = this.activeDeliveries;
    data['preparing'] = this.preparing;
    data['ready'] = this.ready;
    data['out_for_delivery'] = this.outForDelivery;
    data['profit'] = this.profit;
    data['loss'] = this.loss;
    data['description'] = this.description;
    return data;
  }
}
