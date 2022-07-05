// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/model/BeanAddPackageMeal.dart';
import 'package:kitchen/model/BeanLogin.dart';
import 'package:kitchen/model/getMealScreenItems.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';

class MenuITemSelectedScreen extends StatefulWidget {
  MealScreenItems bean;
  final String package_id;
  final String day;

  List tempList;
  MenuITemSelectedScreen({
    this.bean = null,
    this.tempList,
    this.package_id,
    this.day,
  });
  @override
  _MenuITemSelectedScreenState createState() => _MenuITemSelectedScreenState();
}

class _MenuITemSelectedScreenState extends State<MenuITemSelectedScreen> {
  BeanLogin userBean;
  var userId = "";
  ProgressDialog progressDialog;
  List defaultList = [];
  List<Menuitem> selectedtList = [];
  bool isPageLoading = true;

  Future getUser() async {
    userBean = await Utils.getUser();
    userId = userBean.data.id.toString();
    
  }

  @override
  void initState() {
    selectedtList = widget.tempList;
    getUser();
    setState(() {
      isPageLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: isPageLoading? Container(): Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              height: 60,
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      Res.ic_right_arrow,
                      width: 16,
                      height: 16,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "Selected Item",
                    style: TextStyle(
                        fontFamily: AppConstant.fontBold, fontSize: 20),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                "Selected any of the below to make it as a default dis\n for the day.",
                style: TextStyle(
                    fontFamily: AppConstant.fontRegular,
                    fontSize: 13,
                    color: Colors.grey),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return getItem(widget.bean.data[index].category, index);
              },
              itemCount: widget.bean.data.length,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  defaultList = [];
                  for (int i = 0; i < widget.bean.data.length; i++) {
                    //print(widget.bean.data.length.toString() + 'ioio');
                    for (int j = 0;
                        j < widget.bean.data[i].menuitems.length;
                        j++) {
                      // print(widget.bean.data[i].menuitems.length.toString() +
                      // '-----');
                      if (widget.bean.data[i].menuitems[j].isdefault) {
                        defaultList.add(widget.bean.data[i].menuitems[j].menuId
                            // Menuitem(
                            // menuId: widget.bean.data[i].menuitems[j].menuId,
                            // itemname: widget.bean.data[i].menuitems[j].itemname,
                            // quantity: widget.bean.data[i].menuitems[j].quantity,
                            // itemprice:
                            //     widget.bean.data[i].menuitems[j].itemprice)
                            );
                      }
                    }
                  }
                  print(jsonEncode(defaultList));
                  addPackageMeal(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  height: 55,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Center(
                      child: Text(
                        "+ ADD MEAL",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: AppConstant.fontBold,
                            fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }

  getItem(var choic, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, top: 16),
          child: Text(choic.toString(),
              style: TextStyle(
                  color: Colors.black, fontFamily: AppConstant.fontBold)),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          height: 80,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.bean.data[index].menuitems.length,
            itemBuilder: (BuildContext context, int ind) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: getListFood(
                    subitem: widget.bean.data, index: index, secondIndex: ind),
              );
            },
          ),
        )
      ],
    );
  }

  Widget getListFood(
      {List<MealScreenItemsData> subitem, int index, int secondIndex}) {
    var selected = subitem[index].menuitems[secondIndex].menuId;
    return (subitem[index].menuitems[secondIndex].isChecked)
        ? GestureDetector(
            onTap: () {
              setState(() {
                for (int i = 0; i < subitem[index].menuitems.length; i++) {
                  if (selected == subitem[index].menuitems[i].menuId) {
                    subitem[index].menuitems[i].isdefault = !subitem[index].menuitems[i].isdefault;
                    
                  } else {
                    subitem[index].menuitems[i].isdefault = false;
                  }
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: subitem[index].menuitems[secondIndex].isdefault
                          ? Color(0xff7EDABF)
                          : Color(0xffF3F6FA),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 10),
                      child: Text(
                        subitem[index]
                            .menuitems[secondIndex]
                            .itemname, // subitem.itemname,
                        style: TextStyle(
                            color:
                                // subitem.isdefault ? Colors.white :
                                Colors.black,
                            fontSize: 12,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  )),
            ),
          )
        : Container();
  }

  Future<BeanAddPackageMeals> addPackageMeal(BuildContext context) async {
    // print(widget.package_id +
    //     '\n' +
    //     widget.day +
    //     '\n' +
    //     widget.weekly_package_id);
    // progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId,
        "token": '123456789',
        "package_id": widget.package_id,
        "day": int.parse(widget.day),
        // "weekly_package_id": widget.weekly_package_id,
        "item_detail": json.encode(selectedtList),
        "defaultdishitem": json.encode(defaultList),
      });
      print("JAAAAA ${from.fields}");
      BeanAddPackageMeals bean = await ApiProvider().addPackageMeal(from);
      print(bean.data);

      if (bean.status == true) {
        Navigator.pop(context);
        Navigator.pop(context);
        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      // progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      // progressDialog.dismiss();
      print(exception);
    }
  }
}
