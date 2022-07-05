class GetPayment {
  bool status;
  String message;
  Data data;

  GetPayment({this.status, this.message, this.data});

  GetPayment.fromJson(Map<String, dynamic> json) {
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
  String totalEarning;
  String currentBalance;
  List<Transaction> transaction;

  Data({this.totalEarning, this.currentBalance, this.transaction});

  Data.fromJson(Map<String, dynamic> json) {
    totalEarning = json['total_earning'];
    currentBalance = json['current_balance'];
    if (json['transaction'] != null) {
      transaction = new List<Transaction>();
      json['transaction'].forEach((v) {
        transaction.add(new Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_earning'] = this.totalEarning;
    if (this.transaction != null) {
      data['transaction'] = this.transaction.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transaction {
  String customerName;
  String customerMobilenumber;
  String orderNumber;
  String transactionDate;
  String amount;

  Transaction(
      {this.customerName,
      this.customerMobilenumber,
      this.orderNumber,
      this.transactionDate,
      this.amount});

  Transaction.fromJson(Map<String, dynamic> json) {
    customerName = json['customer_name'];
    customerMobilenumber = json['customer_mobilenumber'];
    orderNumber = json['order_number'];
    transactionDate = json['transaction_date'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_name'] = this.customerName;
    data['customer_mobilenumber'] = this.customerMobilenumber;
    data['order_number'] = this.orderNumber;
    data['transaction_date'] = this.transactionDate;
    data['amount'] = this.amount;
    return data;
  }
}
