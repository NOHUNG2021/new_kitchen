
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/Menu/BasePackagescreen.dart';
import 'package:kitchen/Menu/KitchenDetailScreen.dart';
import 'package:kitchen/Menu/MenuBaseScreen.dart';
import 'package:kitchen/model/GetAccountDetail.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/screen/AccountScreen.dart';
import 'package:kitchen/screen/HomeBaseScreen.dart';
import 'package:kitchen/screen/MenuCategory.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';

class MenuDetailScreen extends StatefulWidget {
  @override
  _MenuDetailScreenState createState() => _MenuDetailScreenState();
}

class _MenuDetailScreenState extends State<MenuDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var flag = 1;
  Future future;
  var name = "";
  var email = "";
  var kitchenId='';
  var address = "";
  var time = "";
  var document = "";
  var menu = "";
  var days = "";
  var profileImage;
  var typeOfFood;
  var description;
  var rating = 0.0;
  bool isPageLoading = true;
  List<dynamic> meals = [];
  ProgressDialog progressDialog;
  GetAccountDetails ACCvalue;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      future = getAccountDetails(context).then((value) {
        setState(() {
          ACCvalue = value;
          isPageLoading = false;
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
        drawer: MyDrawers(),
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: isPageLoading ? 
        //Center(child: CircularProgressIndicator()) 
        Container(): SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 230,
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: Image.asset(
                        Res.ic_kitchen_cover,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 40.5,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                              profileImage,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _scaffoldKey.currentState.openDrawer();
                                  });
                                },
                                child: Image.asset(
                                  Res.ic_menu,
                                  width: 25,
                                  height: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: AppConstant.fontBold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16,bottom: 5),
                child: Text(
                  "Kitchen ID : $kitchenId" ,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: AppConstant.fontBold),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        typeOfFood
                            .toString()
                            .replaceAll('[', '')
                            .replaceAll(']', ''),
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  ),
                  RatingBarIndicator(
                    rating: rating,
                    itemCount: 5,
                    itemSize: 20.0,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                  SizedBox(width: 5)
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  address,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontFamily: AppConstant.fontRegular),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      "Timings -",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontFamily: AppConstant.fontRegular),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      time,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: AppConstant.fontRegular),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                    '(' +
                        days
                            .toString()
                            .replaceAll("[", "")
                            .replaceAll("]", "") +
                        ')',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: AppConstant.fontRegular)),
              ),
              Container(
                height: 130,
                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                decoration: BoxDecoration(
                    color: Color(0xffF3F6FA),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    description,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: AppConstant.fontRegular,
                        fontSize: 12),
                  ),
                )),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BasePackagescreen(
                                    fromSettings: true,
                                  )),
                        );
                      },
                      child: Container(
                          height: 110,
                          width: 150,
                          margin: EdgeInsets.only(left: 7, right: 7, top: 20),
                          decoration: BoxDecoration(
                              color: Color(0xffF3F6FA),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Image.asset(
                                  Res.ic_packages_default,
                                  width: 60,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 16),
                                child: Text(
                                  "PACKAGES",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontBold,
                                      fontSize: 12),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute(builder: (_) => MenuCategoryScreen()),
                        );
                      },
                      child: Container(
                          height: 110,
                          width: 150,
                          margin: EdgeInsets.only(left: 7, right: 7, top: 20),
                          decoration: BoxDecoration(
                              color: Color(0xffF3F6FA),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Image.asset(
                                  Res.ic_menu_detail,
                                  width: 60,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 16),
                                child: Text(
                                  "MENU",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontBold,
                                      fontSize: 12),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                  
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute(builder: (_) => KitchenDetailScreen(accDetails: ACCvalue,)),
                        );
                      },
                      child: Container(
                          height: 110,
                          width: 150,
                          margin: EdgeInsets.only(left: 7, right: 7, top: 20),
                          decoration: BoxDecoration(
                              color: Color(0xffF3F6FA),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Image.asset(
                                  Res.ic_other_info,
                                  width: 60,
                                  height: 40,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 16),
                                child: Text(
                                  "KITCHEN INFO",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontBold,
                                      fontSize: 12),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute(builder: (_) => AccountScreen()),
                        );
                      },
                      child: Container(
                          height: 110,
                          width: 150,
                          margin: EdgeInsets.only(left: 7, right: 7, top: 20),
                          decoration: BoxDecoration(
                              color: Color(0xffF3F6FA),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Image.asset(
                                  Res.ic_settings,
                                  width: 60,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 16),
                                child: Text(
                                  "SETTINGS",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontBold,
                                      fontSize: 12),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                  height: 150,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                  decoration: BoxDecoration(
                      color: Color(0xffF3F6FA),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 10, top: 10),
                        child: Text(
                          "Type of Meals",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: AppConstant.fontBold,
                              fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return getListFood(meals[index]);
                          },
                          itemCount: meals.length,
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              AppConstant().navBarHt()
            ],
          ),
          physics: BouncingScrollPhysics(),
        ));
  }

  Widget getListFood(String meal) {
    var meall = meal;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          decoration: BoxDecoration(
              color: AppConstant.appColor,
              borderRadius: BorderRadius.circular(100)),
          height: 40,
          width: 40,
          child: Center(
            child: Image.asset(
              mealIcon(meall),
              width: 30,
              height: 30,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 10, top: 10),
          child: Text(
            meall,
            style: TextStyle(
                color: Colors.black,
                fontFamily: AppConstant.fontRegular,
                fontSize: 14),
          ),
        ),
      ],
    );
  }

  String mealIcon(String meal) {
    switch (meal) {
      case 'Breakfast':
        return Res.ic_breakfast;
      case 'Lunch&Dinner':
        return Res.ic_dinner;
      case 'Dinner':
        return Res.ic_dinner;
      case 'Veg':
        return Res.ic_veg;
      case 'Non-Veg':
        return Res.ic_chiken;
      default:
        return Res.ic_cross;
    }
  }

  Future<GetAccountDetails> getAccountDetails(BuildContext context) async {
    var user = await Utils.getUser();
    progressDialog.show();
    try {
      FormData from = FormData.fromMap(
          {"user_id": user.data.id.toString(), "token": "123456789"});
      GetAccountDetails bean = await ApiProvider().getAccountDetails(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          name = bean.data.kitchenName;
          address = bean.data.address;
          email = bean.data.email;
          kitchenId = bean.data.kitchenId;
          menu = bean.data.menufile;
          document = bean.data.documentfile;
          profileImage = bean.data.profileImage;
          typeOfFood = bean.data.typeOfFood;
          days = bean.data.openDays.toString();
          time = bean.data.fromTime + "  to  " +bean.data.toTime  ;
          // var currentTime = DateFormat("hh:mm:ss").format(DateTime.now());
          // var currentTime = DateFormat("hh:mm:ss").format(DateTime.now());
          // if(bean.data.fromTime  > currentTime && bean.data.toTime < currentTime )
          // {

          // }
          meals = bean.data.typeOfMeals;
          description = bean.data.description;
          if (bean.data.totalrating != null) {
            rating = double.parse(bean.data.totalrating);
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

  editScreen(GetAccountDetails value) async {
    var data = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => KitchenDetailScreen(
                  accDetails: value,
                )));
    if (data != null) {
      future = getAccountDetails(context);
    }
  }
}
