import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:kitchen/model/rearrageCategory.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';

import '../model/GetCategories.dart';

class ArrangeCategoryScreen extends StatefulWidget {
  ArrangeCategoryScreen();
  @override
  _ArrangeCategoryScreenState createState() => _ArrangeCategoryScreenState();
}

class _ArrangeCategoryScreenState extends State<ArrangeCategoryScreen> {
  List<Data> categoryItems;
  List<int> _items;
  ProgressDialog progressDialog;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getCategories(context);
    });
    super.initState();
  }
  Future<void> _pullRefresh ()   async {
    setState(() async {
      await Future.delayed(Duration.zero, () {
      getCategories(context);
    });
    });
  }
  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child:  new RefreshIndicator(
          onRefresh: _pullRefresh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 650, // Change as per your requirement
                  // width: 350.0,
                  child: _items != null ? ReorderableListView(
                    header: Container(
                      margin: EdgeInsets.only(top: 20),
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
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 16, top: 16),
                            child: Text(
                              "Re-Arrange Category",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: AppConstant.fontBold),
                            ),
                          ),
                        ],
                      ),
                      height: 70,
                    ),
                    primary: true,
                    footer: InkWell(
                      onTap: () {
                        rearrageCategory();
                      },
                      child: Container(
                        height: 55,
                        margin: EdgeInsets.only(
                            left: 16, right: 16, bottom: 16, top: 36),
                        decoration: BoxDecoration(
                            color: AppConstant.appColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "SAVE",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: AppConstant.fontBold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    clipBehavior: Clip.none,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    children: <Widget>[
                      for (int index = 0; index < _items.length; index += 1)
                        ListTile(
                          key: ValueKey('$index'),
                          tileColor: index.isOdd ? oddItemColor : evenItemColor,
                          title: Text(
                              '${categoryItems.where((element) => int.parse(element.categoryId) == _items[index]).first.categoryName}'),
                        ),
                    ],
                    onReorder: reorderData,
                  ) : Container(),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
          physics: BouncingScrollPhysics(),
        ));
  }

  void reorderData(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      int item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
  }

  Future<GetCategories> getCategories(BuildContext context) async {
    progressDialog.show();
    var user = await Utils.getUser();
    var id = user.data.id;
    try {
      FormData from =
          FormData.fromMap({"kitchen_id": id, "token": "123456789"});
      GetCategories bean = await ApiProvider().getCategories(from);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          categoryItems = bean.data;
          _items = categoryItems
              .map<int>((row) => int.parse(row.categoryId))
              .toList();
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

  void validaton() {
    // var title = categoryTitle.text.toString();
    // var descriptionText = description.text.toString();
    // if (title.isEmpty) {
    //   Utils.showToast("Enter Category Title");
    // }  else {
    //   if(descriptionText.isEmpty)
    //   {
    //     descriptionText = " ";
    //   }
    //   addCategory(title, descriptionText);
    // }
  }

  void rearrageCategory() async {
    progressDialog.show();

    var userBean = await Utils.getUser();

    var id = userBean.data.id;
    try {
      FormData data;
      data = FormData.fromMap({
        "kitchen_id": id,
        "category_ids": jsonEncode(_items),
        "token": "123456789",
      });
      RearrangeCategory bean = await ApiProvider().reArrangeCategory(data);
      progressDialog.dismiss();
      if (bean.status == true) {
        Utils.showToast(bean.message);
        Navigator.pop(context, true);
      } else {
        Utils.showToast(bean.message);
      }
    } on HttpException catch (exception) {
      progressDialog.dismiss();
    } catch (exception) {
      progressDialog.dismiss();
    }
  }
}
