import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/model/BeanApplyOrderFilter.dart';
import 'package:kitchen/model/BeanLogin.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var startDate = "";
  var endDate = "";
  var status = "";
  var userId;
  var orderId = TextEditingController();
  BeanLogin userBean;
  ProgressDialog progressDialog;

  void getUser() async {
    userBean = await Utils.getUser();
    userId = userBean.data.id.toString();
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Image.asset(
                          Res.ic_right_arrow,
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 16, top: 16),
                      child: Text(
                        "Filter",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ],
                ),
                height: 70,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Text(
                        "Date From",
                        style: TextStyle(
                            color: AppConstant.appColor,
                            fontSize: 18,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, right: 80),
                      child: Text(
                        "Date to",
                        style: TextStyle(
                            color: AppConstant.appColor,
                            fontSize: 18,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: GestureDetector(
                          onTap: () async {
                            var result = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year - 2),
                                lastDate: DateTime(DateTime.now().year + 2));
                            print('$result');
                            setState(() {
                              startDate = result.day.toString() +
                                  "-" +
                                  result.month.toString() +
                                  "-" +
                                  result.year.toString();
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(startDate == "" ? "11-01-2021" : startDate),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.grey,
                              )
                            ],
                          )),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        var result = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(DateTime.now().year - 2),
                            lastDate: DateTime(DateTime.now().year + 2));
                        print('$result');
                        setState(() {
                          endDate = result.day.toString() +
                              "-" +
                              result.month.toString() +
                              "-" +
                              result.year.toString();
                        });
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 10, top: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(endDate == "" ? "12-01-2021" : endDate),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.grey,
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Text(
                        "Order Number",
                        style: TextStyle(
                            color: AppConstant.appColor,
                            fontSize: 18,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: Padding(
                  //     padding: EdgeInsets.only(top: 16, right: 80),
                  //     child: Text(
                  //       "Status",
                  //       style: TextStyle(
                  //           color: AppConstant.appColor,
                  //           fontSize: 18,
                  //           fontFamily: AppConstant.fontBold),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: TextField(
                        controller: orderId,
                        decoration: InputDecoration(hintText: "12345678"),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: Container(
                  //       margin: EdgeInsets.only(left: 10, top: 28, right: 16),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           InkWell(
                  //               onTap: () {
                  //                 bottomsheetStatus(context);
                  //               },
                  //               child: Text(
                  //                 status == "" ? "Pending" : status,
                  //                 style: TextStyle(
                  //                     fontFamily: AppConstant.fontRegular,
                  //                     fontSize: 14),
                  //               )),
                  //           SizedBox(
                  //             height: 10,
                  //           ),
                  //           Divider(
                  //             color: Colors.grey,
                  //           )
                  //         ],
                  //       )),
                  // ),
                  // Container(
                  //     margin: EdgeInsets.only(top: 16, right: 16),
                  //     child: Image.asset(
                  //       Res.ic_down_arrow,
                  //       width: 15,
                  //       height: 15,
                  //     )),
                ],
              ),
              SizedBox(
                height: 80,
              ),
              GestureDetector(
                onTap: () {
                  //print(startDate.toString());
                  applyFilter(context, startDate, endDate);
                },
                child: Container(
                  height: 55,
                  margin:
                      EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
                  decoration: BoxDecoration(
                      color: AppConstant.appColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "APPLY",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: AppConstant.fontBold,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Future<BeanApplyOrderFilter> applyFilter(
      BuildContext context, String fromDate, String toDate) async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId,
        "token": '123456789',
        "fromdate": fromDate,
        "todate": toDate,
        "order_number": orderId.text.toString(),
      });

      BeanApplyOrderFilter bean = await ApiProvider().applyOrderFilter(from);
      print(bean.data);

      if (bean.status == true) {
        progressDialog.dismiss();
        return bean;
      } else {
        progressDialog.dismiss();
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      print(exception);
    } catch (exception) {}
  }

  void bottomsheetStatus(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          // <-- for border radius
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setModelState) {
            return Container(
              height: 210,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Status",
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.pop(context);
                        status = "Pending";
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Pending",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.pop(context);
                        status = "Failed";
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Failed",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.pop(context);
                        status = "Confirm";
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  )
                ],
              ),
            );
          });
        });
  }
}
