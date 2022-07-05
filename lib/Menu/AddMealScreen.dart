// ignore_for_file: non_constant_identifier_names, unnecessary_statements

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/Menu/MenuITemSelectedScreen.dart';
import 'package:kitchen/Menu/itemModel.dart';
import 'package:kitchen/model/BeanLogin.dart';
import 'package:kitchen/model/getMealScreenItems.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';

class AddMealScreen extends StatefulWidget {
  final String package_id;
  final String day;

  final String appBar_cat;
  final String appBar_Cuisine;

  const AddMealScreen({
    Key key,
    this.package_id,
    this.appBar_cat,
    this.appBar_Cuisine,
    this.day,
  }) : super(key: key);
  @override
  _AddMealScreenState createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  String pri;
  var isSelected = -1;
  BeanLogin userBean;
  MealScreenItems bean;
  var userId = "";
  ProgressDialog progressDialog;
  List<Menuitem> TempList = [];
  List<MealScreenItemsData> cattemplist = [];
  List<ListElement> mondayItems = [];
  List<ListElement> tuesdayItems = [];
  List<Monday> mon = [];
  List<Tuesday> tue = [];
  List<Wednesday> wed = [];
  List<Friday> fri = [];
  List<Thurday> thur = [];
  List<Saturday> sat = [];
  List<Sunday> sun = [];
  //Monday monday;
  ItemModel itemModel;
  ItemModel itemModel2;
  bool isPageLoading = true;

  Future getUser() async {
    userBean = await Utils.getUser();
    userId = userBean.data.id.toString();
  }

  @override
  void initState() {
    // itemModel = ItemModel(
    //     monday: mon,
    //     tuesday: tue,
    //     wednesday: wed,
    //     thurday: thur,
    //     friday: fri,
    //     saturday: sat,
    //     sunday: sun);
    // mon.add(Monday(list: mondayItems));
    //tue.add(Tuesday(list: tuesdayItems));
    // mondayItems
    //     .add(ListElement(menuId: '1', itemname:: '560'));

    getUser().then((value) {
      getMealScreenItems();
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
          child: isPageLoading ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ) :Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 16, top: 30),
                height: 60,
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Image.asset(
                      Res.ic_veg,
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             PackageList()));
                      },
                      child: Text(
                        widget.appBar_cat.toUpperCase(),
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: AppConstant.fontBold,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    VerticalDivider(color: Colors.grey, width: 20),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        widget.appBar_Cuisine,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: AppConstant.fontBold,
                            fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Image.asset(
                        Res.ic_cross,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: bean.data.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, ind) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(bean.data[ind].category,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: AppConstant.fontBold)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      getItem(bean.data[ind].menuitems, ind,
                          bean.data[ind].category == 'Bread'),
                      SizedBox(height: 15),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, '/menuItemSelected');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MenuITemSelectedScreen(
                                  bean: bean,
                                  tempList: TempList,
                                  day: widget.day,
                                  package_id: widget.package_id,
                                )));
                    // pri = itemModelToJson(itemModel);
                    print(jsonEncode(TempList));
                    //addPackageMeal(context);

                    // print(pri);
                    // aasd();
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
                          "SET DEFAULT",
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
          physics: BouncingScrollPhysics(),
        ));
  }

  Widget getItem(List<Menuitem> menuitems, int ind, bool isBread) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: menuitems.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                    checkColor: Colors.white, // color of tick Mark
                    activeColor: AppConstant.lightGreen, // c
                    onChanged: (val) {
                      setState(() {
                        menuitems[index].isChecked =
                            !menuitems[index].isChecked;
                        (menuitems[index].isChecked)
                            ? TempList.add(Menuitem(
                                menuId: menuitems[index].menuId,
                                itemname: menuitems[index].itemname,
                                itemprice: menuitems[index].itemprice,
                                quantity: menuitems[index].quantity,
                              ))
                            : null;
                        // cattemplist.add(MealScreenItemsData(category: ,menuitems: TempList));
                      });
                      // _onCheck(
                      //     menuid: menuitems[index].menuId,
                      //     itemprice: menuitems[index].itemprice,
                      //     itemname: menuitems[index].itemname,
                      //     isChecked: menuitems[index].isChecked);
                    },
                    value: menuitems[index].isChecked),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(menuitems[index].itemname,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                      SizedBox(height: 4),
                      Text(
                          AppConstant.rupee +
                              '${double.parse(menuitems[index].itemprice) * double.parse(menuitems[index].quantity.toString())}',
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
            (isBread)
                ? (menuitems[index].isChecked)
                    ? Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            color: AppConstant.appColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove,
                                  size: 18, color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  menuitems[index].quantity--;

                                  (TempList.forEach((element) {
                                    (element.menuId == menuitems[index].menuId)
                                        ? element.quantity--
                                        : null;
                                  }));
                                });
                              },
                            ),
                            Text(menuitems[index].quantity.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            IconButton(
                                icon: Icon(Icons.add,
                                    size: 18, color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    menuitems[index].quantity++;
                                    (TempList.forEach((element) {
                                      (element.menuId ==
                                              menuitems[index].menuId)
                                          ? element.quantity++
                                          : null;
                                    }));
                                  });
                                  // mondayItems[mondayItems
                                  //     .indexWhere((e) => e.menuId == '31')];

                                  // print(mon[0].list.indexOf(mon[0].list[index]));

                                  // mondayItems[
                                  //         mon[0].list.indexOf(mon[0].list[index])]
                                  //     .menuId = '2';
                                  // setState(() {
                                  //   menuitems[index].quantity++;
                                  // });
                                }),
                          ],
                        ))
                    : Container(height: 61)
                : SizedBox(),
          ],
        );
      },
    );
  }

  // List<Menuitem> tempList = [];
  // Future aasd() async {
  //   for (int i = 0; i < bean.data.length; i++) {
  //     for (int j = i; j < bean.data[i].menuitems.length; j++) {
  //       bean.data[i].menuitems[j].isChecked
  //           ?
  //               tempList.add(bean.data[i].menuitems[j]);
  //               print(tempList);
  //
  //           : () {};
  //     }
  //   }
  // }

  // void pt() {
  //   for (int i = 0; i < tempList.length; i++) {
  //     print(menuitemToJson(tempList[i]));
  //   }
  // }

  Future<MealScreenItems> getMealScreenItems() async {
    // progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId,
        "token": "123456789",
        "package_id": widget.package_id,
      });
      bean = await ApiProvider().getMealScreenItems(from);
      print(bean.data);
      //progressDialog.dismiss();
      if (bean.status == true) {
        List<MealScreenItemsData> passinglist = [];
        passinglist = bean.data;
        setState(() {
          isPageLoading = false;
        });
        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      // progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      //  progressDialog.dismiss();
      print(exception);
    }
  }

  // Future<MealScreenItems> selectedPackageInfo() async {
  //   // progressDialog.show();
  //   try {
  //     FormData from = FormData.fromMap({
  //       "kitchen_id": '2',
  //       "token": "123456789",
  //       "package_id": '9',
  //       "weekly_package_id": '4',
  //     });
  //     MealScreenItems beanSelected =
  //         await ApiProvider().getMealScreenItems(from);
  //     print(beanSelected.data);
  //     //progressDialog.dismiss();
  //     // if (beanSeleted.status == true) {
  //     //   List<MealScreenItemsData> passinglist = [];
  //     //   passinglist = beanSelected.data;
  //     //   setState(() {});
  //     //   return beanSeleted;
  //     // } else {
  //     //   Utils.showToast(beanSeleted.message);
  //     // }
  //
  //     return null;
  //   } on HttpException catch (exception) {
  //     // progressDialog.dismiss();
  //     print(exception);
  //   } catch (exception) {
  //     //  progressDialog.dismiss();
  //     print(exception);
  //   }
  // }
}
