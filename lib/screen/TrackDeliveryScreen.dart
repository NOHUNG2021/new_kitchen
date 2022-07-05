import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/model/GetTrackDeliveries.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/screen/HomeBaseScreen.dart';
import 'package:kitchen/screen/StartDeliveryScreen.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TrackDeliveryScreen extends StatefulWidget {
  @override
  _TrackDeliveryScreenState createState() => _TrackDeliveryScreenState();
}

class _TrackDeliveryScreenState extends State<TrackDeliveryScreen> {
  GetTrackDeliveries bean;
  List<GetTrackDeliveriesData> data = [];
  var userId;
  bool loading = true;

  @override
  void initState() {
    getTrialRequest(context).then((value) {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: AppConstant.appColor,
        drawer: MyDrawers(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Icon(
                          Icons.arrow_back,
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
                        "Track Deliveries",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                ],
              ),
              height: 70,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: (loading)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : data.isEmpty
                        ? Center(
                            child: Text('No Active deliveries'),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  getItem(data[index]),
                                  (index + 1 == data.length)
                                      ? AppConstant().navBarHt()
                                      : SizedBox()
                                ],
                              );
                            },
                            itemCount: data.length,
                          ),
              ),
            ),
            Container(
              height: 65,
              color: Colors.white,
            )
          ],
        ));
  }

  Widget getItem(GetTrackDeliveriesData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, top: 16),
          child: Text(
            "1234 | " + data.time,
            style: TextStyle(
                color: Colors.black,
                fontFamily: AppConstant.fontBold,
                fontSize: 16),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 16),
          child: Text(
            "ORDER BY " + data.orderBy,
            style: TextStyle(
                color: AppConstant.lightGreen,
                fontFamily: AppConstant.fontBold,
                fontSize: 14),
          ),
        ),
        Row(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Image.asset(
                  Res.ic_loc,
                  width: 16,
                  height: 16,
                  color: AppConstant.lightGreen,
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  data.deliveryAddress,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontRegular,
                      fontSize: 14),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Divider(
            color: Colors.grey,
          ),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                "Total Bill:",
                style: TextStyle(
                    color: Colors.grey,
                    fontFamily: AppConstant.fontRegular,
                    fontSize: 14),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8, top: 16),
                child: Text(
                  AppConstant.rupee + ' ' + data.totalBill,
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: AppConstant.fontRegular,
                      fontSize: 14),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                pushNewScreen(context,
                    screen: StartDeliveryScreen(data.deliveryAddress,
                        data.order_id, data.orderitems_id),
                    withNavBar: false);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => StartDeliveryScreen(
                //             data.deliveryAddress,
                //             data.order_id,
                //             data.orderitems_id)));
              },
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                height: 50,
                width: 80,
                decoration: BoxDecoration(
                    color: AppConstant.appColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Center(
                    child: Text(
                      "TRACK",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: Colors.grey.withOpacity(0.5),
          thickness: 5,
        ),
      ],
    );
  }

  Future<GetTrackDeliveries> getTrialRequest(BuildContext context) async {
    try {
      var user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "kitchen_id": user.data.id,
        "token": "123456789",
      });

      bean = await ApiProvider().geTrackDeliveries(from);

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
}
