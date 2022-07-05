import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/model/BeanLogin.dart';
import 'package:kitchen/model/GetFeedback.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:kitchen/utils/progress_dialog.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BeanLogin userBean;
  Future<GetFeedback> _future;
  double rating;
  double review;
  double excellent;
  double good;
  double poor;
  double average;
  var data;
  bool loading = true;
  var userId;
  ProgressDialog progressDialog;

  Future getUser() async {
    userBean = await Utils.getUser();
    userId = userBean.data.id.toString();
  }

  @override
  void initState() {
    getUser().then((value) {
      setState(() {
        _future = getFeedback(context);
        _future.then((value) {
          setState(() {
            data = value;
            loading = false;
          });
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
        backgroundColor: AppConstant.appColor,
        body: (loading)
            ? Container(
                color: Colors.white,
              )
            : (data == null)
                ? Column(
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
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Image.asset(
                                  Res.ic_right_arrow,
                                  width: 30,
                                  height: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 16),
                                child: Text(
                                  "Feedback/Reviews",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: AppConstant.fontBold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 16, top: 16),
                              child: Image.asset(
                                Res.ic_noti,
                                width: 25,
                                height: 25,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        height: 70,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Center(
                            child: Text('No Reviews'),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
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
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Image.asset(
                                  Res.ic_right_arrow,
                                  width: 30,
                                  height: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 16),
                                child: Text(
                                  "Feedback/Reviews",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: AppConstant.fontBold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 16, top: 16),
                              child: Image.asset(
                                Res.ic_noti,
                                width: 25,
                                height: 25,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        height: 70,
                      ),
                      // Container(
                      //   color: Colors.white,
                      //   child: Center(
                      //     child: Text('No Reviews'),
                      //   ),
                      // ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                  child: Padding(
                                child: Text(
                                  rating.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontBold,
                                      fontSize: 20),
                                ),
                                padding: EdgeInsets.only(top: 16),
                              )),
                              Center(
                                child: RatingBarIndicator(
                                  rating: 4,
                                  // rating: rating,
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16, top: 10),
                                  child: Text(
                                    "Based on " + review.toString() + " review",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: AppConstant.fontRegular),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 16),
                                      child: Text("Excellent"),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 16),
                                    child: LinearPercentIndicator(
                                      width: 200.0,
                                      lineHeight: 6.0,
                                      // percent: (excellent / review),
                                      percent: excellent / 6,
                                      backgroundColor: Colors.grey.shade300,
                                      progressColor: Color(0xff7EDABF),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 16),
                                      child: Text("Good"),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 16),
                                    child: LinearPercentIndicator(
                                      width: 200.0,
                                      lineHeight: 6.0,
                                      percent: good / 6,
                                      backgroundColor: Colors.grey.shade300,
                                      progressColor: Color(0xffFDD303),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 16),
                                      child: Text("Average"),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 16),
                                    child: LinearPercentIndicator(
                                      width: 200.0,
                                      lineHeight: 6.0,
                                      percent: average / 6,
                                      backgroundColor: Colors.grey.shade300,
                                      progressColor: Color(0xffBEE8FF),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 16),
                                      child: Text("Poor"),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 16),
                                    child: LinearPercentIndicator(
                                      width: 200.0,
                                      lineHeight: 6.0,
                                      //percent: (poor / review),
                                      percent: poor / 6,
                                      backgroundColor: Colors.grey.shade300,
                                      progressColor: Color(0xffFCA896),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: FutureBuilder<GetFeedback>(
                                    future: _future,
                                    builder: (context, projectSnap) {
                                      print(projectSnap);
                                      if (projectSnap.connectionState ==
                                          ConnectionState.done) {
                                        var result;
                                        if (projectSnap.data != null) {
                                          result =
                                              projectSnap.data.data.feedback;
                                          if (result != null) {
                                            print(result.length);
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              physics: BouncingScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return getItem(result[index]);
                                              },
                                              itemCount: result.length,
                                            );
                                          }
                                        }
                                      }
                                      return Container(
                                          child: Center(
                                        child: Text(
                                          "No Feedback Available",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: AppConstant.fontBold),
                                        ),
                                      ));
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ));
  }

  Widget getItem(result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 16, top: 10),
                child: getImage(result)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        result.customerName,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                    /* Padding(
                      padding: EdgeInsets.only(left: 0,top: 10),
                      child: Text("10 min ago ",style: TextStyle(color: Colors.grey,fontSize: 14,fontFamily: AppConstant.fontRegular),),
                    ),*/
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 6),
                  child: RatingBarIndicator(
                    rating: double.parse(result.rating),
                    itemCount: 5,
                    itemSize: 20.0,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 10),
                  child: Text(
                    result.message,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: AppConstant.fontRegular),
                  ),
                ),
                Row(
                  children: [
                     Padding(
                      padding: EdgeInsets.only(left: 10, top: 16),
                      child: Text(
                        "Food Quality",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                    Padding(
                  padding: EdgeInsets.only(left: 6, top: 10),
                  child:  Icon(
                      result.foodQuality == '1' ? Icons.thumb_up : Icons.thumb_down,
                      color: result.quantity == '1' ?  Colors.amber: Colors.blue[100],
                  ),
                ),
                SizedBox(
                  width: 5,
                ), Padding(
                      padding: EdgeInsets.only(left: 10, top: 16),
                      child: Text(
                        "Taste",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                    Padding(
                  padding: EdgeInsets.only(left: 6, top: 10),
                  child:  Icon(
                      result.taste == '1' ? Icons.thumb_up : Icons.thumb_down,
                      color:result.quantity == '1' ?  Colors.amber: Colors.blue[100],
                  ),
                ),
                SizedBox(
                  width: 5,
                ), Padding(
                      padding: EdgeInsets.only(left: 10, top: 16),
                      child: Text(
                        "Quantity",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                    Padding(
                  padding: EdgeInsets.only(left: 6, top: 10),
                  child:  Icon(
                      result.quantity == '1' ? Icons.thumb_up : Icons.thumb_down,
                      color: result.quantity == '1' ?  Colors.amber: Colors.blue[100],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                  ],
                ),
                Divider(
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Future<GetFeedback> getFeedback(BuildContext context) async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap(
        {"user_id": userId, "token": "123456789"},
      );

      var bean = await ApiProvider().getFeedback(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          if (bean.data != null) {
            rating = double.parse(bean.data.totalrating);
            review = double.parse(bean.data.totalreview);
            excellent = double.parse((int.parse(bean.data.excellent) - 1).toString());
            poor = double.parse(bean.data.poor);
            good = double.parse(bean.data.good);
            average = double.parse(bean.data.average);
            print(poor.toString() + "pooooooooooooooooooooor");
          }
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

  getImage(result) {
    if (result.customerPhoto.toString().isEmpty) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(Res.ic_people,
              fit: BoxFit.cover, width: 60, height: 60));
    } else {
      return ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            result.customerPhoto,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ));
    }
  }
}
