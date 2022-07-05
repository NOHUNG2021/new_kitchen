import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/model/BeanLogin.dart';
import 'package:kitchen/model/GetActiveOrder.dart';
import 'package:kitchen/model/ReadyToPickupOrder.dart';

import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:intl/intl.dart';
import 'package:kitchen/utils/progress_dialog.dart';

class ActiveScreen extends StatefulWidget {
  final bool fromDashboard;

  const ActiveScreen({Key key, this.fromDashboard = false}) : super(key: key);
  @override
  _ActiveScreenState createState() => _ActiveScreenState();
}

class _ActiveScreenState extends State<ActiveScreen> {
  ProgressDialog progressDialog;
  BeanLogin userBean;
  bool loading = true;
  var dropdownValue;
  List<GetActiveOrderData> data = [];
  var currentDate = "";
  var userId;
  var _value = '1';
  var status = "";

  void getUser() async {
    userBean = await Utils.getUser();
    userId = userBean.data.id.toString();

    setState(() {});
  }

  @override
  void initState() {
    getUser();
    getCurrentDate();
    super.initState();
    Future.delayed(Duration.zero, () {
      getActiveOrder(context).then((value) {
        setState(() {
          loading = false;
        });
      });
    });
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
            ? Center(
                child: CircularProgressIndicator(),
              )
            : (data.isEmpty)
                ? Center(
                    child: Text('No Active Orders'),
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
                  ));
  }

  Widget getOrderList(GetActiveOrderData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    Res.ic_people,
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 55,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.customerName,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: AppConstant.fontBold),
                              ),
                              Text(
                                data.orderDate,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: AppConstant.fontRegular),
                              ),
                              Text(
                                "Customized ",
                                style: TextStyle(
                                    color: AppConstant.appColor,
                                    fontSize: 14,
                                    fontFamily: AppConstant.fontBold),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          Res.ic_call,
                          width: 40,
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Today's Lunch Menu ",
                style: TextStyle(
                    color: Color(0xffA7A8BC),
                    fontSize: 14,
                    fontFamily: AppConstant.fontRegular),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Image.asset(
                    Res.ic_breakfast,
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        data.orderItems,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(color: Colors.grey),
              ),
              Row(
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
                      data.deliveryAddress,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: AppConstant.fontRegular),
                    ),
                  ),
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 15.0),
              //   child: Container(
              //     decoration: BoxDecoration(
              //         color: Colors.black,
              //         borderRadius: BorderRadius.circular(10)),
              //     child: DropdownButton(
              //       icon: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child:
              //             Icon(Icons.keyboard_arrow_down, color: Colors.white),
              //       ),
              //       dropdownColor: Colors.black,
              //       underline: Container(),
              //       onChanged: (value) {
              //         setState(() {
              //           _value = value;
              //         });
              //       },
              //       value: _value,
              //       items: [
              //         DropdownMenuItem(
              //           value: "1",
              //           child: Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Text(
              //               "Order In Preparation",
              //               style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 13,
              //                   fontFamily: AppConstant.fontBold),
              //             ),
              //           ),
              //         ),
              //         DropdownMenuItem(
              //           value: "2",
              //           child: Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Text(
              //               "Ready For Pickup",
              //               style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 13,
              //                   fontFamily: AppConstant.fontBold),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  (data.status == 'Order in Preparation')
                      ? bottomsheetStatus(context, data.orderItemsId)
                      : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Order is ready to pick'),
                        ));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Container(
                    width: (data.status == 'Order in Preparation') ? 200 : 150,
                    height: 42,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          data.status,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily: AppConstant.fontBold),
                        ),
                        (data.status == 'Order in Preparation')
                            ? Icon(Icons.keyboard_arrow_down,
                                color: Colors.white)
                            : Container(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Divider(color: Colors.grey.withOpacity(0.5), thickness: 5)
      ],
    );
  }

  Future<GetActiveOrder> getActiveOrder(BuildContext context) async {
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId.toString(),
        "token": "123456789",
        "filter_fromdate": '2021-10-8',
        "filter_todate": "",
        "filter_order_number": ""
      });

      GetActiveOrder bean = await ApiProvider().getActiveOrder(from);
      print(bean.data);

      if (bean.status == true) {
        setState(() {
          data = bean.data;
        });

        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      print(exception);
    } catch (exception) {}
  }

  Future<ReadyToPickupOrder> readyToPickUpOrder(
      BuildContext context, String orderItemsId) async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId.toString(),
        "token": '123456789',
        "orderitems_id": orderItemsId,
      });

      ReadyToPickupOrder bean = await ApiProvider().readyToPickupOrder(from);

      progressDialog.dismiss();
      if (bean.status == true) {
        getActiveOrder(context);
        Navigator.pop(context);

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

  void getCurrentDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    currentDate = formatter.format(now);
    print(currentDate);
  }

  Future bottomsheetStatus(BuildContext context, String orderItemsId) {
    showModalBottomSheet(
        useRootNavigator: true,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: AppConstant.fontBold,
                              fontSize: 18),
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: 5,
                          width: 80,
                          decoration: BoxDecoration(
                              color: AppConstant.appColor,
                              borderRadius: BorderRadius.circular(5)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      readyToPickUpOrder(context, orderItemsId);
                      // setState(() {
                      //   //Navigator.pop(context);
                      //  // status = "Pending";
                      // });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 200,
                        height: 42,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text(
                            "Ready To Pick Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppConstant.fontRegular),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     setState(() {
                  //       Navigator.pop(context);
                  //       status = "Failed";
                  //     });
                  //   },
                  //   child: Padding(
                  //     padding: EdgeInsets.all(10),
                  //     child: Text(
                  //       "Failed",
                  //       style: TextStyle(
                  //           fontSize: 15,
                  //           color: Colors.black,
                  //           fontFamily: AppConstant.fontRegular),
                  //     ),
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     setState(() {
                  //       Navigator.pop(context);
                  //       status = "Confirm";
                  //     });
                  //   },
                  //   child: Padding(
                  //     padding: EdgeInsets.all(10),
                  //     child: Text(
                  //       "Confirm",
                  //       style: TextStyle(
                  //           fontSize: 15,
                  //           color: Colors.black,
                  //           fontFamily: AppConstant.fontRegular),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            );
          });
        }).then((value) {
      setState(() {
        getActiveOrder(context);
      });
    });
  }
}
