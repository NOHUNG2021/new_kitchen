import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/model/BeanLogin.dart';
import 'package:kitchen/model/BeanOrderAccepted.dart';
import 'package:kitchen/model/BeanOrderRejected.dart';
import 'package:kitchen/model/GetOrderTrialRequest.dart';

import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:intl/intl.dart';
import 'package:kitchen/utils/progress_dialog.dart';

class TrialRequestScreen extends StatefulWidget {
  @override
  _TrialRequestScreenState createState() => _TrialRequestScreenState();
}

class _TrialRequestScreenState extends State<TrialRequestScreen> {
  GetOrderTrialRequest trailRequets;
  BeanLogin userBean;
  ProgressDialog progressDialog;

  List<GetOrderTrialRequestData> data = [];
  var currentDate = "";
  var userId = "";
  Future getUser() async {
    userBean = await Utils.getUser();
    userId = userBean.data.id.toString();
    setState(() {});
  }

  @override
  void initState() {
    getUser().then((value) {
      getCurrentDate();
      getTrialRequest(context).then((value) {
        setState(() {
          trailRequets = value;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: data.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            getOrderList(data[index]),
                            (index + 1 == data.length)
                                ? AppConstant().navBarHt()
                                : SizedBox()
                          ],
                        );
                      },
                      itemCount: data.length,
                    ),
            ),
          ],
        ));
  }

  Widget getOrderList(GetOrderTrialRequestData result) {
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
                  result.totalBill,
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
                  result.totalBill,
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

  Future<GetOrderTrialRequest> getTrialRequest(BuildContext context) async {
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId.toString(),
        "token": "123456789",
        "filter_fromdate": '',
        "filter_todate": "",
        "filter_order_number": ""
      });

      GetOrderTrialRequest bean = await ApiProvider().geTrialRequest(from);
      print(bean.data);

      if (bean.status == true) {
        data = bean.data;
        setState(() {});

        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      print(exception);
    } catch (exception) {}
  }

  Future<BeanOrderAccepted> orderAccepted(String orderId) async {
    // progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId,
        "token": "123456789",
        "order_id": orderId,
      });
      BeanOrderAccepted bean = await ApiProvider().ordeAccept(from);
      print(bean.data);
      // progressDialog.dismiss();
      if (bean.status == true) {
        getTrialRequest(context).then((value) {
          setState(() {
            trailRequets = value;
          });
        });
        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      // progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      // progressDialog.dismiss();
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
        getTrialRequest(context).then((value) {
          setState(() {
            trailRequets = value;
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

  void getCurrentDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    currentDate = formatter.format(now);
    print(currentDate);
  }
}
