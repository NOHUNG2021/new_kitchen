import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:kitchen/Menu/BasePackagescreen.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/screen/HomeBaseScreen.dart';
import 'package:kitchen/utils/Constents.dart';

class PackageScreen extends StatefulWidget {
  @override
  _PackageScreenState createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var isSelected = 1;
  var isSelectMenu = 1;
  var isSelectFood = 2;
  var isMealType = 1;
  var isSelectedNorth = 1;
  bool isMenu = true;
  bool saveMenuSelected = false;
  bool addMenu = false;
  TabController _controller;
  var _isOnSubscription = false;
  var _isSounIndianMeal = false;
  var _isNorthIndianist = false;
  var _other = false;
  var _other2 = false;
  var addDefaultIcon = true;
  var addPack = false;
  var setMenuPackage = false;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        drawer: MyDrawers(),
        backgroundColor: AppConstant.appColor,
        key: _scaffoldKey,
        body: Stack(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 120),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(38),
                          topLeft: Radius.circular(38))),
                  height: double.infinity,
                  child: method()),
              Column(
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
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16, top: 60),
                              child: Text(
                                "Package",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: AppConstant.fontBold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    height: 150,
                  ),
                ] ),
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

  method() {
    return BasePackagescreen();
      
  }


  saveMenu() {
    return Visibility(
        visible: saveMenuSelected,
        child: Column(
          children: [
            Container(
              height: 100,
              child: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(0.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            child: Container(
                              child: TabBar(
                                unselectedLabelColor: Colors.black,
                                labelColor: Colors.black,
                                indicatorColor: AppConstant.appColor,
                                isScrollable: false,
                                controller: _controller,
                                tabs: [
                                  Tab(text: 'BreakFast'),
                                  Tab(text: 'Lunch & Dinner Meals'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  controller: _controller,
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return getItem();
                      },
                      itemCount: 15,
                    ),
                    Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16, top: 16),
                                  child: Text(
                                    'South Indian Meals',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: AppConstant.fontRegular),
                                  ),
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 30,
                                margin: EdgeInsets.only(right: 20, top: 10),
                                child: CupertinoSwitch(
                                  activeColor: Color(0xff7EDABF),
                                  value: _isOnSubscription,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _isOnSubscription = newValue;
                                      if (_isOnSubscription == true) {
                                      } else {}
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16, top: 16),
                                  child: Text(
                                    'North Indian Meals',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: AppConstant.fontRegular),
                                  ),
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 30,
                                margin: EdgeInsets.only(right: 20, top: 10),
                                child: CupertinoSwitch(
                                  activeColor: Color(0xff7EDABF),
                                  value: _isNorthIndianist,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _isNorthIndianist = newValue;
                                      if (_isNorthIndianist == true) {
                                      } else {}
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GetLunchDinnerList();
                            },
                            itemCount: 15,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  addPackages() {
    return SingleChildScrollView(
      child: Visibility(
        visible: addPack,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                "Packages Name",
                style: TextStyle(
                    color: AppConstant.appColor,
                    fontFamily: AppConstant.fontRegular),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: TextField(
                  decoration: InputDecoration(hintText: "Package 1"),
                )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                "Type of Cuisine",
                style: TextStyle(
                    color: Colors.black, fontFamily: AppConstant.fontRegular),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isSelectFood = 1;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 110,
                    margin: EdgeInsets.only(left: 16, top: 16),
                    decoration: BoxDecoration(
                        color: isSelectFood == 1
                            ? Color(0xffFEDF7C)
                            : Color(0xffF3F6FA),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "South Indian",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isSelectFood = 2;
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 16, top: 16),
                      height: 50,
                      width: 110,
                      decoration: BoxDecoration(
                          color: isSelectFood == 2
                              ? Color(0xffFEDF7C)
                              : Color(0xffF3F6FA),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "North Indian",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: AppConstant.fontBold),
                        ),
                      )),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isSelectFood = 3;
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 16, top: 16),
                      height: 50,
                      width: 110,
                      decoration: BoxDecoration(
                          color: isSelectFood == 3
                              ? Color(0xffFEDF7C)
                              : Color(0xffF3F6FA),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Other",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: AppConstant.fontBold),
                        ),
                      )),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                "Meal Type",
                style: TextStyle(
                    color: Colors.black, fontFamily: AppConstant.fontRegular),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isMealType = 1;
                      });
                    },
                    child: Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        height: 45,
                        width: 110,
                        decoration: BoxDecoration(
                            color: isMealType == 1
                                ? Color(0xff7EDABF)
                                : Color(0xffF3F6FA),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Image.asset(
                              Res.ic_veg,
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Veg",
                              style: TextStyle(
                                  color: isMealType == 1
                                      ? Colors.white
                                      : Colors.black,
                                  fontFamily: AppConstant.fontBold),
                            )
                          ],
                        )),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isMealType = 2;
                      });
                    },
                    child: Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        height: 45,
                        width: 110,
                        decoration: BoxDecoration(
                            color: isMealType == 2
                                ? Color(0xff7EDABF)
                                : Color(0xffF3F6FA),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Image.asset(
                              Res.ic_chiken,
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Non Veg",
                              style: TextStyle(
                                  color: isMealType == 2
                                      ? Colors.white
                                      : Colors.black,
                                  fontFamily: AppConstant.fontBold),
                            )
                          ],
                        )),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 26),
              child: Text(
                "Start Date",
                style: TextStyle(
                    color: AppConstant.appColor,
                    fontFamily: AppConstant.fontBold),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "1/1/2020"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Image.asset(
                    Res.ic_calendar,
                    width: 20,
                    height: 20,
                  ),
                )
              ],
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        'Including Saturday',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    margin: EdgeInsets.only(right: 20, top: 10),
                    child: CupertinoSwitch(
                      activeColor: Color(0xff7EDABF),
                      value: _other2,
                      onChanged: (newValue) {
                        setState(() {
                          _other2 = newValue;
                          if (_other2 == true) {
                          } else {}
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        'Including Saturday',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    margin: EdgeInsets.only(right: 20, top: 10),
                    child: CupertinoSwitch(
                      activeColor: Color(0xff7EDABF),
                      value: _other2,
                      onChanged: (newValue) {
                        setState(() {
                          _other2 = newValue;
                          if (_other2 == true) {
                          } else {}
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 80,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  addDefaultIcon = false;
                  addPack = false;
                  setMenuPackage = true;
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "SET MENU",
                    style: TextStyle(
                        color: Colors.white, fontFamily: AppConstant.fontBold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  setMenuPackages() {
    return SingleChildScrollView(
      child: Visibility(
        visible: setMenuPackage,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 16, top: 16),
              height: 60,
              child: Row(
                children: [
                  Text(
                    "Lunch",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: AppConstant.fontBold,
                        fontSize: 16),
                  ),
                  VerticalDivider(
                    color: Colors.grey,
                    width: 20,
                  ),
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
                  Text(
                    "Veg",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: AppConstant.fontBold,
                        fontSize: 16),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  VerticalDivider(color: Colors.grey, width: 20),
                  Text(
                    "North Indian Meals",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: AppConstant.fontBold,
                        fontSize: 16),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Divider(
              color: Colors.grey.shade400,
            ),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return getList(choices[index]);
              },
              itemCount: choices.length,
            ),
            SizedBox(
              height: 90,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  addDefaultIcon = false;
                  addPack = false;
                  setMenuPackage = true;
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "SET Price",
                    style: TextStyle(
                        color: Colors.white, fontFamily: AppConstant.fontBold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getList(Choice choic) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                choic.title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: AppConstant.fontBold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 36),
              child: Image.asset(
                Res.ic_poha,
                width: 55,
                height: 55,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Text(
                "Mutter pAneer+3 Roti\n+Dal Fry+Rice+Salad",
                style: TextStyle(
                    color: Color(0xff707070),
                    fontSize: 14,
                    fontFamily: AppConstant.fontRegular),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(right: 10),
              width: 50,
              decoration: BoxDecoration(
                  color: AppConstant.appColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Image.asset(
                  Res.ic_plus,
                  width: 15,
                  height: 15,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  getItem() {
    return Column(
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
            SizedBox(
              height: 16,
            ),
            Expanded(
                child: Text("Veg",
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: AppConstant.fontRegular))),
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Text(
                "inStock",
                style: TextStyle(
                    color: Colors.grey, fontFamily: AppConstant.fontRegular),
              ),
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return getListFood();
          },
          itemCount: 15,
        )
      ],
    );
  }

  Widget getListFood() {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 16,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  Image.asset(
                    Res.ic_idle,
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
                            "Poha",
                            style: TextStyle(
                                fontFamily: AppConstant.fontBold,
                                color: Colors.black),
                          ),
                          padding: EdgeInsets.only(left: 16),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(AppConstant.rupee + "124",
                              style: TextStyle(
                                  fontFamily: AppConstant.fontBold,
                                  color: Color(0xff7EDABF))),
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
                      value: _isSounIndianMeal,
                      onChanged: (newValue) {
                        setState(() {
                          _isSounIndianMeal = newValue;
                          if (_isSounIndianMeal == true) {
                          } else {}
                        });
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }

  GetLunchDinnerList() {
    return Column(
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
            SizedBox(
              height: 16,
            ),
            Text("Vegetable",
                style: TextStyle(
                    color: AppConstant.appColor,
                    fontFamily: AppConstant.fontRegular)),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return getListFood();
          },
          itemCount: 15,
        )
      ],
    );
  }
}

class Choice {
  Choice({this.title, this.image});

  String title;
  String image;
}

List<Choice> choices = <Choice>[
  Choice(title: 'Monday'),
  Choice(title: 'Tuesday'),
  Choice(title: 'Wednesday'),
  Choice(title: 'Thursday'),
  Choice(title: 'Friday'),
  Choice(title: 'Saturday'),
  Choice(title: 'Sunday'),
];
