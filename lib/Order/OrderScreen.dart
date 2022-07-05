import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/Order/ActiveScreen.dart';
import 'package:kitchen/Order/OrdersHistory.dart';
import 'package:kitchen/Order/RequestScreen.dart';
import 'package:kitchen/Order/TrialRequestScreen.dart';
import 'package:kitchen/Order/UpcomingScreen.dart';
import 'package:kitchen/model/BeanApplyOrderFilter.dart';
import 'package:kitchen/model/BeanLogin.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/Order/FilterScreen.dart';
import 'package:kitchen/screen/HomeBaseScreen.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/Utils.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({
    Key key,
  }) : super(key: key);
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var isSelected = 0;
  var userId;
  BeanLogin userBean;
  TabController _tabController;

  @override
  void initState() {
    getUser().then((value) {
      applyFilter(context);
    });
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  Future getUser() async {
    userBean = await Utils.getUser();
    userId = userBean.data.id.toString();
    setState(() {});
  }

  // To reset all the applied filter.
  Future<BeanApplyOrderFilter> applyFilter(BuildContext context) async {
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId,
        "token": '123456789',
        "fromdate": '',
        "todate": '',
        "order_number": '',
      });

      BeanApplyOrderFilter bean = await ApiProvider().applyOrderFilter(from);
      print(bean.data);

      if (bean.status == true) {
        return bean;
      } else {
        // Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      print(exception);
    } catch (exception) {}
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        drawer: MyDrawers(),
        backgroundColor: AppConstant.appColor,
        key: _scaffoldKey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              margin: EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          _scaffoldKey.currentState.openDrawer();
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Image.asset(
                          Res.ic_menu,
                          width: 30,
                          height: 30,
                          color: Colors.white,
                        ),
                      )),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Text(
                        "Orders",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FilterScreen()),
                      ).then((value) {
                        setState(() {});
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 16, top: 16),
                      child: Image.asset(
                        Res.ic_filter,
                        width: 25,
                        height: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                    color: AppConstant.appColor,
                  ),
                  isScrollable: true,
                  labelStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Container(
                      decoration: BoxDecoration(
                          color: (_tabController.index == 0)
                              ? Colors.transparent
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Tab(
                          text: 'Request',
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: (_tabController.index == 1)
                              ? Colors.transparent
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Tab(
                          text: 'Active',
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: (_tabController.index == 2)
                              ? Colors.transparent
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Tab(
                          text: 'Upcoming',
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: (_tabController.index == 3)
                              ? Colors.transparent
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Tab(
                          text: 'Order History',
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: (_tabController.index == 4)
                              ? Colors.transparent
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Tab(
                          text: 'Trial Requests',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  RequestScreen(),
                  ActiveScreen(),
                  UpcomingScreen(),
                  OrdersHistory(),
                  TrialRequestScreen(),
                  // second tab bar view widget
                ],
              ),
            ),
          ],
        ));
  }
}

// Expanded(
//   child: Container(
//       margin: EdgeInsets.only(top: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             margin: EdgeInsets.only(
//                 left: 10, top: 20, right: 10, bottom: 10),
//             width: double.infinity,
//             height: 55,
//             child: ListView.builder(
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               physics: BouncingScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return getItem(choices[index], index);
//               },
//               itemCount: choices.length,
//             ),
//           ),
//           getPage()
//         ],
//       )),
// ),
