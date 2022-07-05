import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/model/BeanLogin.dart';
import 'package:kitchen/model/GetCategoryDetails.dart';
import 'package:kitchen/model/GetCategoryItems.dart';
import 'package:kitchen/model/updateItemStock.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/screen/AddCategoryItem.dart';
import 'package:kitchen/screen/ArrangeCategoryItems.dart';
import 'package:kitchen/screen/EditCategoryItem.dart';
import 'package:kitchen/screen/HomeBaseScreen.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class CategoryItemsScreen extends StatefulWidget {
  var categoryId;
  CategoryItemsScreen({this.categoryId});
  @override
  _CategoryItemsScreenState createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future futureLive;
  ProgressDialog progressDialog;
  BeanLogin userBean;
  bool isPageLoading = true;
  UpdateItemStock bean;
  String categoryTitle = '';
  String description = '';
  var name = "";
  var menu = "";
  var userId = "";
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      futureLive = getCategoryItems(context);
    });
    getUser();
    super.initState();
  }

  void getUser() async {
    userBean = await Utils.getUser();
    name = userBean.data.kitchenname;
    menu = userBean.data.menufile;
    userId = userBean.data.id.toString();

    getCategoryDetail(context, widget.categoryId);
  }

  Future<GetCategoryDetails> getCategoryDetail(
      BuildContext context, String categoryId) async {
    // progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId,
        'category_id': categoryId,
        "token": "123456789"
      });
      GetCategoryDetails bean = await ApiProvider().getCategoryDetail(from);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          isPageLoading = false;
          categoryTitle = bean.data.categoryName;
          description = bean.data.description;
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
      // progressDialog.dismiss();
      print(exception);
    }
  }
  Future<void> _pullRefresh ()   async {
    setState(() async {
      await Future.delayed(Duration.zero, () {
      futureLive = getCategoryItems(context);
    });
    });
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
        body: new RefreshIndicator(
          onRefresh: _pullRefresh,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  child: Column(
                    children: [
                      Row(
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
                          Padding(
                            padding: EdgeInsets.only(left: 16, top: 10),
                            child: Text(
                              categoryTitle,
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
                      Padding(
                        padding: EdgeInsets.only(left: 16, top: 10),
                        child: Text(
                          description,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, bottom: 10, top: 10, right: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      textStyle: const TextStyle(fontSize: 10),primary: AppConstant.lightGreen),
                                  onPressed: () {
                                    arrangeCategoryItems();
                                  },
                                  child: const Text('Re-Arrange Category Items',style: TextStyle(color: Colors.black),),
                                ),
                              ),
                            ],
                          ),
                    ],
                  ),
                  height: 130,
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
    return Column(
      children: [
        Expanded(
            child: Stack(
          children: [
            FutureBuilder<GetCategoryItems>(
                future: futureLive,
                builder: (context, projectSnap) {
                  if (projectSnap.connectionState == ConnectionState.done) {
                    var result;
                    if (projectSnap.data != null) {
                      result = projectSnap.data.data;
                      if (result != null) {
                        return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return getCategoryItemsWidget(result[index]);
                          },
                          itemCount: result.length,
                        );
                      }
                    }
                  }
                  return Container(
                      child: Center(
                    child: Text(
                      "No Items Found",
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
                          addCategoryItems();
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
  }

  Future<void> updateItemInstockStatus(value, menuId) async {
    FormData form = FormData.fromMap({
      "token": "123456789",
      "instock": value ? "y" : "n",
      "kitchen_id": userBean.data.id.toString(),
      "category_id": widget.categoryId,
      "menu_id": menuId
    });
    bean = await ApiProvider().updateItemInstock(form);
    if (bean.status == true) {
      Utils.showToast(bean.message);
      setState(() {
        // isKitchenActive = value;
      });
    } else {
      Utils.showToast(bean.message);
    }
  }

  Future<GetCategoryItems> getCategoryItems(BuildContext context) async {
    progressDialog.show();
    var user = await Utils.getUser();
    var id = user.data.id;
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": id,
        "category_id": widget.categoryId,
        "token": "123456789"
      });
      GetCategoryItems bean = await ApiProvider().getCategoryItems(from);
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

  getCategoryItemsWidget(result) {
    String itemTypeModified;
    if (result.itemType == "nonveg") {
      itemTypeModified = "Non-Veg";
    } else if (result.itemType == "veg") {
      itemTypeModified = "Veg";
    } else {
      itemTypeModified = "Veg / Non-Veg";
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all( color: AppConstant.appColor),
                  color: Colors.white,
                      //result.itemType == "nonveg" ? Colors.brown : Colors.green,
                  borderRadius: BorderRadius.circular(5)),
              height: 30,
              child: Center(
                child: Row(
                  children: [

                        Image.asset(
                         result.itemType == "nonveg" ? Res.ic_chiken : Res.ic_veg,
                          width: 20,
                          height: 20,
                        ),
                    Text(
                      itemTypeModified,
                      style: TextStyle(
                          color: 
                               Colors.black,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  child: Switch(
                    value: result.instock == 'y' ? true : false,
                    onChanged: (value) {
                      updateItemInstockStatus(value, result.menuId);
                      setState(() {
                        result.instock = result.instock == 'y' ? 'n' : 'y';
                      });
                    },
                    activeColor: AppConstant.appColor,
                    activeTrackColor: AppConstant.appColorLite,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    editCategoryItems(result.menuId);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             EditCategoryItemScreen(categoryId: widget.categoryId,categoryItemId: result.menuId,)));
                  },
                  icon: Icon(Icons.edit),
                  color: Colors.blue,
                ),
                IconButton(
                  onPressed: () async {
                    var user = await Utils.getUser();
                    var id = user.data.id;
                    ApiProvider()
                        .deleteCategoryItem(FormData.fromMap({
                      'token': '123456789',
                      'kitchen_id': id,
                      'category_id': widget.categoryId,
                      'menu_id': result.menuId,
                    }))
                        .then((value) {
                      setState(() {
                        futureLive = getCategoryItems(context);
                      });
                    });
                  },
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                ),
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
                  result.itemName,
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
                  "₹ " + result.itemPrice,
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
            "Cuisine:- " + result.cuisineType.join(', '),
            style: TextStyle(
                color: Colors.grey,
                fontFamily: AppConstant.fontBold,
                fontSize: 12),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 5),
          child: Text(
            "Mealfor:- " + result.mealFor.join(', '),
            style: TextStyle(
                color: Colors.grey,
                fontFamily: AppConstant.fontBold,
                fontSize: 12),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 5),
          child: Text(
            "Description:- " + result.description,
            style: TextStyle(
                color: Colors.grey,
                fontFamily: AppConstant.fontBold,
                fontSize: 12),
            maxLines: 8,
            overflow: TextOverflow.visible,
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

  addCategoryItems() async {
    var data = await pushNewScreen(context,
        screen: AddCategoryItemScreen(
          categoryId: widget.categoryId,
        ),
        withNavBar: false);
    if (data != null) {
      futureLive = getCategoryItems(context);
    }
  }

  editCategoryItems(menuId) async {
    var data = await pushNewScreen(context,
        screen: EditCategoryItemScreen(
          categoryId: widget.categoryId,
          categoryItemId: menuId,
        ),
        withNavBar: false);
    if (data != null) {
      futureLive = getCategoryItems(context);
    }
  }

  arrangeCategoryItems() async {
    var data = await pushNewScreen(context,
        screen: ArrangeCategoryItemsScreen(
            categoryId: widget.categoryId, kitchenId: userId),
        withNavBar: false);
    if (data != null) {
      futureLive = getCategoryItems(context);
    }
  }
}
