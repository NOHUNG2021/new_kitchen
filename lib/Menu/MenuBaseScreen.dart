// ignore_for_file: non_constant_identifier_names, must_be_immutable, unused_field

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitchen/Menu/BasePackagescreen.dart';
import 'package:kitchen/model/BeanAddLunch.dart';
import 'package:kitchen/model/BeanDinnerAdd.dart';
import 'package:kitchen/model/BeanLogin.dart';
import 'package:kitchen/model/BeanSaveMenu.dart';
import 'package:kitchen/model/BeanUpdateMenuStock.dart';
import 'package:kitchen/model/breakfastmodel.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/screen/HomeBaseScreen.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';

class MenuBaseScreen extends StatefulWidget {
  var flag;
  MenuBaseScreen(this.flag);

  @override
  _MenuBaseScreenState createState() => _MenuBaseScreenState(flag);
}

class _MenuBaseScreenState extends State<MenuBaseScreen>
    with SingleTickerProviderStateMixin {
  BreakfastModelData breakfast;
  BreakfastModelData lunch;
  BreakfastModelData dinner;
  List categories = [
    'South Indian Meals',
    'North Indian Meals',
    'Other Indian Meals'
  ];
  List cuisinetype = ['Lunch', 'Dinner', 'Both'];
  ProgressDialog _progressDialog;
  var isSelected = 1;

  TabController _controller;
  bool isReplaceOne = true;
  bool isReplaceTwo = false;
  bool isReplaceThree = false;
  bool isDinnerSouth = false;
  bool isDinnerNorth = false;
  bool isDinnerOther = false;

  bool isLunchSouth = false;
  bool isLunchNorth = false;
  bool isLunchOther = false;

  File _image;
  File _imageDinner;
  File _imageLunch;
  String isSelectVeg = 'Veg';
  String SelectLunchCategory = 'Veg';
  String SelectSouthCuisineType = 'Lunch';
  String SelectNorthCuisineType = 'Lunch';
  String SelectOtherCuisineType = 'Lunch';
  String SelectDinnerCategory = 'Veg';
  int LunchIndex = 0;
  int DinnerIndex = 0;

  var isDinnerCategory = 1;
  var isSelectMenu = 1;
  var isSelectFood = 2;
  var isMealType = 1;
  var isSelectedNorth = 1;
  bool isMenu = true;
  bool saveMenuSelected = false;
  bool addMenu = false;
  var _isOnSubscription = false;
  var _isSounIndianMeal = false;
  var _isNorthIndianist = false;
  var _isotherIndianist = false;
  var _other = false;
  var _other2 = false;
  var addDefaultIcon = true;
  var addPack = false;
  var setMenuPackage = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var flag;
  Future _future;

  var userId = "";
  var kitchenID = "";
  BeanLogin userBean;
  _MenuBaseScreenState(this.flag);

  Future getUser() async {
    userBean = await Utils.getUser();
    kitchenID = userBean.data.kitchenid.toString();
    userId = userBean.data.id.toString();
    print('uuuuuuuuuuuuuuuuuu$userId\nlllllllllllllllllllll$kitchenID');
  }

  var BreakfastSouthnameTEC = <TextEditingController>[];
  var BreakfastSouthpriceTEC = <TextEditingController>[];
  var BreakfastSouthitemImages = <File>[];
  var BreakfastNorthnameTEC = <TextEditingController>[];
  var BreakfastNorthpriceTEC = <TextEditingController>[];
  var BreakfastNorthitemImages = <File>[];
  var BreakfastOthernameTEC = <TextEditingController>[];
  var BreakfastOtherpriceTEC = <TextEditingController>[];
  var BreakfastOtheritemImages = <File>[];
  var LunchSouthnameTEC = <TextEditingController>[];
  var LunchSouthpriceTEC = <TextEditingController>[];
  var LunchSouthitemImages = <File>[];
  var LunchNorthnameTEC = <TextEditingController>[];
  var LunchNorthpriceTEC = <TextEditingController>[];
  var LunchNorthitemImages = <File>[];
  var LunchOthernameTEC = <TextEditingController>[];
  var LunchOtherpriceTEC = <TextEditingController>[];
  var LunchOtheritemImages = <File>[];
  var DinnerSouthnameTEC = <TextEditingController>[];
  var DinnerSouthpriceTEC = <TextEditingController>[];
  var DinnerSouthitemImages = <File>[];
  var DinnerNorthnameTEC = <TextEditingController>[];
  var DinnerNorthpriceTEC = <TextEditingController>[];
  var DinnerNorthitemImages = <File>[];
  var DinnerOthernameTEC = <TextEditingController>[];
  var DinnerOtherpriceTEC = <TextEditingController>[];
  var DinnerOtheritemImages = <File>[];

  var rowsBreakfastSouth = <Widget>[];
  var rowsBreakfastNorth = <Widget>[];
  var rowsBreakfastOther = <Widget>[];
  var rowsDinnerSouth = <Widget>[];
  var rowsDinnerNorth = <Widget>[];
  var rowsDinnerOther = <Widget>[];
  var rowsLunchSouth = <Widget>[];
  var rowsLunchNorth = <Widget>[];
  var rowsLunchOther = <Widget>[];

  // var rows = <Widget>[];

  Widget createRow(
      {List<TextEditingController> name,
      List<TextEditingController> price,
      List<File> itemImages}) {
    var nameController = TextEditingController();
    var priceController = TextEditingController();
    // nameTEC.add(nameController);
    name.add(nameController);
    price.add(priceController);
    itemImages.add(null);
    // priceTEC.add(priceController);
    // itemImages.add(null);
    return Container(
      width: 250,
      child: Row(
        children: [
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10, top: 30),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: "name"),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: 50,
              margin: EdgeInsets.only(left: 10, right: 16, top: 30),
              child: TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(hintText: AppConstant.rupee + " Price"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future getAllMenu() async {
    getMenuLunch();
    // getMenuDinner();
    getBreakFastMenu();
  }

  @override
  void initState() {
    getUser().then((value) {
      getAllMenu();

      rowsBreakfastSouth.add(createRow(
          name: BreakfastSouthnameTEC,
          price: BreakfastSouthpriceTEC,
          itemImages: BreakfastSouthitemImages));
      rowsBreakfastNorth.add(createRow(
          name: BreakfastNorthnameTEC,
          price: BreakfastNorthpriceTEC,
          itemImages: BreakfastNorthitemImages));
      rowsBreakfastOther.add(createRow(
          name: BreakfastOthernameTEC,
          price: BreakfastOtherpriceTEC,
          itemImages: BreakfastOtheritemImages));

      rowsLunchSouth.add(createRow(
          name: LunchSouthnameTEC,
          price: LunchSouthpriceTEC,
          itemImages: LunchSouthitemImages));
      rowsLunchNorth.add(createRow(
          name: LunchNorthnameTEC,
          price: LunchNorthpriceTEC,
          itemImages: LunchNorthitemImages));
      rowsLunchOther.add(createRow(
          name: LunchOthernameTEC,
          price: LunchOtherpriceTEC,
          itemImages: LunchOtheritemImages));

      rowsDinnerSouth.add(createRow(
          name: DinnerSouthnameTEC,
          price: DinnerSouthpriceTEC,
          itemImages: DinnerSouthitemImages));
      rowsDinnerNorth.add(createRow(
          name: DinnerNorthnameTEC,
          price: DinnerNorthpriceTEC,
          itemImages: DinnerNorthitemImages));
      rowsDinnerOther.add(createRow(
          name: DinnerOthernameTEC,
          price: DinnerOtherpriceTEC,
          itemImages: DinnerOtheritemImages));
    });
    _controller = new TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    _progressDialog = new ProgressDialog(context);
    return Scaffold(
        drawer: MyDrawers(),
        key: _scaffoldKey,
        backgroundColor: AppConstant.appColor,
        body: Column(
          children: [
            visileMenuheader(),
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
        ));
  }

  MenuSelected() {
    if (isSelected == 1) {
      return getPage();
    } else {
      return BasePackagescreen();
    }
  }

  getPage() {
    if (isReplaceOne == true) {
      // return replaceAddMenu();
      // return replaceDefaultScreen();
      return replaceSaveMenu();
    } else if (isReplaceTwo == true) {
      return replaceAddMenu();
    } else if (isReplaceThree == true) {
      return replaceSaveMenu();
    }
  }

  Widget BreakfastTile() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          child: Padding(
        padding: EdgeInsets.only(left: 16, top: 16),
        child: Text(
          'Breakfast',
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: AppConstant.fontBold),
        ),
      )),
      SizedBox(height: 10),
      ExpansionTile(
        onExpansionChanged: (bool val) {
          print(val);
          setState(() {
            _isSounIndianMeal = val;
            // _isotherIndianist = false;
            // _isNorthIndianist = false;
          });
        },
        title: Text(
          'South Indian Meal',
          style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: AppConstant.fontRegular),
        ),
        trailing: Container(
          height: 30,
          width: 30,
          margin: EdgeInsets.only(right: 20, top: 10),
          child: CupertinoSwitch(
            activeColor: Color(0xff7EDABF),
            value: _isSounIndianMeal, onChanged: (bool value) {  },
          ),
        ),
        children: <Widget>[
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isSelectVeg = breakfast.southIndian[0].category;
                  });
                },
                child: Container(
                  height: 40,
                  width: 110,
                  margin: EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                      color: isSelectVeg == breakfast.southIndian[0].category
                          ? Color(0xffFFA451)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      breakfast.southIndian[0].category,
                      style: TextStyle(
                          color:
                              isSelectVeg == breakfast.southIndian[0].category
                                  ? Colors.white
                                  : Colors.black,
                          fontSize: 14,
                          fontFamily: AppConstant.fontBold),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isSelectVeg = breakfast.southIndian[1].category;
                  });
                },
                child: Container(
                  height: 40,
                  width: 110,
                  margin: EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                      color: isSelectVeg == breakfast.southIndian[1].category
                          ? Color(0xffFFA451)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      breakfast.southIndian[1].category,
                      style: TextStyle(
                          color:
                              isSelectVeg == breakfast.southIndian[1].category
                                  ? Colors.white
                                  : Colors.black,
                          fontSize: 14,
                          fontFamily: AppConstant.fontBold),
                    ),
                  ),
                ),
              )
            ],
          ),
          // row----------------->
          (isSelectVeg == breakfast.southIndian[0].category)
              ? CategoryMenuItems(list: breakfast.southIndian[0].list)
              : CategoryMenuItems(list: breakfast.southIndian[1].list),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: rowsBreakfastSouth.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      _showPicker(context, index, BreakfastSouthitemImages);
                    },
                    child: Padding(
                        padding: EdgeInsets.only(top: 30, left: 6),
                        child: BreakfastSouthitemImages.isEmpty
                            ? Image.asset(
                                Res.ic_poha,
                                width: 55,
                                height: 55,
                                fit: BoxFit.cover,
                              )
                            : BreakfastSouthitemImages.elementAt(index) == null
                                ? Image.asset(
                                    Res.ic_poha,
                                    width: 55,
                                    height: 55,
                                    fit: BoxFit.cover,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      BreakfastSouthitemImages.elementAt(index),
                                      width: 55,
                                      height: 55,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                  ),
                  rowsBreakfastSouth[index],
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          rowsBreakfastSouth.removeAt(index);
                          BreakfastSouthnameTEC.removeAt(index);
                          BreakfastSouthpriceTEC.removeAt(index);
                          BreakfastSouthitemImages.removeAt(index);
                        });
                      },
                    ),
                  )
                ],
              );
            },
          ),

          SizedBox(height: 26),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                rowsBreakfastSouth.add(createRow(
                    name: BreakfastSouthnameTEC,
                    price: BreakfastSouthpriceTEC,
                    itemImages: BreakfastSouthitemImages));
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppConstant.appColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Text('Add another menu'),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: InkWell(
              onTap: () {
                _onDone(
                    cuisinetype: '0',
                    rowsData: rowsBreakfastSouth,
                    nameValidation: BreakfastSouthnameTEC,
                    priceValidation: BreakfastSouthpriceTEC,
                    imageValidation: BreakfastSouthitemImages);
              },
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: AppConstant.appColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "Add Breakfast",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
      ExpansionTile(
        onExpansionChanged: (bool val) {
          print(val);
          setState(() {
            _isNorthIndianist = val;
          });
        },
        title: Text(
          'North Indian Meal',
          style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: AppConstant.fontRegular),
        ),
        trailing: Container(
          height: 30,
          width: 30,
          margin: EdgeInsets.only(right: 20, top: 10),
          child: CupertinoSwitch(
            activeColor: Color(0xff7EDABF),
            value: _isNorthIndianist, onChanged: (bool value) {  },
          ),
        ),
        children: <Widget>[
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isSelectVeg = breakfast.northIndian[0].category;
                  });
                },
                child: Container(
                  height: 40,
                  width: 110,
                  margin: EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                      color: isSelectVeg == breakfast.northIndian[0].category
                          ? Color(0xffFFA451)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      breakfast.northIndian[0].category,
                      style: TextStyle(
                          color:
                              isSelectVeg == breakfast.northIndian[0].category
                                  ? Colors.white
                                  : Colors.black,
                          fontSize: 14,
                          fontFamily: AppConstant.fontBold),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isSelectVeg = breakfast.northIndian[1].category;
                  });
                },
                child: Container(
                  height: 40,
                  width: 110,
                  margin: EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                      color: isSelectVeg == breakfast.northIndian[1].category
                          ? Color(0xffFFA451)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      breakfast.northIndian[1].category,
                      style: TextStyle(
                          color:
                              isSelectVeg == breakfast.northIndian[1].category
                                  ? Colors.white
                                  : Colors.black,
                          fontSize: 14,
                          fontFamily: AppConstant.fontBold),
                    ),
                  ),
                ),
              )
            ],
          ),
          //row----------------->
          (isSelectVeg == breakfast.northIndian[0].category)
              ? CategoryMenuItems(list: breakfast.northIndian[0].list)
              : CategoryMenuItems(list: breakfast.northIndian[1].list),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: rowsBreakfastNorth.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      _showPicker(context, index, BreakfastNorthitemImages);
                    },
                    child: Padding(
                        padding: EdgeInsets.only(top: 30, left: 6),
                        child: BreakfastNorthitemImages.isEmpty
                            ? Image.asset(
                                Res.ic_poha,
                                width: 55,
                                height: 55,
                                fit: BoxFit.cover,
                              )
                            : BreakfastNorthitemImages.elementAt(index) == null
                                ? Image.asset(
                                    Res.ic_poha,
                                    width: 55,
                                    height: 55,
                                    fit: BoxFit.cover,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      BreakfastNorthitemImages.elementAt(index),
                                      width: 55,
                                      height: 55,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                  ),
                  rowsBreakfastNorth[index],
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          rowsBreakfastNorth.removeAt(index);
                          BreakfastNorthnameTEC.removeAt(index);
                          BreakfastNorthpriceTEC.removeAt(index);
                          BreakfastNorthitemImages.removeAt(index);
                        });
                      },
                    ),
                  )
                ],
              );
            },
          ),

          SizedBox(height: 26),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                rowsBreakfastNorth.add(createRow(
                    name: BreakfastNorthnameTEC,
                    price: BreakfastNorthpriceTEC,
                    itemImages: BreakfastNorthitemImages));
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppConstant.appColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Text('Add another menu'),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: InkWell(
              onTap: () {
                _onDone(
                    cuisinetype: '1',
                    rowsData: rowsBreakfastNorth,
                    nameValidation: BreakfastNorthnameTEC,
                    priceValidation: BreakfastNorthpriceTEC,
                    imageValidation: BreakfastNorthitemImages);
              },
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: AppConstant.appColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "Add Breakfast",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
      ExpansionTile(
        onExpansionChanged: (bool val) {
          print(val);
          setState(() {
            // _isSounIndianMeal = false;
            _isotherIndianist = val;
            // _isNorthIndianist = false;
          });
        },
        title: Text(
          'Other Indian Meal',
          style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: AppConstant.fontRegular),
        ),
        trailing: Container(
          height: 30,
          width: 30,
          margin: EdgeInsets.only(right: 20, top: 10),
          child: CupertinoSwitch(
            activeColor: Color(0xff7EDABF),
            value: _isotherIndianist, onChanged: (bool value) {  },
          ),
        ),
        children: <Widget>[
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isSelectVeg = breakfast.otherIndian[0].category;
                  });
                },
                child: Container(
                  height: 40,
                  width: 110,
                  margin: EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                      color: isSelectVeg == breakfast.otherIndian[0].category
                          ? Color(0xffFFA451)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      breakfast.otherIndian[0].category,
                      style: TextStyle(
                          color:
                              isSelectVeg == breakfast.otherIndian[0].category
                                  ? Colors.white
                                  : Colors.black,
                          fontSize: 14,
                          fontFamily: AppConstant.fontBold),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isSelectVeg = breakfast.otherIndian[1].category;
                  });
                },
                child: Container(
                  height: 40,
                  width: 110,
                  margin: EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                      color: isSelectVeg == breakfast.otherIndian[1].category
                          ? Color(0xffFFA451)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      breakfast.otherIndian[1].category,
                      style: TextStyle(
                          color:
                              isSelectVeg == breakfast.otherIndian[1].category
                                  ? Colors.white
                                  : Colors.black,
                          fontSize: 14,
                          fontFamily: AppConstant.fontBold),
                    ),
                  ),
                ),
              )
            ],
          ),
          //row----------------->
          (isSelectVeg == breakfast.otherIndian[0].category)
              ? CategoryMenuItems(list: breakfast.otherIndian[0].list)
              : CategoryMenuItems(list: breakfast.otherIndian[1].list),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: rowsBreakfastOther.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      _showPicker(context, index, BreakfastOtheritemImages);
                    },
                    child: Padding(
                        padding: EdgeInsets.only(top: 30, left: 6),
                        child: BreakfastOtheritemImages.isEmpty
                            ? Image.asset(
                                Res.ic_poha,
                                width: 55,
                                height: 55,
                                fit: BoxFit.cover,
                              )
                            : BreakfastOtheritemImages.elementAt(index) == null
                                ? Image.asset(
                                    Res.ic_poha,
                                    width: 55,
                                    height: 55,
                                    fit: BoxFit.cover,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      BreakfastOtheritemImages.elementAt(index),
                                      width: 55,
                                      height: 55,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                  ),
                  rowsBreakfastOther[index],
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          rowsBreakfastOther.removeAt(index);
                          BreakfastOthernameTEC.removeAt(index);
                          BreakfastOtherpriceTEC.removeAt(index);
                          BreakfastOtheritemImages.removeAt(index);
                        });
                      },
                    ),
                  )
                ],
              );
            },
          ),

          SizedBox(height: 26),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                rowsBreakfastOther.add(createRow(
                    name: BreakfastOthernameTEC,
                    price: BreakfastOtherpriceTEC,
                    itemImages: BreakfastOtheritemImages));
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppConstant.appColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Text('Add another menu'),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: InkWell(
              onTap: () {
                _onDone(
                    cuisinetype: '2',
                    rowsData: rowsBreakfastOther,
                    nameValidation: BreakfastOthernameTEC,
                    priceValidation: BreakfastOtherpriceTEC,
                    imageValidation: BreakfastOtheritemImages);
              },
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: AppConstant.appColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "Add Breakfast",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
      SizedBox(height: 26),
      Divider(height: 20, thickness: 5, color: Colors.grey.shade100),
    ]);
  }

  ListView CategoryMenuItems({List<ListElement> list}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            InkWell(
              onTap: () {
                // _showPicker(context, index,);
              },
              child: Padding(
                  padding: EdgeInsets.only(top: 30, left: 6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      list[index].image,
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            Container(
              width: 250,
              child: Row(
                children: [
                  (list[index].menutype == '3')
                      ? Container(
                          margin: EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Color(0xffFFA451))),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'Lunch&Dinner',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        )
                      : (list[index].menutype == '1')
                          ? Container(
                              margin: EdgeInsets.only(top: 30),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Color(0xffFFA451))),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Lunch',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            )
                          : (list[index].menutype == '2')
                              ? Container(
                                  margin: EdgeInsets.only(top: 30),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border:
                                          Border.all(color: Color(0xffFFA451))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Dinner',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 10, top: 30),
                    child: Text(list[index].itemname),
                  )),
                  Expanded(
                      child: Container(
                    width: 50,
                    margin: EdgeInsets.only(left: 10, right: 16, top: 30),
                    child: Text(list[index].itemprice),
                  )),
                ],
              ),
            ),

            // Text(breakfast.southIndian[0].list[index].itemprice),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _progressDialog.show();
                    ApiProvider()
                        .delete_Menu_item(FormData.fromMap({
                      'token': '123456789',
                      'kitchen_id': userId,
                      'menu_id': list[index].menuId
                    }))
                        .then((value) {
                      setState(() {
                        (value['status']) ? list.removeAt(index) : {};
                      });
                      _progressDialog.dismiss();
                    });
                  });
                },
              ),
            )
          ],
        );
      },
    );
  }

  _onDone(
      {String cuisinetype,
      List<Widget> rowsData,
      List<TextEditingController> nameValidation,
      List<TextEditingController> priceValidation,
      List<File> imageValidation}) {
    for (int i = 0; i < rowsData.length; i++) {
      print(i.toString() + "=>");
      validationAddBreakfast(
          i, cuisinetype, nameValidation, priceValidation, imageValidation);
      // addBreakfast(i);
    }
  }

  _onDoneLunch(
      {String cuisinetype,
      String menutype,
      List<Widget> rowsData,
      List<TextEditingController> nameValidation,
      List<TextEditingController> priceValidation,
      List<File> imageValidation}) {
    for (int i = 0; i < rowsData.length; i++) {
      print(i.toString() + "=>");
      validationAddLunch(menutype, i, cuisinetype, nameValidation,
          priceValidation, imageValidation);
      // addBreakfast(i);
    }
  }

  _onDoneDinner(
      {String cuisinetype,
      List<Widget> rowsData,
      List<TextEditingController> nameValidation,
      List<TextEditingController> priceValidation,
      List<File> imageValidation}) {
    for (int i = 0; i < rowsData.length; i++) {
      print(i.toString() + "=>");
      validationAddDinner(
          i, cuisinetype, nameValidation, priceValidation, imageValidation);
      // addBreakfast(i);
    }
  }

  void validationAddBreakfast(
      int index,
      String cuisinetype,
      List<TextEditingController> nameValidation,
      List<TextEditingController> priceValidation,
      List<File> imageValidation) {
    if (nameValidation[index].text.isEmpty) {
      Utils.showToast("Please add breakfast name");
    } else if (priceValidation[index].text.isEmpty) {
      Utils.showToast("Please add breakfast price");
    } else if (imageValidation.elementAt(index) == null) {
      Utils.showToast("Please add breakfast image");
    } else {
      addBreakfast(index, cuisinetype,
          nameValidation: nameValidation,
          priceValidation: priceValidation,
          imageValidation: imageValidation);
    }
  }

  void validationAddLunch(
      String menutype,
      int index,
      String cuisinetype,
      List<TextEditingController> nameValidation,
      List<TextEditingController> priceValidation,
      List<File> imageValidation) {
    if (nameValidation[index].text.isEmpty) {
      Utils.showToast("Please add Lunch name");
    } else if (priceValidation[index].text.isEmpty) {
      Utils.showToast("Please add Lunch price");
    } else if (imageValidation.elementAt(index) == null) {
      Utils.showToast("Please add Lunch image");
    } else {
      addLunch(index, cuisinetype,
          nameValidation: nameValidation,
          priceValidation: priceValidation,
          imageValidation: imageValidation,
          menutype: menutype);
    }
  }

  void validationAddDinner(
      int index,
      String cuisinetype,
      List<TextEditingController> nameValidation,
      List<TextEditingController> priceValidation,
      List<File> imageValidation) {
    if (nameValidation[index].text.isEmpty) {
      Utils.showToast("Please add Dinner name");
    } else if (priceValidation[index].text.isEmpty) {
      Utils.showToast("Please add Dinner price");
    } else if (imageValidation.elementAt(index) == null) {
      Utils.showToast("Please add Dinner image");
    } else {
      addDinner(index, cuisinetype,
          nameValidation: nameValidation,
          priceValidation: priceValidation,
          imageValidation: imageValidation);
    }
  }

  Future<BeanSaveMenu> addBreakfast(int index, String cuisineType,
      {List<TextEditingController> nameValidation,
      List<TextEditingController> priceValidation,
      List<File> imageValidation}) async {
    _progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId,
        "token": "123456789",
        "category": isSelectVeg,
        "cuisinetype": cuisineType,
        "itemname[]": nameValidation[index].text,
        "price[]": priceValidation[index].text,
        "item_image1": await MultipartFile.fromFile(
            imageValidation.elementAt(index).path,
            filename: imageValidation.elementAt(index).path),
      });
      BeanSaveMenu bean = await ApiProvider().beanSaveMenu(from);
      _progressDialog.dismiss();
      if (bean.status == true) {
        _progressDialog.dismiss();
        getAllMenu();
        setState(() {
          nameValidation[index].clear();
          priceValidation[index].clear();
          imageValidation[index] = null;
        });

        Utils.showToast(bean.message);
        return bean;
      } else {
        _progressDialog.dismiss();
        setState(() {
          nameValidation[index].clear();
          priceValidation[index].clear();
          imageValidation[index] = null;
        });
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      _progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      _progressDialog.dismiss();
      print(exception);
    }
  }

  Future<BeanLunchAdd> addLunch(int index, String cuisineType,
      {List<TextEditingController> nameValidation,
      List<TextEditingController> priceValidation,
      List<File> imageValidation,
      String menutype}) async {
    _progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId,
        "token": "123456789",
        "category": SelectLunchCategory,
        "cuisinetype": cuisineType,
        "itemname[]": nameValidation[index].text,
        "price[]": priceValidation[index].text,
        "item_image1": await MultipartFile.fromFile(
            imageValidation.elementAt(index).path,
            filename: imageValidation.elementAt(index).path),
        "menutype[]": menutype
      });
      BeanLunchAdd bean = await ApiProvider().beanLunchAdd(from);
      _progressDialog.dismiss();

      if (bean.status == true) {
        _progressDialog.dismiss();
        getAllMenu();
        setState(() {
          nameValidation[index].clear();
          priceValidation[index].clear();
          imageValidation[index] = null;
        });

        Utils.showToast(bean.message);
        return bean;
      } else {
        _progressDialog.dismiss();
        setState(() {
          nameValidation[index].clear();
          priceValidation[index].clear();
          imageValidation[index] = null;
        });
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      _progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      _progressDialog.dismiss();
      print(exception);
    }
  }

  Future<BeanDinnerAdd> addDinner(int index, String cuisineType,
      {List<TextEditingController> nameValidation,
      List<TextEditingController> priceValidation,
      List<File> imageValidation}) async {
    _progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId,
        "token": "123456789",
        "category": SelectDinnerCategory,
        "cuisinetype": cuisineType,
        "itemname[]": nameValidation[index].text,
        "price[]": priceValidation[index].text,
        "item_image1": await MultipartFile.fromFile(
            imageValidation.elementAt(index).path,
            filename: imageValidation.elementAt(index).path),
      });
      BeanDinnerAdd bean = await ApiProvider().beanDinnerAdd(from);
      _progressDialog.dismiss();
      if (bean.status == true) {
        _progressDialog.dismiss();
        getAllMenu();
        setState(() {
          nameValidation[index].clear();
          priceValidation[index].clear();
          imageValidation[index] = null;
        });

        Utils.showToast(bean.message);
        return bean;
      } else {
        _progressDialog.dismiss();
        setState(() {
          nameValidation[index].clear();
          priceValidation[index].clear();
          imageValidation[index] = null;
        });
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      _progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      _progressDialog.dismiss();
      print(exception);
    }
  }

  String southMealType = '1';
  String northMealType = '1';
  String otherMealType = '1';

  replaceAddMenu() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Breakfast---------------------------------------------------
            BreakfastTile(),

            //Lunch---------------------------------------------------
            Padding(
              padding: EdgeInsets.only(left: 16, top: 20),
              child: Text(
                'Lunch & Dinner',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: AppConstant.fontBold),
              ),
            ),
            ExpansionTile(
              onExpansionChanged: (bool val) {
                print(val);
                setState(() {
                  isLunchSouth = val;
                });
              },
              title: Text(
                'South Indian Meals',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: AppConstant.fontRegular),
              ),
              trailing: Container(
                height: 30,
                width: 30,
                margin: EdgeInsets.only(right: 20, top: 10),
                child: CupertinoSwitch(
                  activeColor: Color(0xff7EDABF),
                  value: isLunchSouth, onChanged: (bool value) {  },
                ),
              ),
              children: <Widget>[
                SizedBox(height: 15),
                Container(
                  height: 40,
                  child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            SelectLunchCategory =
                                lunch.southIndian[index].category;
                            LunchIndex = index;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 110,
                          margin: EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                              color: SelectLunchCategory ==
                                      lunch.southIndian[index].category
                                  ? Color(0xffFFA451)
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              lunch.southIndian[index].category,
                              style: TextStyle(
                                  color: SelectLunchCategory ==
                                          lunch.southIndian[index].category
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14,
                                  fontFamily: AppConstant.fontBold),
                            ),
                          ),
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Divider(),
                Container(
                  height: 40,
                  child: ListView.builder(
                    itemCount: cuisinetype.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            SelectSouthCuisineType = cuisinetype[index];
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 110,
                          margin: EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                              color:
                                  SelectSouthCuisineType == cuisinetype[index]
                                      ? Color(0xffFFA451)
                                      : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              cuisinetype[index],
                              style: TextStyle(
                                  color: SelectSouthCuisineType ==
                                          cuisinetype[index]
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14,
                                  fontFamily: AppConstant.fontBold),
                            ),
                          ),
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                (SelectLunchCategory == lunch.southIndian[LunchIndex].category)
                    ? CategoryMenuItems(
                        list: lunch.southIndian[LunchIndex].list)
                    : Container(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: rowsLunchSouth.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            _showPicker(context, index, LunchSouthitemImages);
                          },
                          child: Padding(
                              padding: EdgeInsets.only(top: 30, left: 6),
                              child: LunchSouthitemImages.isEmpty
                                  ? Image.asset(
                                      Res.ic_poha,
                                      width: 55,
                                      height: 55,
                                      fit: BoxFit.cover,
                                    )
                                  : LunchSouthitemImages.elementAt(index) ==
                                          null
                                      ? Image.asset(
                                          Res.ic_poha,
                                          width: 55,
                                          height: 55,
                                          fit: BoxFit.cover,
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.file(
                                            LunchSouthitemImages.elementAt(
                                                index),
                                            width: 55,
                                            height: 55,
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                        ),
                        rowsLunchSouth[index],
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                rowsLunchSouth.removeAt(index);
                                LunchSouthnameTEC.removeAt(index);
                                LunchSouthpriceTEC.removeAt(index);
                                LunchSouthitemImages.removeAt(index);
                              });
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
                SizedBox(height: 26),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      rowsLunchSouth.add(createRow(
                          name: LunchSouthnameTEC,
                          price: LunchSouthpriceTEC,
                          itemImages: LunchSouthitemImages));
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: AppConstant.appColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Text('Add another menu'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: InkWell(
                    onTap: () {
                      _onDoneLunch(
                          menutype: (SelectSouthCuisineType) == 'Lunch'
                              ? '1'
                              : (SelectSouthCuisineType) == 'Dinner'
                                  ? '2'
                                  : '3',
                          cuisinetype: '0',
                          rowsData: rowsLunchSouth,
                          nameValidation: LunchSouthnameTEC,
                          priceValidation: LunchSouthpriceTEC,
                          imageValidation: LunchSouthitemImages);
                    },
                    child: Container(
                      height: 40,
                      width: 110,
                      decoration: BoxDecoration(
                        color: AppConstant.appColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "Save Menu",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
            SizedBox(height: 15),
            ExpansionTile(
              onExpansionChanged: (bool val) {
                print(val);
                setState(() {
                  isLunchNorth = val;
                });
              },
              title: Text(
                'North Indian Meals',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: AppConstant.fontRegular),
              ),
              trailing: Container(
                height: 30,
                width: 30,
                margin: EdgeInsets.only(right: 20, top: 10),
                child: CupertinoSwitch(
                  activeColor: Color(0xff7EDABF),
                  value: isLunchNorth, onChanged: (bool value) {  },
                ),
              ),
              children: <Widget>[
                SizedBox(height: 15),
                Container(
                  height: 40,
                  child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            SelectLunchCategory =
                                lunch.northIndian[index].category;
                            LunchIndex = index;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 110,
                          margin: EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                              color: SelectLunchCategory ==
                                      lunch.northIndian[index].category
                                  ? Color(0xffFFA451)
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              lunch.northIndian[index].category,
                              style: TextStyle(
                                  color: SelectLunchCategory ==
                                          lunch.northIndian[index].category
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14,
                                  fontFamily: AppConstant.fontBold),
                            ),
                          ),
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Divider(),
                Container(
                  height: 40,
                  child: ListView.builder(
                    itemCount: cuisinetype.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            SelectNorthCuisineType = cuisinetype[index];
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 110,
                          margin: EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                              color:
                                  SelectNorthCuisineType == cuisinetype[index]
                                      ? Color(0xffFFA451)
                                      : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              cuisinetype[index],
                              style: TextStyle(
                                  color: SelectNorthCuisineType ==
                                          cuisinetype[index]
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14,
                                  fontFamily: AppConstant.fontBold),
                            ),
                          ),
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                (SelectLunchCategory == lunch.northIndian[LunchIndex].category)
                    ? CategoryMenuItems(
                        list: lunch.northIndian[LunchIndex].list)
                    : Container(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: rowsLunchNorth.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            _showPicker(context, index, LunchNorthitemImages);
                          },
                          child: Padding(
                              padding: EdgeInsets.only(top: 30, left: 6),
                              child: LunchNorthitemImages.isEmpty
                                  ? Image.asset(
                                      Res.ic_poha,
                                      width: 55,
                                      height: 55,
                                      fit: BoxFit.cover,
                                    )
                                  : LunchNorthitemImages.elementAt(index) ==
                                          null
                                      ? Image.asset(
                                          Res.ic_poha,
                                          width: 55,
                                          height: 55,
                                          fit: BoxFit.cover,
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.file(
                                            File(LunchNorthitemImages.elementAt(
                                                    index)
                                                .path),
                                            width: 55,
                                            height: 55,
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                        ),
                        rowsLunchNorth[index],
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                rowsLunchNorth.removeAt(index);
                                LunchNorthnameTEC.removeAt(index);
                                LunchNorthpriceTEC.removeAt(index);
                                LunchNorthitemImages.removeAt(index);
                              });
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
                SizedBox(height: 26),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      rowsLunchNorth.add(createRow(
                          name: LunchNorthnameTEC,
                          price: LunchNorthpriceTEC,
                          itemImages: LunchNorthitemImages));
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: AppConstant.appColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Text('Add another menu'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: InkWell(
                    onTap: () {
                      _onDoneLunch(
                          menutype: (SelectNorthCuisineType) == 'Lunch'
                              ? '1'
                              : (SelectNorthCuisineType) == 'Dinner'
                                  ? '2'
                                  : '3',
                          cuisinetype: '1',
                          rowsData: rowsLunchNorth,
                          nameValidation: LunchNorthnameTEC,
                          priceValidation: LunchNorthpriceTEC,
                          imageValidation: LunchNorthitemImages);
                    },
                    child: Container(
                      height: 40,
                      width: 110,
                      decoration: BoxDecoration(
                        color: AppConstant.appColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "Save Menu",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
            SizedBox(height: 15),
            ExpansionTile(
              onExpansionChanged: (bool val) {
                print(val);
                setState(() {
                  isLunchOther = val;
                });
              },
              title: Text(
                'Other Indian Meals',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: AppConstant.fontRegular),
              ),
              trailing: Container(
                height: 30,
                width: 30,
                margin: EdgeInsets.only(right: 20, top: 10),
                child: CupertinoSwitch(
                  activeColor: Color(0xff7EDABF),
                  value: isLunchOther, onChanged: (bool value) {  },
                ),
              ),
              children: <Widget>[
                SizedBox(height: 15),
                Container(
                  height: 40,
                  child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            SelectLunchCategory =
                                lunch.otherIndian[index].category;
                            LunchIndex = index;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 110,
                          margin: EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                              color: SelectLunchCategory ==
                                      lunch.otherIndian[index].category
                                  ? Color(0xffFFA451)
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              lunch.otherIndian[index].category,
                              style: TextStyle(
                                  color: SelectLunchCategory ==
                                          lunch.otherIndian[index].category
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14,
                                  fontFamily: AppConstant.fontBold),
                            ),
                          ),
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Divider(),
                Container(
                  height: 40,
                  child: ListView.builder(
                    itemCount: cuisinetype.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            SelectOtherCuisineType = cuisinetype[index];
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 110,
                          margin: EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                              color:
                                  SelectOtherCuisineType == cuisinetype[index]
                                      ? Color(0xffFFA451)
                                      : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              cuisinetype[index],
                              style: TextStyle(
                                  color: SelectOtherCuisineType ==
                                          cuisinetype[index]
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14,
                                  fontFamily: AppConstant.fontBold),
                            ),
                          ),
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                (SelectLunchCategory == lunch.otherIndian[LunchIndex].category)
                    ? CategoryMenuItems(
                        list: lunch.otherIndian[LunchIndex].list)
                    : Container(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: rowsLunchOther.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            _showPicker(context, index, LunchOtheritemImages);
                          },
                          child: Padding(
                              padding: EdgeInsets.only(top: 30, left: 6),
                              child: LunchOtheritemImages.isEmpty
                                  ? Image.asset(
                                      Res.ic_poha,
                                      width: 55,
                                      height: 55,
                                      fit: BoxFit.cover,
                                    )
                                  : LunchOtheritemImages.elementAt(index) ==
                                          null
                                      ? Image.asset(
                                          Res.ic_poha,
                                          width: 55,
                                          height: 55,
                                          fit: BoxFit.cover,
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.file(
                                            LunchOtheritemImages.elementAt(
                                                index),
                                            width: 55,
                                            height: 55,
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                        ),
                        rowsLunchOther[index],
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                rowsLunchOther.removeAt(index);
                                LunchOthernameTEC.removeAt(index);
                                LunchOtherpriceTEC.removeAt(index);
                                LunchOtheritemImages.removeAt(index);
                              });
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
                SizedBox(height: 26),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      rowsLunchOther.add(createRow(
                          name: LunchOthernameTEC,
                          price: LunchOtherpriceTEC,
                          itemImages: LunchOtheritemImages));
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: AppConstant.appColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Text('Add another menu'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: InkWell(
                    onTap: () {
                      _onDoneLunch(
                          menutype: (SelectOtherCuisineType) == 'Lunch'
                              ? '1'
                              : (SelectOtherCuisineType) == 'Dinner'
                                  ? '2'
                                  : '3',
                          cuisinetype: '2',
                          rowsData: rowsLunchOther,
                          nameValidation: LunchOthernameTEC,
                          priceValidation: LunchOtherpriceTEC,
                          imageValidation: LunchOtheritemImages);
                    },
                    child: Container(
                      height: 40,
                      width: 110,
                      decoration: BoxDecoration(
                        color: AppConstant.appColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "Save Menu",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
            Divider(height: 20, thickness: 5, color: Colors.grey.shade100),
            //Dinner--------------------------------------------------
            // Padding(
            //   padding: EdgeInsets.only(left: 16, top: 20),
            //   child: Text(
            //     'Dinner',
            //     style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 20,
            //         fontFamily: AppConstant.fontBold),
            //   ),
            // ),
            // ExpansionTile(
            //   onExpansionChanged: (bool val) {
            //     print(val);
            //     setState(() {
            //       isDinnerSouth = val;
            //     });
            //   },
            //   title: Text(
            //     'South Indian Meals',
            //     style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 14,
            //         fontFamily: AppConstant.fontRegular),
            //   ),
            //   trailing: Container(
            //     height: 30,
            //     width: 30,
            //     margin: EdgeInsets.only(right: 20, top: 10),
            //     child: CupertinoSwitch(
            //       activeColor: Color(0xff7EDABF),
            //       value: isDinnerSouth,
            //     ),
            //   ),
            //   children: <Widget>[
            //     SizedBox(height: 15),
            //     Container(
            //       height: 40,
            //       child: ListView.builder(
            //         itemCount: dinner.southIndian.length,
            //         itemBuilder: (context, index) {
            //           return InkWell(
            //             onTap: () {
            //               setState(() {
            //                 SelectDinnerCategory =
            //                     dinner.southIndian[index].category;
            //                 DinnerIndex = index;
            //               });
            //             },
            //             child: Container(
            //               height: 40,
            //               width: 110,
            //               margin: EdgeInsets.only(left: 16),
            //               decoration: BoxDecoration(
            //                   color: SelectDinnerCategory ==
            //                           dinner.southIndian[index].category
            //                       ? Color(0xffFFA451)
            //                       : Colors.grey.shade200,
            //                   borderRadius: BorderRadius.circular(10)),
            //               child: Center(
            //                 child: Text(
            //                   dinner.southIndian[index].category,
            //                   style: TextStyle(
            //                       color: SelectDinnerCategory ==
            //                               dinner.southIndian[index].category
            //                           ? Colors.white
            //                           : Colors.black,
            //                       fontSize: 14,
            //                       fontFamily: AppConstant.fontBold),
            //                 ),
            //               ),
            //             ),
            //           );
            //         },
            //         scrollDirection: Axis.horizontal,
            //       ),
            //     ),
            //     (SelectDinnerCategory ==
            //             dinner.southIndian[DinnerIndex].category)
            //         ? CategoryMenuItems(
            //             list: dinner.southIndian[DinnerIndex].list)
            //         : Container(),
            //     ListView.builder(
            //       shrinkWrap: true,
            //       physics: NeverScrollableScrollPhysics(),
            //       itemCount: rowsDinnerSouth.length,
            //       itemBuilder: (BuildContext context, int index) {
            //         return Row(
            //           children: [
            //             InkWell(
            //               onTap: () {
            //                 _showPicker(context, index, DinnerSouthitemImages);
            //               },
            //               child: Padding(
            //                   padding: EdgeInsets.only(top: 30, left: 6),
            //                   child: DinnerSouthitemImages.isEmpty
            //                       ? Image.asset(
            //                           Res.ic_poha,
            //                           width: 55,
            //                           height: 55,
            //                           fit: BoxFit.cover,
            //                         )
            //                       : DinnerSouthitemImages.elementAt(index) ==
            //                               null
            //                           ? Image.asset(
            //                               Res.ic_poha,
            //                               width: 55,
            //                               height: 55,
            //                               fit: BoxFit.cover,
            //                             )
            //                           : ClipRRect(
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               child: Image.file(
            //                                 DinnerSouthitemImages.elementAt(
            //                                     index),
            //                                 width: 55,
            //                                 height: 55,
            //                                 fit: BoxFit.cover,
            //                               ),
            //                             )),
            //             ),
            //             rowsDinnerSouth[index],
            //             Padding(
            //               padding: const EdgeInsets.only(top: 25.0),
            //               child: IconButton(
            //                 icon: Icon(Icons.delete),
            //                 onPressed: () {
            //                   setState(() {
            //                     rowsDinnerSouth.removeAt(index);
            //                     DinnerSouthnameTEC.removeAt(index);
            //                     DinnerSouthpriceTEC.removeAt(index);
            //                     DinnerSouthitemImages.removeAt(index);
            //                   });
            //                 },
            //               ),
            //             )
            //           ],
            //         );
            //       },
            //     ),
            //     SizedBox(height: 26),
            //     SizedBox(height: 10),
            //     Padding(
            //       padding: const EdgeInsets.all(10.0),
            //       child: Row(
            //         children: [
            //           GestureDetector(
            //             onTap: () {
            //               setState(() {
            //                 rowsDinnerSouth.add(createRow(
            //                     name: DinnerSouthnameTEC,
            //                     price: DinnerSouthpriceTEC,
            //                     itemImages: DinnerSouthitemImages));
            //               });
            //             },
            //             child: Container(
            //               decoration: BoxDecoration(
            //                   color: AppConstant.appColor,
            //                   borderRadius: BorderRadius.circular(12)),
            //               child: Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Icon(
            //                   Icons.add,
            //                   color: Colors.white,
            //                 ),
            //               ),
            //             ),
            //           ),
            //           SizedBox(width: 20),
            //           Text('Add another menu'),
            //         ],
            //       ),
            //     ),
            //     SizedBox(height: 10),
            //     Center(
            //       child: InkWell(
            //         onTap: () {
            //           _onDoneDinner(
            //               cuisinetype: '0',
            //               rowsData: rowsDinnerSouth,
            //               nameValidation: DinnerSouthnameTEC,
            //               priceValidation: DinnerSouthpriceTEC,
            //               imageValidation: DinnerSouthitemImages);
            //         },
            //         child: Container(
            //           height: 40,
            //           width: 150,
            //           decoration: BoxDecoration(
            //             color: AppConstant.appColor,
            //             borderRadius: BorderRadius.circular(100),
            //           ),
            //           child: Center(
            //             child: Padding(
            //                 padding: EdgeInsets.all(12),
            //                 child: Text(
            //                   "Add Dinner",
            //                   style: TextStyle(color: Colors.white),
            //                 )),
            //           ),
            //         ),
            //       ),
            //     ),
            //     SizedBox(height: 16),
            //   ],
            // ),
            // SizedBox(height: 15),
            // ExpansionTile(
            //   onExpansionChanged: (bool val) {
            //     print(val);
            //     setState(() {
            //       isDinnerNorth = val;
            //     });
            //   },
            //   title: Text(
            //     'North Indian Meals',
            //     style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 14,
            //         fontFamily: AppConstant.fontRegular),
            //   ),
            //   trailing: Container(
            //     height: 30,
            //     width: 30,
            //     margin: EdgeInsets.only(right: 20, top: 10),
            //     child: CupertinoSwitch(
            //       activeColor: Color(0xff7EDABF),
            //       value: isDinnerNorth,
            //     ),
            //   ),
            //   children: <Widget>[
            //     SizedBox(height: 15),
            //     Container(
            //       height: 40,
            //       child: ListView.builder(
            //         itemCount: dinner.northIndian.length,
            //         itemBuilder: (context, index) {
            //           return InkWell(
            //             onTap: () {
            //               setState(() {
            //                 SelectDinnerCategory =
            //                     dinner.northIndian[index].category;
            //                 DinnerIndex = index;
            //               });
            //             },
            //             child: Container(
            //               height: 40,
            //               width: 110,
            //               margin: EdgeInsets.only(left: 16),
            //               decoration: BoxDecoration(
            //                   color: SelectDinnerCategory ==
            //                           dinner.northIndian[index].category
            //                       ? Color(0xffFFA451)
            //                       : Colors.grey.shade200,
            //                   borderRadius: BorderRadius.circular(10)),
            //               child: Center(
            //                 child: Text(
            //                   dinner.northIndian[index].category,
            //                   style: TextStyle(
            //                       color: SelectDinnerCategory ==
            //                               dinner.northIndian[index].category
            //                           ? Colors.white
            //                           : Colors.black,
            //                       fontSize: 14,
            //                       fontFamily: AppConstant.fontBold),
            //                 ),
            //               ),
            //             ),
            //           );
            //         },
            //         scrollDirection: Axis.horizontal,
            //       ),
            //     ),
            //     (SelectDinnerCategory ==
            //             dinner.northIndian[DinnerIndex].category)
            //         ? CategoryMenuItems(
            //             list: dinner.northIndian[DinnerIndex].list)
            //         : Container(),
            //     ListView.builder(
            //       shrinkWrap: true,
            //       physics: NeverScrollableScrollPhysics(),
            //       itemCount: rowsDinnerNorth.length,
            //       itemBuilder: (BuildContext context, int index) {
            //         return Row(
            //           children: [
            //             InkWell(
            //               onTap: () {
            //                 _showPicker(context, index, DinnerNorthitemImages);
            //               },
            //               child: Padding(
            //                   padding: EdgeInsets.only(top: 30, left: 6),
            //                   child: DinnerNorthitemImages.isEmpty
            //                       ? Image.asset(
            //                           Res.ic_poha,
            //                           width: 55,
            //                           height: 55,
            //                           fit: BoxFit.cover,
            //                         )
            //                       : DinnerNorthitemImages.elementAt(index) ==
            //                               null
            //                           ? Image.asset(
            //                               Res.ic_poha,
            //                               width: 55,
            //                               height: 55,
            //                               fit: BoxFit.cover,
            //                             )
            //                           : ClipRRect(
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               child: Image.file(
            //                                 DinnerNorthitemImages.elementAt(
            //                                     index),
            //                                 width: 55,
            //                                 height: 55,
            //                                 fit: BoxFit.cover,
            //                               ),
            //                             )),
            //             ),
            //             rowsDinnerNorth[index],
            //             Padding(
            //               padding: const EdgeInsets.only(top: 25.0),
            //               child: IconButton(
            //                 icon: Icon(Icons.delete),
            //                 onPressed: () {
            //                   setState(() {
            //                     rowsDinnerNorth.removeAt(index);
            //                     DinnerNorthnameTEC.removeAt(index);
            //                     DinnerNorthpriceTEC.removeAt(index);
            //                     DinnerNorthitemImages.removeAt(index);
            //                   });
            //                 },
            //               ),
            //             )
            //           ],
            //         );
            //       },
            //     ),
            //     SizedBox(height: 26),
            //     SizedBox(height: 10),
            //     Padding(
            //       padding: const EdgeInsets.all(10.0),
            //       child: Row(
            //         children: [
            //           GestureDetector(
            //             onTap: () {
            //               setState(() {
            //                 rowsDinnerNorth.add(createRow(
            //                     name: DinnerNorthnameTEC,
            //                     price: DinnerNorthpriceTEC,
            //                     itemImages: DinnerNorthitemImages));
            //               });
            //             },
            //             child: Container(
            //               decoration: BoxDecoration(
            //                   color: AppConstant.appColor,
            //                   borderRadius: BorderRadius.circular(12)),
            //               child: Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Icon(
            //                   Icons.add,
            //                   color: Colors.white,
            //                 ),
            //               ),
            //             ),
            //           ),
            //           SizedBox(width: 20),
            //           Text('Add another menu'),
            //         ],
            //       ),
            //     ),
            //     SizedBox(height: 10),
            //     Center(
            //       child: InkWell(
            //         onTap: () {
            //           _onDoneDinner(
            //               cuisinetype: '1',
            //               rowsData: rowsDinnerNorth,
            //               nameValidation: DinnerNorthnameTEC,
            //               priceValidation: DinnerNorthpriceTEC,
            //               imageValidation: DinnerNorthitemImages);
            //         },
            //         child: Container(
            //           height: 40,
            //           width: 150,
            //           decoration: BoxDecoration(
            //             color: AppConstant.appColor,
            //             borderRadius: BorderRadius.circular(100),
            //           ),
            //           child: Center(
            //             child: Padding(
            //                 padding: EdgeInsets.all(12),
            //                 child: Text(
            //                   "Add Dinner",
            //                   style: TextStyle(color: Colors.white),
            //                 )),
            //           ),
            //         ),
            //       ),
            //     ),
            //     SizedBox(height: 16),
            //   ],
            // ),
            // SizedBox(height: 15),
            // ExpansionTile(
            //   onExpansionChanged: (bool val) {
            //     print(val);
            //     setState(() {
            //       isDinnerOther = val;
            //     });
            //   },
            //   title: Text(
            //     'Other Indian Meals',
            //     style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 14,
            //         fontFamily: AppConstant.fontRegular),
            //   ),
            //   trailing: Container(
            //     height: 30,
            //     width: 30,
            //     margin: EdgeInsets.only(right: 20, top: 10),
            //     child: CupertinoSwitch(
            //       activeColor: Color(0xff7EDABF),
            //       value: isDinnerOther,
            //     ),
            //   ),
            //   children: <Widget>[
            //     SizedBox(height: 15),
            //     Container(
            //       height: 40,
            //       child: ListView.builder(
            //         itemCount: dinner.otherIndian.length,
            //         itemBuilder: (context, index) {
            //           return InkWell(
            //             onTap: () {
            //               setState(() {
            //                 SelectDinnerCategory =
            //                     dinner.otherIndian[index].category;
            //                 DinnerIndex = index;
            //               });
            //             },
            //             child: Container(
            //               height: 40,
            //               width: 110,
            //               margin: EdgeInsets.only(left: 16),
            //               decoration: BoxDecoration(
            //                   color: SelectDinnerCategory ==
            //                           dinner.otherIndian[index].category
            //                       ? Color(0xffFFA451)
            //                       : Colors.grey.shade200,
            //                   borderRadius: BorderRadius.circular(10)),
            //               child: Center(
            //                 child: Text(
            //                   dinner.otherIndian[index].category,
            //                   style: TextStyle(
            //                       color: SelectDinnerCategory ==
            //                               dinner.otherIndian[index].category
            //                           ? Colors.white
            //                           : Colors.black,
            //                       fontSize: 14,
            //                       fontFamily: AppConstant.fontBold),
            //                 ),
            //               ),
            //             ),
            //           );
            //         },
            //         scrollDirection: Axis.horizontal,
            //       ),
            //     ),
            //     (SelectDinnerCategory ==
            //             dinner.otherIndian[DinnerIndex].category)
            //         ? CategoryMenuItems(
            //             list: dinner.otherIndian[DinnerIndex].list)
            //         : Container(),
            //     ListView.builder(
            //       shrinkWrap: true,
            //       physics: NeverScrollableScrollPhysics(),
            //       itemCount: rowsDinnerOther.length,
            //       itemBuilder: (BuildContext context, int index) {
            //         return Row(
            //           children: [
            //             InkWell(
            //               onTap: () {
            //                 _showPicker(context, index, DinnerOtheritemImages);
            //               },
            //               child: Padding(
            //                   padding: EdgeInsets.only(top: 30, left: 6),
            //                   child: DinnerOtheritemImages.isEmpty
            //                       ? Image.asset(
            //                           Res.ic_poha,
            //                           width: 55,
            //                           height: 55,
            //                           fit: BoxFit.cover,
            //                         )
            //                       : DinnerOtheritemImages.elementAt(index) ==
            //                               null
            //                           ? Image.asset(
            //                               Res.ic_poha,
            //                               width: 55,
            //                               height: 55,
            //                               fit: BoxFit.cover,
            //                             )
            //                           : ClipRRect(
            //                               borderRadius:
            //                                   BorderRadius.circular(8),
            //                               child: Image.file(
            //                                 DinnerOtheritemImages.elementAt(
            //                                     index),
            //                                 width: 55,
            //                                 height: 55,
            //                                 fit: BoxFit.cover,
            //                               ),
            //                             )),
            //             ),
            //             rowsDinnerOther[index],
            //             Padding(
            //               padding: const EdgeInsets.only(top: 25.0),
            //               child: IconButton(
            //                 icon: Icon(Icons.delete),
            //                 onPressed: () {
            //                   setState(() {
            //                     rowsDinnerOther.removeAt(index);
            //                     DinnerOthernameTEC.removeAt(index);
            //                     DinnerOtherpriceTEC.removeAt(index);
            //                     DinnerOtheritemImages.removeAt(index);
            //                   });
            //                 },
            //               ),
            //             )
            //           ],
            //         );
            //       },
            //     ),
            //     SizedBox(height: 26),
            //     SizedBox(height: 10),
            //     Padding(
            //       padding: const EdgeInsets.all(10.0),
            //       child: Row(
            //         children: [
            //           GestureDetector(
            //             onTap: () {
            //               setState(() {
            //                 rowsDinnerOther.add(createRow(
            //                     name: DinnerOthernameTEC,
            //                     price: DinnerOtherpriceTEC,
            //                     itemImages: DinnerOtheritemImages));
            //               });
            //             },
            //             child: Container(
            //               decoration: BoxDecoration(
            //                   color: AppConstant.appColor,
            //                   borderRadius: BorderRadius.circular(12)),
            //               child: Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Icon(
            //                   Icons.add,
            //                   color: Colors.white,
            //                 ),
            //               ),
            //             ),
            //           ),
            //           SizedBox(width: 20),
            //           Text('Add another menu'),
            //         ],
            //       ),
            //     ),
            //     SizedBox(height: 10),
            //     Center(
            //       child: InkWell(
            //         onTap: () {
            //           _onDoneDinner(
            //               cuisinetype: '2',
            //               rowsData: rowsDinnerOther,
            //               nameValidation: DinnerOthernameTEC,
            //               priceValidation: DinnerOtherpriceTEC,
            //               imageValidation: DinnerOtheritemImages);
            //         },
            //         child: Container(
            //           height: 40,
            //           width: 150,
            //           decoration: BoxDecoration(
            //             color: AppConstant.appColor,
            //             borderRadius: BorderRadius.circular(100),
            //           ),
            //           child: Center(
            //             child: Padding(
            //                 padding: EdgeInsets.all(12),
            //                 child: Text(
            //                   "Add Dinner",
            //                   style: TextStyle(color: Colors.white),
            //                 )),
            //           ),
            //         ),
            //       ),
            //     ),
            //     SizedBox(height: 16),
            //   ],
            // ),
            // Divider(height: 20, thickness: 5, color: Colors.grey.shade100),

            SizedBox(height: 10),
            InkWell(
              onTap: () {
                getAllMenu().then((value) {
                  setState(() {
                    isReplaceThree = true;
                    isReplaceOne = false;
                    isReplaceTwo = false;
                  });
                });
              },
              child: Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 15),
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xffFFA451),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Save Menu",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: AppConstant.fontBold),
                    ),
                  )),
            ),
            AppConstant().navBarHt()
          ],
        ),
      ),
    );
  }

  replaceDefaultScreen() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: Image.asset(
                        Res.ic_default_menu,
                        width: 220,
                        height: 120,
                      ),
                    )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      "No menu added yet",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "look's like you, haven't\n made your menu yet.",
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: AppConstant.fontRegular,
                          fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isReplaceTwo = true;
                          isReplaceOne = false;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Color(0xffFFA451),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2, color: Colors.grey.shade300)
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Add menu",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: AppConstant.fontBold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          physics: BouncingScrollPhysics(),
        ));
  }

  replaceSaveMenu() {
    return Column(
      children: [
        Container(
          color: Colors.white,
          height: 90,
          child: DefaultTabController(
            length: 2,
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        color: Colors.white,
                        child: TabBar(
                          labelStyle: TextStyle(
                              fontFamily: AppConstant.fontBold, fontSize: 16),
                          unselectedLabelColor: Colors.black,
                          labelColor: Colors.black,
                          indicatorColor: AppConstant.appColor,
                          indicatorWeight: 5,
                          isScrollable: false,
                          controller: _controller,
                          tabs: [
                            Tab(text: 'BreakFast'),
                            Tab(text: 'Lunch & Dinner'),
                            // Tab(text: 'Dinner'),
                            // Tab(text: 'Dinner'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: TabBarView(
              controller: _controller,
              children: <Widget>[
                // Breakfast
                breakfast == null
                    ? Container(height: 100, width: 200)
                    : getItem(breakfast, true),
                lunch == null
                    ? Container(height: 100, width: 200)
                    : getItem(lunch, false),

                // dinner == null
                //     ? Container(height: 100, width: 200)
                //     : getItem(dinner),
              ],
            ),
          ),
        ),
        AppConstant().navBarHt()
      ],
    );
  }

  getItem(BreakfastModelData breakfast, bool isbreakfast) {
    return ListView(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // South Indian Meals--------------------------------->
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            categories[0],
            style: TextStyle(fontFamily: AppConstant.fontBold, fontSize: 15),
          ),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: breakfast.southIndian.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Image.asset(
                        Res.ic_veg,
                        width: 15,
                        height: 16,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(breakfast.southIndian[index].category,
                        style: TextStyle(
                            color: AppConstant.appColor,
                            fontFamily: AppConstant.fontBold)),
                  ],
                ),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, ind) {
                    return getListFood(
                        breakfast.southIndian[index].list[ind], isbreakfast);
                  },
                  itemCount: breakfast.southIndian[index].list.length,
                ),
                SizedBox(height: 25),
              ],
            );
          },
        ),
        Divider(color: Colors.grey.shade400),

        // North Indian Meals--------------------------------->
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            categories[1],
            style: TextStyle(fontFamily: AppConstant.fontBold, fontSize: 15),
          ),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: breakfast.northIndian.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Image.asset(
                        Res.ic_veg,
                        width: 15,
                        height: 16,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(breakfast.northIndian[index].category,
                        style: TextStyle(
                            color: AppConstant.appColor,
                            fontFamily: AppConstant.fontBold)),
                  ],
                ),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, ind) {
                    return getListFood(
                        breakfast.northIndian[index].list[ind], isbreakfast);
                  },
                  itemCount: breakfast.northIndian[index].list.length,
                ),
                SizedBox(height: 25),
              ],
            );
          },
        ),
        Divider(color: Colors.grey.shade400),

        // Other Indian Meals--------------------------------->
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            categories[2],
            style: TextStyle(fontFamily: AppConstant.fontBold, fontSize: 15),
          ),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: breakfast.otherIndian.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Image.asset(
                        Res.ic_veg,
                        width: 15,
                        height: 16,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(breakfast.otherIndian[index].category,
                        style: TextStyle(
                            color: AppConstant.appColor,
                            fontFamily: AppConstant.fontBold)),
                  ],
                ),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, ind) {
                    return getListFood(
                        breakfast.otherIndian[index].list[ind], isbreakfast);
                  },
                  itemCount: breakfast.otherIndian[index].list.length,
                ),
                SizedBox(height: 25),
              ],
            );
          },
        ),
      ],
    );
  }

  getListFood(ListElement element, bool isbreakfast) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 16,
          ),
          Image.network(
            element.image,
            width: 55,
            height: 55,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  child: Text(
                    element.itemname,
                    style: TextStyle(
                        fontFamily: AppConstant.fontBold, color: Colors.black),
                  ),
                  padding: EdgeInsets.only(left: 16),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(AppConstant.rupee + element.itemprice,
                      style: TextStyle(
                          fontFamily: AppConstant.fontBold,
                          color: Color(0xff7EDABF))),
                ),
                (isbreakfast)
                    ? SizedBox()
                    : (element.menutype == '1')
                        ? Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              'Lunch',
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                        : (element.menutype == '2')
                            ? Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  'Dinner',
                                  style: TextStyle(fontSize: 12),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  'Lunch & Dinner',
                                  style: TextStyle(fontSize: 12),
                                ),
                              )
              ],
            ),
          ),
          Container(
            height: 30,
            width: 30,
            margin: EdgeInsets.only(right: 20, top: 10),
            child: CupertinoSwitch(
              activeColor: Color(0xff7EDABF),
              value: (element.instock == '0') ? false : true,
              onChanged: (newValue) {
                print(_controller.index.toString());
                getMealScreenItems(element.menuId, element.instock);
                // setState(() {
                //   _isSounIndianMeal = newValue;
                //   if (_isSounIndianMeal == true) {
                //   } else {}
                // });
              },
            ),
          )
        ],
      ),
    );
  }

  Future<BeanUpdateMenuStock> getMealScreenItems(
      String menuId, String inStock) async {
    _progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId,
        "token": "123456789",
        "menu_id": menuId,
        "instock": (inStock == '0') ? '1' : '0',
      });
      BeanUpdateMenuStock bean = await ApiProvider().updateMenuStock(from);
      print(bean.data);
      //progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          (_controller.index == 0)
              ? getBreakFastMenu()
              : (_controller.index == 1)
                  ? getMenuLunch()
                  : getMenuDinner();
        });
        _progressDialog.dismiss();
        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      _progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      _progressDialog.dismiss();
      print(exception);
    }
  }

  visileMenuheader() {
    if (flag == 0) {
      return Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                    Image.asset(
                      Res.ic_chef,
                      width: 65,
                      height: 65,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16, top: 50),
                          child: Text(
                            userBean.data.kitchenname,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: AppConstant.fontBold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            "Finest multi-cusine",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: AppConstant.fontRegular),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                (isSelected == 1)
                    ? IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isReplaceOne = false;
                            isReplaceTwo = true;
                            isReplaceThree = false;
                          });
                        },
                      )
                    : Container(),
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
                          isReplaceOne = true;
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
                            "Menu",
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
                            "Packages",
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
        ],
      );
    } else {
      return Container();
    }
  }

  void getBreakFastMenu() async {
    var map = FormData.fromMap(
      {"token": "123456789", "kitchen_id": userId},
    );
    BreakfastModel menuBean = await ApiProvider().getMenu(map);
    if (menuBean.status) {
      //Log.info(menuBean.data.southindian.breakfast.mealName);
      setState(() {
        breakfast = menuBean.data;
      });
    } else {
      Utils.showToast(menuBean.message);
    }
  }

  void getMenuLunch() async {
    _progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId,
        "token": "123456789",
      });
      BreakfastModel bean = await ApiProvider().beanGetLunch(from);
      if (bean.status == true) {
        //other.add(bean.data.otherIndian);
        setState(() {
          lunch = bean.data;
        });
        _progressDialog.dismiss();
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      print(exception);
      _progressDialog.dismiss();
    } catch (exception) {
      print(exception);
      _progressDialog.dismiss();
    }
  }

  void getMenuDinner() async {
    //_progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId,
        "token": "123456789",
      });
      BreakfastModel bean = await ApiProvider().beanGetDinner(from);
      if (bean.status) {
        //other.add(bean.data.otherIndian);
        setState(() {
          dinner = bean.data;
        });
        //_progressDialog.dismiss();
      } else {
        //_progressDialog.dismiss();
      }

      return null;
    } on HttpException catch (exception) {
      print(exception);
    } catch (exception) {
      print(exception);
    }
  }

  _showPicker(context, int index, List<File> itemImages) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery(index, itemImages);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera(index, itemImages);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _showPickerLunch(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGalleryLunch();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCameraLunch();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  showPickerDinner(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGalleryDinner();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCameraDinner();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera(int index, List<File> itemImages) async {
    // DecorationImage image = DecorationImage(image: ImageSource.camera as ImageProvider,filterQuality:FilterQuality.medium);
    XFile image = await ImagePicker().pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = File(image.path);
      itemImages.insert(index, File(image.path));
    });
  }

  _imgFromGallery(int index, List<File> itemImages) async {
    print(index.toString() + "");
    // DecorationImage image = DecorationImage(image: ImageSource.camera as ImageProvider,filterQuality:FilterQuality.medium);
    XFile image = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      itemImages.insert(index, File(image.path));
    });
  }

  _imgFromCameraLunch() async {
    // DecorationImage image = DecorationImage(image: ImageSource.camera as ImageProvider,filterQuality:FilterQuality.medium);
    XFile image = await ImagePicker().pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _imageLunch = File(image.path);
    });
  }

  _imgFromGalleryDinner() async {
    // DecorationImage image = DecorationImage(image: ImageSource.camera as ImageProvider,filterQuality:FilterQuality.medium);
    XFile image = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _imageDinner = File(image.path);
    });
  }

  _imgFromCameraDinner() async {
    // DecorationImage image = DecorationImage(image: ImageSource.camera as ImageProvider,filterQuality:FilterQuality.medium);
    XFile image = await ImagePicker().pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _imageDinner = File(image.path);
    });
  }

  _imgFromGalleryLunch() async {
    // DecorationImage image = DecorationImage(image: ImageSource.camera as ImageProvider,filterQuality:FilterQuality.medium);
    XFile image = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _imageLunch = File(image.path);
    });
  }
}

class UserEntry {
  final String name;
  final String price;
  final File image;

  UserEntry(this.name, this.price, this.image);
}
