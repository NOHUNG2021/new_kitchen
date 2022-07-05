import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/model/BeanLogin.dart';
import 'package:kitchen/model/GetUpComingOrder.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:intl/intl.dart';

class UpcomingScreen extends StatefulWidget {
  final bool fromDashboard;

  const UpcomingScreen({Key key, this.fromDashboard = false}) : super(key: key);
  @override
  _UpcomingScreenState createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  BeanLogin userBean;
  Future future;
  bool loading = true;

  List<GetUpComingOrderData> data = [];
  var currentDate = "";
  var userId = "";
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
      future = getUpComingOrder(context).then((value) {
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
        body: (loading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : (data.isEmpty)
                ? Center(
                    child: Text('No Upcoming Orders'),
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

  Widget getOrderList(GetUpComingOrderData data) {
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
            ],
          ),
        ),
        Divider(color: Colors.grey.withOpacity(0.5), thickness: 5)
      ],
    );
  }

  Future<GetUpComingOrder> getUpComingOrder(BuildContext context) async {
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId.toString(),
        "token": "123456789",
        "filter_fromdate": '',
        "filter_todate": "",
        "filter_order_number": ""
      });

      GetUpComingOrder bean = await ApiProvider().getUpComingOrder(from);
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

  void getCurrentDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    currentDate = formatter.format(now);
    print(currentDate);
  }
}
