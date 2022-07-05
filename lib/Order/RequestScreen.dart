import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/model/BeanGetOrderRequest.dart';
import 'package:kitchen/model/BeanLogin.dart';
import 'package:kitchen/model/BeanOrderAccepted.dart';
import 'package:kitchen/model/BeanOrderRejected.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';

import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';
import 'package:intl/intl.dart';

class RequestScreen extends StatefulWidget {
  final bool fromDashboard;

  const RequestScreen({Key key, this.fromDashboard = false}) : super(key: key);
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  ProgressDialog progressDialog;
  bool loading = true;
  BeanLogin userBean;
  var userId;
  var currentDate = "";
  BeanGetOrderRequest requestview;

  Future getUser() async {
    userBean = await Utils.getUser();
    userId = userBean.data.id.toString();
  }

  @override
  void initState() {
    getUser().then((value) {
      getCurrentDate();
      getOrderRequest(context).then((value) {
        setState(() {
          requestview = value;
          loading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
      appBar: (widget.fromDashboard)
          ? AppBar(
              backgroundColor: AppConstant.appColor,
            )
          : null,
      backgroundColor: Colors.white,
      body: (loading)
          ? Center(child: CircularProgressIndicator())
          : (!requestview.status)
              ? Center(child: Text('No Pending Orders', style: TextStyle()))
              : ListView.builder(
                  itemCount: requestview.data.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        getOrderList(requestview.data[index]),
                        (index + 1 == requestview.data.length)
                            ? AppConstant().navBarHt()
                            : SizedBox()
                      ],
                    );
                  },
                ),
    );
  }

  Widget getOrderList(BeanGetOrderRequestData result) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, top: 10),
                child: Image.asset(
                  Res.ic_people,
                  width: 52,
                  height: 52,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            result.customerName,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: AppConstant.fontBold),
                          ),
                          Text(
                            AppConstant.rupee + result.totalBill,
                            style: TextStyle(
                                color: AppConstant.lightGreen,
                                fontSize: 14,
                                fontFamily: AppConstant.fontBold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text('From  ', style: TextStyle(color: Colors.grey)),
                          Text(
                            result.orderDate,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: AppConstant.fontRegular),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, top: 10),
                child: Text(
                  "Weekly plan",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontFamily: AppConstant.fontRegular),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 10),
                child: Text(
                  "Monthly Plan",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: AppConstant.fontRegular),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Image.asset(
                  Res.ic_breakfast,
                  width: 20,
                  height: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  result.weeklyPlan,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontFamily: AppConstant.fontRegular),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Image.asset(
                  Res.ic_dinner,
                  width: 20,
                  height: 25,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  result.monthlyPlan,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: AppConstant.fontRegular),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(color: Colors.grey),
          ),
          SizedBox(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                children: [
                  Image.asset(
                    Res.ic_loc,
                    width: 20,
                    height: 20,
                    color: AppConstant.lightGreen,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      result.deliveryAddress,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: AppConstant.fontRegular),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  orderRejected(result.orderId);
                },
                child: Container(
                  height: 40,
                  width: 110,
                  margin: EdgeInsets.only(left: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Color(0xffF3F6FA),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "REJECT",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: AppConstant.fontBold),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  orderAccepted(result.orderId);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10, bottom: 10),
                  height: 40,
                  width: 110,
                  decoration: BoxDecoration(
                      color: AppConstant.appColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "ACCEPT",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: AppConstant.fontBold),
                    ),
                  ),
                ),
              )
            ],
          ),
          Divider(color: Colors.grey.withOpacity(0.5), thickness: 5)
        ],
      ),
    );
  }

  Future<BeanGetOrderRequest> getOrderRequest(BuildContext context) async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId,
        "token": "123456789",
        // "filter_fromdate": currentDate,
        //------------------------------------------
        //"filter_fromdate": '2021-10-8',
        //"filter_todate": "",
        //"filter_order_number": ""
      });
      BeanGetOrderRequest bean = await ApiProvider().getOrderRequest(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {});

        return bean;
      } else {
        Utils.showToast(bean.message);
        return bean;
      }

      return null;
    } on HttpException catch (exception) {
      progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      progressDialog.dismiss();
      print(exception);
    }
  }

  void getCurrentDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    currentDate = formatter.format(now);
    print(currentDate);
  }

  Future<BeanOrderAccepted> orderAccepted(String orderId) async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId,
        "token": "123456789",
        "order_id": orderId,
      });
      BeanOrderAccepted bean = await ApiProvider().ordeAccept(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        getOrderRequest(context).then((value) {
          setState(() {
            requestview = value;
          });
        });

        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      progressDialog.dismiss();
      print(exception);
    }
  }

  Future<BeanOrderRejected> orderRejected(String orderId) async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId,
        "token": "123456789",
        "order_id": orderId,
      });
      BeanOrderRejected bean = await ApiProvider().ordeReject(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        getOrderRequest(context).then((value) {
          setState(() {
            requestview = value;
          });
        });
        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      progressDialog.dismiss();
      print(exception);
    }
  }
}
