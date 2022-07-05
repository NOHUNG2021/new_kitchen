import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/model/GetArchieveOffer.dart';
import 'package:kitchen/model/GetLiveOffer.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/screen/AddOfferScreen.dart';
import 'package:kitchen/screen/EditOfferScreen.dart';
import 'package:kitchen/screen/HomeBaseScreen.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class OfferManagementScreen extends StatefulWidget {
  @override
  _OfferManagementScreenState createState() => _OfferManagementScreenState();
}

class _OfferManagementScreenState extends State<OfferManagementScreen> {
  var isSelected = 1;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future _future, futureLive;
  ProgressDialog progressDialog;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _future = getArchieveOffer(context);
      futureLive = getLiveOffers(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog((context));
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        drawer: MyDrawers(),
        key: _scaffoldKey,
        backgroundColor: AppConstant.appColor,
        body:new RefreshIndicator(
          onRefresh: _pullRefresh,
          child: Column(
            children: [
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
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 10),
                      child: Text(
                        "Offer Management",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ],
                ),
                height: 150,
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.white)),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              isSelected = 1;
                              print(isSelected);
                            });
                          },
                          child: Container(
                            height: 60,
                            width: 180,
                            decoration: BoxDecoration(
                                color: isSelected == 1
                                    ? Colors.white
                                    : Color(0xffFFA451),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(100),
                                    bottomLeft: Radius.circular(100))),
                            child: Center(
                              child: Text(
                                "Active Promos",
                                style: TextStyle(
                                    color: isSelected == 1
                                        ? Colors.black
                                        : Colors.white,
                                    fontFamily: AppConstant.fontBold),
                              ),
                            ),
                          )),
                    ),
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              isSelected = 2;
                              print(isSelected);
                            });
                          },
                          child: Container(
                            height: 60,
                            width: 180,
                            decoration: BoxDecoration(
                                color: isSelected == 2
                                    ? Colors.white
                                    : Color(0xffFFA451),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(100),
                                    bottomRight: Radius.circular(100))),
                            child: Center(
                              child: Text(
                                "Archives",
                                style: TextStyle(
                                    color: isSelected == 2
                                        ? Colors.black
                                        : Colors.white,
                                    fontFamily: AppConstant.fontBold),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    margin: EdgeInsets.only(top: 20),
                    child: MenuSelected()),
              ),
            ],
          ),
        ));
  }

  MenuSelected() {
    if (isSelected == 1) {
      return Column(
        children: [
          Expanded(
              child: Stack(
            children: [
              FutureBuilder<GetLiveOffer>(
                  future: futureLive,
                  builder: (context, projectSnap) {
                    print(projectSnap);
                    if (projectSnap.connectionState == ConnectionState.done) {
                      var result;
                      if (projectSnap.data != null) {
                        result = projectSnap.data.data;
                        if (result != null) {
                          print(result.length);
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return getLiveOffer(result[index]);
                            },
                            itemCount: result.length,
                          );
                        }
                      }
                    }
                    return Container(
                        child: Center(
                      child: Text(
                        "No Live Offer",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ));
                  }),
              Positioned.fill(
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                        padding: EdgeInsets.only(right: 16, bottom: 0),
                        child: InkWell(
                          onTap: () {
                            addliveOffer();
                          },
                          child: Image.asset(
                            Res.ic_add_round,
                            width: 65,
                            height: 65,
                          ),
                        ))),
              )
            ],
          )),
          AppConstant().navBarHt()
        ],
      );
    } else {
      return Column(
        children: [
          Expanded(
              child: Stack(
            children: [
              FutureBuilder<GetArchieveOffer>(
                  future: _future,
                  builder: (context, projectSnap) {
                    print(projectSnap);
                    if (projectSnap.connectionState == ConnectionState.done) {
                      var result;
                      if (projectSnap.data != null) {
                        result = projectSnap.data.data;
                        if (result != null) {
                          print(result.length);
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return getArcieveOffer(result[index]);
                            },
                            itemCount: result.length,
                          );
                        }
                      }
                    }
                    return Container(
                        child: Center(
                      child: Text(
                        "No Archeive Offer",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ));
                  }),

              // Positioned.fill(
              //     child: Align(
              //         alignment: Alignment.bottomRight,
              //         child: Padding(
              //             padding: EdgeInsets.only(right: 16,bottom: 16),
              //             child: InkWell(
              //                 onTap: (){
              //                     addArchiveOffer();
              //
              //                 },
              //                 child: Image.asset(Res.ic_add_round,width: 65,height: 65,),
              //             )
              //         )
              //     ),
              // )
            ],
          )),
          AppConstant().navBarHt()
        ],
      );
    }
  }

  getArcieveOffer(result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, bottom: 10, top: 10),
          width: 65,
          decoration: BoxDecoration(
              color: AppConstant.lightGreen,
              borderRadius: BorderRadius.circular(5)),
          height: 25,
          child: Center(
            child: Text(
              "Archieved",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: AppConstant.fontBold,
                  fontSize: 11),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                      "${result.discounttype =='1'? ' FLAT ${AppConstant.rupee}${result.discountValue} ':'${result.discountValue} %'} OFF  \n"+
                      "${result.uptoAmount !="0"? 'UPTO  ${AppConstant.rupee}${result.uptoAmount}' : ''}",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 14),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 10),
              width: 65,
              decoration: BoxDecoration(
                  color: Color(0xffBEE8FF),
                  borderRadius: BorderRadius.circular(5)),
              height: 25,
              child: Center(
                child: Text(
                  result.offercode,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 11),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 5),
          child: Text(
            result.title,
            style: TextStyle(
                color: Colors.grey,
                fontFamily: AppConstant.fontBold,
                fontSize: 12),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 5, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                result.startdate.toString() + " " + result.enddate.toString(),
                style: TextStyle(
                    color: Colors.grey,
                    fontFamily: AppConstant.fontBold,
                    fontSize: 12),
              ),
              GestureDetector(
                onTap: () {
                  addArchiveOffer(result.offerId);
                },
                child: Text('Use again',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontFamily: AppConstant.fontBold,
                        fontSize: 14)),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Divider(
          thickness: 2,
          color: Colors.grey.shade200,
        ),
      ],
    );
  }
  Future<void> _pullRefresh ()   async {
    setState(() async {
      await Future.delayed(Duration.zero, () {
      _future = getArchieveOffer(context);
      futureLive = getLiveOffers(context);
    });
    });
  }
  Future<GetArchieveOffer> getArchieveOffer(BuildContext context) async {
    progressDialog.show();
    var user = await Utils.getUser();
    var id = user.data.id;
    print(id + 'lllllll');
    try {
      FormData from = FormData.fromMap({"user_id": id, "token": "123456789"});
      GetArchieveOffer bean = await ApiProvider().getArchieveOffer(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
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

  Future<GetLiveOffer> getLiveOffers(BuildContext context) async {
    progressDialog.show();
    var user = await Utils.getUser();
    var id = user.data.id;
    try {
      FormData from = FormData.fromMap({"user_id": id, "token": "123456789"});
      GetLiveOffer bean = await ApiProvider().getLiveOffers(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
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

  getLiveOffer(result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              width: 65,
              decoration: BoxDecoration(
                  color: AppConstant.lightGreen,
                  borderRadius: BorderRadius.circular(5)),
              height: 25,
              child: Center(
                child: Text(
                  "LIVE",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 11),
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      editOffer(result.offerId);
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => EditOfferScreen(offerId :result.offerId)));
                    },
                    icon: Icon(Icons.edit)),
                IconButton(
                  onPressed: () async {
                    var user = await Utils.getUser();
                    var id = user.data.id;
                    ApiProvider()
                        .deleteOffer(FormData.fromMap({
                      'token': '123456789',
                      'user_id': id,
                      'offer_id': result.offerId
                    }))
                        .then((value) {
                      setState(() {
                        futureLive = getLiveOffers(context);
                      });
                    });
                  },
                  icon: Icon(Icons.delete),
                )
              ],
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                      "${result.discounttype =='1'?' FLAT ${AppConstant.rupee}${result.discountValue} ':'${result.discountValue}%'} OFF \n"+
                      "${result.uptoAmount !="0"? 'UPTO  ${AppConstant.rupee}${result.uptoAmount}' : ''}",
                  // "Get " +
                  //     "${result.discounttype =='1'?' ${AppConstant.rupee}${result.discountValue} ':'${result.discountValue}%'} OFF on your first discount",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 14),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 10),
              width: 65,
              decoration: BoxDecoration(
                  color: Color(0xffBEE8FF),
                  borderRadius: BorderRadius.circular(5)),
              height: 25,
              child: Center(
                child: Text(
                  result.offercode,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 11),
                ),
              ),
            ),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: Text(
                result.title,
                style: TextStyle(
                    color: Colors.grey,
                    fontFamily: AppConstant.fontBold,
                    fontSize: 12),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: Text(
                result.startdate + " " + result.enddate,
                style: TextStyle(
                    color: Colors.grey,
                    fontFamily: AppConstant.fontBold,
                    fontSize: 12),
              ),
            ),
          ]),
          Container(
            margin: EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 10),
            width: 65,
            decoration: BoxDecoration(
                color: Color(0xffBEE8FF),
                borderRadius: BorderRadius.circular(5)),
            height: 25,
            child: Center(
              child: Text(
                "${result.countUsage} USED",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: AppConstant.fontBold,
                    fontSize: 11),
              ),
            ),
          ),
        ]),
        SizedBox(
          height: 20,
        ),
        Divider(
          thickness: 2,
          color: Colors.grey.shade200,
        ),
      ],
    );
  }

  addArchiveOffer(String offerId) async {
    var data = await pushNewScreen(context,
        screen: EditOfferScreen(offerId: offerId),withNavBar: false);
    if (data != null) {
      _future = getArchieveOffer(context);
      print('io');
    }
    print('io');
  }

  addliveOffer() async {
    var data = await pushNewScreen(context,
        screen: AddOfferScreen(
          offerId: '',
        ),
        withNavBar: false);
    if (data != null) {
      futureLive = getLiveOffers(context);
    }
    print('io');
  }

  editOffer(offerId) async {
    var data = await pushNewScreen(context,
        screen: EditOfferScreen(
          offerId: offerId,
        ),
        withNavBar: false);
    if (data != null) {
      futureLive = getLiveOffers(context);
    }
    print('io');
  }
}
