import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/model/BeanLogin.dart';
import 'package:kitchen/model/GetorderHistory.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';

class OrdersHistory extends StatefulWidget {
  final bool fromDashboard;

  const OrdersHistory({Key key, this.fromDashboard = false}) : super(key: key);
  @override
  _OrdersHistoryState createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {
  Future future;
  bool loading = true;
  var userId = "";
  BeanLogin userBean;
  List<OrderHistory> orders = [];

  var booked = "";
  var paid = "";
  var cancelled = "";
  var total_sales = "";
  var projected_sales_tomorrow = "";

  void getUser() async {
    userBean = await Utils.getUser();
    userId = userBean.data.id.toString();

    setState(() {});
  }

  @override
  void initState() {
    getUser();
    super.initState();
    Future.delayed(Duration.zero, () {
      future = getorderHistory(context).then((value) {
        setState(() {
          loading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        appBar: (widget.fromDashboard)
            ? AppBar(
                backgroundColor: AppConstant.appColor,
              )
            : null,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 240,
                //color: Colors.yellow,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 200,
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Color(0xffF3F6FA),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 16),
                                      child: Text(
                                        booked,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontFamily: AppConstant.fontBold),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 16, top: 8),
                                      child: Text(
                                        "Booked",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily:
                                                AppConstant.fontRegular),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 16),
                                      child: Text(
                                        paid,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontFamily: AppConstant.fontBold),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 16, top: 8),
                                      child: Text(
                                        "Paid",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily:
                                                AppConstant.fontRegular),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Text(
                                        cancelled,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontFamily: AppConstant.fontBold),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 16, top: 8),
                                      child: Text(
                                        "Cancelled",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily:
                                                AppConstant.fontRegular),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    "Today's Sales",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: AppConstant.fontRegular),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    AppConstant.rupee + total_sales,
                                    style: TextStyle(
                                        color: AppConstant.lightGreen,
                                        fontSize: 18,
                                        fontFamily: AppConstant.fontBold),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    "Project Sales for Tomorow",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: AppConstant.fontRegular),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    AppConstant.rupee +
                                        projected_sales_tomorrow,
                                    style: TextStyle(
                                        color: AppConstant.appColor,
                                        fontSize: 18,
                                        fontFamily: AppConstant.fontBold),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          Res.ic_order_history,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              (loading)
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : orders.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text('No orders')),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                getOrderList(orders[index]),
                                (index + 1 == orders.length)
                                    ? AppConstant().navBarHt()
                                    : SizedBox()
                              ],
                            );
                          },
                          itemCount: orders.length,
                        ),
            ],
          ),
        ));
  }

  Widget getOrderList(OrderHistory order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                Res.ic_people,
                width: 50,
                height: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.customerName,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: AppConstant.fontBold),
                  ),
                  Text(
                    order.orderDate,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: AppConstant.fontRegular),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                "Weekly Plan",
                style: TextStyle(
                    color: Color(0xffA7A8BC),
                    fontSize: 14,
                    fontFamily: AppConstant.fontBold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                "Monthly Plan",
                style: TextStyle(
                    color: Color(0xffA7A8BC),
                    fontSize: 14,
                    fontFamily: AppConstant.fontBold),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                Res.ic_breakfast,
                width: 16,
                height: 16,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                order.weeklyPlan,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: AppConstant.fontBold),
              ),
            ),
            SizedBox(width: 5),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                Res.ic_dinner,
                width: 16,
                height: 16,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                order.monthlyPlan,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: AppConstant.fontBold),
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
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                Res.ic_loc,
                width: 20,
                height: 20,
                color: AppConstant.lightGreen,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  order.deliveryAddress,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: AppConstant.fontRegular),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 25),
        Divider(color: Colors.grey.withOpacity(0.5), thickness: 5)
      ],
    );
  }

  Future<GetorderHistory> getorderHistory(BuildContext context) async {
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId.toString(),
        "token": "123456789",
        "filter_fromdate": "",
        "filter_todate": "",
        "filter_order_number": ""
      });
      GetorderHistory bean = await ApiProvider().getOrderHistory(from);
      print(bean.data);
      if (bean.status == true) {
        booked = bean.data.booked.toString();
        paid = bean.data.paid.toString();
        cancelled = bean.data.cancelled.toString();
        total_sales = bean.data.totalSales;
        projected_sales_tomorrow = bean.data.projectedSalesTomorrow;

        orders = bean.data.orderHistory;

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
}
