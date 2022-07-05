// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/Order/ActiveScreen.dart';
import 'package:kitchen/Order/OrdersHistory.dart';
import 'package:kitchen/Order/RequestScreen.dart';
import 'package:kitchen/Order/UpcomingScreen.dart';
import 'package:kitchen/model/BeanGetDashboard.dart' as res;
import 'package:kitchen/model/BeanLogin.dart';
import 'package:kitchen/model/GetAccountDetail.dart';
import 'package:kitchen/model/getKitcheStatus.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/screen/HomeBaseScreen.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';

import 'TrackDeliveryScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BeanLogin userBean;
  bool isKitchenActive = true;
  var name = "";
  var menu = "";
  var userId = "";
  var active_orders = "";
  var upcoming_orders = "";
  var pending_orders = "";
  var completed_orders = "";
  var active_deliveries = "";
  var descriptionKitchen = '';
  var ready = "";
  var preparing = "";
  var out_for_delivery = "";
  var loss = "";
  var profit = "";
  KitchenStatus bean;
  var nameOfKitchen = "";
  var profileimage = "";
  List<res.Data> data = [];
  // List<FlSpot> spots = [
  //   FlSpot(0, 3),
  //   FlSpot(2.6, 2),
  //   FlSpot(4.9, 5),
  //   FlSpot(6.8, 3.1),
  //   FlSpot(8, 4),
  //   FlSpot(9.5, 3),
  //   FlSpot(11, 4),
  // ];
  List<FlSpot> spots = [
    FlSpot(0, 0),
    FlSpot(1, 3),
    FlSpot(2, 5),
    FlSpot(3, 3.1),
    FlSpot(4, 4),
  ];

  ProgressDialog progressDialog;

  void getUser() async {
    userBean = await Utils.getUser();
    name = userBean.data.kitchenname;
    menu = userBean.data.menufile;
    userId = userBean.data.id.toString();
  }
  Future<void> updateKitchenStatus(value)
  async {
    FormData form = FormData.fromMap({
        "token": "123456789",
        "status": value ? "1": "0",
        "kitchen_id":userBean.data.id.toString(),
      });
      bean = await ApiProvider().updateKitchenAvailability(form);
      if(bean.status == true)
      {
        Utils.showToast(bean.message);
        setState(() {
          isKitchenActive = value;
        });
      } else {
        Utils.showToast(bean.message);
      }
  }

  @override
  void initState() {
    super.initState();
    getUser();
    getAccountDetails(context);
    Future.delayed(Duration.zero, () {
      getDashboard();
    });
  }
  Future<void> _pullRefresh ()   async {
    setState(() async {
      await Future.delayed(Duration.zero, () {      
      getDashboard();
    });
    });
  }
  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        drawer: MyDrawers(),
        backgroundColor: AppConstant.appColor,
        key: _scaffoldKey,
        body:  Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 120),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(38),
                        topLeft: Radius.circular(38))),
                height: double.infinity,
                child: SingleChildScrollView(
                  child:  new RefreshIndicator(
          onRefresh: _pullRefresh,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                radius: 45,
                                backgroundImage: NetworkImage(
                                  profileimage,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  nameOfKitchen,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: AppConstant.fontBold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  descriptionKitchen,
                                  style: TextStyle(
                                      color: Color(0xffA7A8BC),
                                      fontSize: 14,
                                      fontFamily: AppConstant.fontRegular),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ActiveScreen(
                                                fromDashboard: true,
                                              )),
                                    );
                                  },
                                  child: Card(
                                    margin: EdgeInsets.only(left: 16, top: 16),
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100)),
                                    child: Container(
                                      height: 110,
                                      width: 70,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            active_orders.toString(),
                                            style: TextStyle(
                                                color: Color(0xffBEE8FF),
                                                fontSize: 30,
                                                fontFamily: AppConstant.fontBold),
                                          ),
                                          Text(
                                            "Active\nOrders",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily:
                                                    AppConstant.fontRegular),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpcomingScreen(
                                                fromDashboard: true,
                                              )),
                                    );
                                  },
                                  child: Card(
                                    margin: EdgeInsets.only(left: 16, top: 16),
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100)),
                                    child: Container(
                                      height: 110,
                                      width: 70,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            upcoming_orders.toString(),
                                            style: TextStyle(
                                                color: Color(0xffFEDF7C),
                                                fontSize: 30,
                                                fontFamily: AppConstant.fontBold),
                                          ),
                                          Text(
                                            "Upcoming\n   Orders",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily:
                                                    AppConstant.fontRegular),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RequestScreen(
                                                fromDashboard: true,
                                              )),
                                    );
                                  },
                                  child: Card(
                                    margin: EdgeInsets.only(left: 16, top: 16),
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100)),
                                    child: Container(
                                      height: 110,
                                      width: 70,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            pending_orders.toString(),
                                            style: TextStyle(
                                                color: Color(0xffFCA896),
                                                fontSize: 30,
                                                fontFamily: AppConstant.fontBold),
                                          ),
                                          Text(
                                            "Pending\nOrders",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily:
                                                    AppConstant.fontRegular),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OrdersHistory(
                                                fromDashboard: true,
                                              )),
                                    );
                                  },
                                  child: Card(
                                    margin: EdgeInsets.only(left: 16, top: 16),
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Container(
                                      height: 110,
                                      width: 70,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            completed_orders.toString(),
                                            style: TextStyle(
                                                color: Color(0xffBEE8FF),
                                                fontSize: 30,
                                                fontFamily: AppConstant.fontBold),
                                          ),
                                          Text(
                                            "Completed\n   Orders",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily:
                                                    AppConstant.fontRegular),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TrackDeliveryScreen()));
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 16, top: 16),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 16,
                                ),
                                Image.asset(
                                  Res.ic_pan,
                                  width: 120,
                                  height: 120,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Text(
                                    "Active\nDeliveries",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: AppConstant.fontBold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    active_deliveries.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontFamily: AppConstant.fontBold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Image.asset(
                                    Res.ic_back,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10, top: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Color(0xffBEE8FF),
                                        borderRadius: BorderRadius.circular(16)),
                                    child: Center(
                                      child: Text(
                                        "Preparing " + preparing.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: AppConstant.fontRegular),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Color(0xff7EDABF),
                                        borderRadius: BorderRadius.circular(16)),
                                    child: Center(
                                      child: Text(
                                        "Ready " + ready.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: AppConstant.fontRegular),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Color(0xffFEDF7C),
                                        borderRadius: BorderRadius.circular(16)),
                                    child: Center(
                                        child: Text(
                                      "Out for Delivery " +
                                          out_for_delivery.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontFamily: AppConstant.fontRegular),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(left: 16, top: 26),
                        //   child: Text(
                        //     "Earning Reports",
                        //     style: TextStyle(
                        //         color: Colors.grey,
                        //         fontSize: 18,
                        //         fontFamily: AppConstant.fontBold),
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(left: 16, right: 16, top: 26),
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //         child: Container(
                        //           margin: EdgeInsets.only(left: 1, top: 16),
                        //           height: 120,
                        //           width: 120,
                        //           decoration: BoxDecoration(
                        //               color: Color(0xffF3F6FA),
                        //               borderRadius: BorderRadius.circular(16)),
                        //           child: Center(
                        //             child: CircularPercentIndicator(
                        //               radius: 100.0,
                        //               lineWidth: 10.0,
                        //               percent: 0.5,
                        //               center: Text(
                        //                 profit + "%" + "\nProfit",
                        //                 style: TextStyle(
                        //                     fontFamily: AppConstant.fontRegular),
                        //               ),
                        //               backgroundColor: Colors.white,
                        //               progressColor: Color(0xff7EDABF),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Expanded(
                        //         child: Container(
                        //           margin: EdgeInsets.only(left: 11, top: 16),
                        //           height: 120,
                        //           width: 120,
                        //           decoration: BoxDecoration(
                        //               color: Color(0xffF3F6FA),
                        //               borderRadius: BorderRadius.circular(16)),
                        //           child: Center(
                        //             child: CircularPercentIndicator(
                        //               radius: 100.0,
                        //               lineWidth: 10.0,
                        //               percent: 0.2,
                        //               center: Text(
                        //                 loss + "%" + "\nLoss",
                        //                 style: TextStyle(
                        //                     fontFamily: AppConstant.fontRegular),
                        //               ),
                        //               backgroundColor: Colors.white,
                        //               progressColor: Color(0xffFCA896),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(left: 16, top: 26),
                        //   child: Text(
                        //     "Sales Overview",
                        //     style: TextStyle(
                        //         color: Colors.grey,
                        //         fontSize: 18,
                        //         fontFamily: AppConstant.fontBold),
                        //   ),
                        // ),
                        // // Container(
                        // //   margin: EdgeInsets.only(
                        // //       left: 16, right: 16, top: 16, bottom: 16),
                        // //   height: 270,
                        // //   width: double.infinity,
                        // //   decoration: BoxDecoration(
                        // //       color: Color(0xffF3F6FA),
                        // //       borderRadius: BorderRadius.circular(16)),
                        // //   child: Center(
                        // //       child: Padding(
                        // //     padding: EdgeInsets.only(top: 16, bottom: 16),
                        // //     child: Image.asset(Res.ic_graph),
                        // //   )),
                        // // ),
                        // SizedBox(height: 10),
                        // Padding(
                        //   padding: const EdgeInsets.all(12.0),
                        //   child: Container(
                        //       height: 310,
                        //       width: MediaQuery.of(context).size.width,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(16),
                        //         color: Color(0xffF3F6FA),
                        //       ),
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.stretch,
                        //           children: [
                        //             Padding(
                        //               padding: const EdgeInsets.all(8.0),
                        //               child: Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Row(
                        //                       children: [
                        //                         Text('Total Earn'),
                        //                         Text(
                        //                           '  ₹15,425',
                        //                           style: TextStyle(
                        //                               fontSize: 20,
                        //                               fontWeight: FontWeight.bold),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                     Text('December v')
                        //                   ]),
                        //             ),
                        //             Expanded(child: LineChart(mainData())),
                        //           ],
                        //         ),
                        //       )),
                        // ),
                      ],
                    ),
                  ),
                  physics: BouncingScrollPhysics(),
                ),
              ),
              Container(
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
                      child: Image.asset(
                        Res.ic_menu,
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Text(
                        "Dashboard",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                    Transform.scale(scale: 1.5 ,child:  Switch(value: isKitchenActive, onChanged: (value) {
                      updateKitchenStatus(value);
                    },
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Colors.red.shade300,
                    activeColor: Colors.green ,
                    activeTrackColor:  Colors.green.shade300 ,
                    ), ),
                    SizedBox(height: 10,width: 20,),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RequestScreen(
                                      fromDashboard: true,
                                    )));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Image.asset(
                          Res.ic_notification,
                          width: 25,
                          height: 25,
                        ),
                      ),
                    )
                  ],
                ),
                height: 150,
              ),
            ],
          ),
        /*    appBar: AppBar(
          elevation: 0,
            backgroundColor: Colors.orange,
            leading:Row(
              children: [
                IconButton(
                  icon: ImageIcon(
                    AssetImage(
                      'assets/images/ic_menu.png',
                    ),
                    color: Colors.white,
                  ), onPressed: () {
                  setState(() {
                    _scaffoldKey.currentState.openDrawer();
                  });
                },
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text("Dashboard",style: TextStyle(color: Colors.white,fontSize: 30,fontFamily: AppConstant.fontBold),),
                  ),
                ),
                Image.asset(Res.ic_back)

              ],
            )
        )*/

        );
  }
Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff75729e),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1m';
        break;
      case 2:
        text = '2m';
        break;
      case 3:
        text = '3m';
        break;
      case 4:
        text = '5m';
        break;
      case 5:
        text = '6m';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }
  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: true, handleBuiltInTouches: true),
      showingTooltipIndicators: <ShowingTooltipIndicators>[
        ShowingTooltipIndicators( [
          LineBarSpot(
            LineChartBarData(show: false, showingIndicators: [1, 1]),
            1,
            FlSpot(1, 1),
          )
        ])
      ],
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Color(0xffA7A8BC),
            strokeWidth: 1,
            dashArray: [5],
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.red,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false)as AxisTitles,
        topTitles: SideTitles(showTitles: false)as AxisTitles,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          // getTextStyles: (context, value) => const TextStyle(
          //     color: Color(0xff68737d),
          //     fontWeight: FontWeight.bold,
          //     fontSize: 16),
          getTitlesWidget: leftTitleWidgets,
        ) as AxisTitles,
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          // getTextStyles: (context, value) => const TextStyle(
          //   color: Color(0xff67727d),
          //   fontWeight: FontWeight.bold,
          //   fontSize: 15,
          // ),
          getTitlesWidget: leftTitleWidgets,
          reservedSize: 32,
        ) as AxisTitles,
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 5,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          shadow: Shadow(color: Color(0x58968B47), blurRadius: 2),
          color: Color(0xff7EDABF),
          spots: spots,
          isCurved: true,
          //colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
            // colors:
            // gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  Future<res.BeanGetDashboard> getDashboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    progressDialog.show();
    try {
      FormData from =
          FormData.fromMap({"kitchen_id": userId, "token": "123456789"});
      res.BeanGetDashboard bean = await ApiProvider().beanGetDashboard(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        if (bean.data != null) {
          active_orders = bean.data.activeOrders.toString();
          upcoming_orders = bean.data.upcomingOrders.toString();
          pending_orders = bean.data.pendingOrders.toString();
          completed_orders = bean.data.completedOrders.toString();
          active_deliveries = bean.data.activeDeliveries.toString();
          ready = bean.data.ready.toString();
          preparing = bean.data.preparing.toString();
          out_for_delivery = bean.data.outForDelivery.toString();
          loss = bean.data.loss.toString();
          profit = bean.data.profit.toString();
          nameOfKitchen = bean.data.kitchenName.toString();
          descriptionKitchen = bean.data.description.toString();
          profileimage = bean.data.profile_image.toString();
          prefs.setString('profile', profileimage);
        }

        setState(() {});

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

  Future<GetAccountDetails> getAccountDetails(BuildContext context) async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({"user_id": userId, "token": "123456789"});
      GetAccountDetails bean = await ApiProvider().getAccountDetails(from);
      progressDialog.dismiss();
      if (bean.status) {
        if (bean.data != null) {
          setState(() {
           var kitcheStatus = bean.data.availableStatus;
           if(kitcheStatus == '1')
      {
       isKitchenActive = true; 
      }else{
        isKitchenActive = false;
      }
          });
        }

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
