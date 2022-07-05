import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/model/GetCategories.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/screen/AddMenuCategory.dart';
import 'package:kitchen/screen/ArrangeCategory.dart';
import 'package:kitchen/screen/CategoryItems.dart';
import 'package:kitchen/screen/EditMenuCategory.dart';
import 'package:kitchen/screen/HomeBaseScreen.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MenuCategoryScreen extends StatefulWidget {
  @override
  _MenuCategoryScreenState createState() => _MenuCategoryScreenState();
}

class _MenuCategoryScreenState extends State<MenuCategoryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<GetCategories> _future;
  List<Data> categoryItems;
  List<int> _items;
  ProgressDialog progressDialog;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _future = getCategories(context);
    });
    super.initState();
  }
  Future<void> _pullRefresh ()   async {
    setState(() async {
      await  Future.delayed(Duration.zero, () {
      _future = getCategories(context);
    });
    });
  }
  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog((context));
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    return Scaffold(
        drawer: MyDrawers(),
        key: _scaffoldKey,
        backgroundColor: AppConstant.appColor,
        body: new RefreshIndicator(
          onRefresh: _pullRefresh,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
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
                              "Master Menu",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: AppConstant.fontBold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 10, bottom: 10, top: 10, right: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 12),primary: AppConstant.lightGreen),
                          onPressed: () {
                            arrangeCategory();
                          },
                          child: const Text('Re-Arrange Category',style: TextStyle(color: Colors.black),),
                        ),
                      ),
                    ],
                  ),
                  height: 100,
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
            FutureBuilder<GetCategories>(
                future: _future,
                builder: (context, projectSnap) {
                  print(projectSnap);
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
                            return getCategoriesWidget(result[index]);
                          },
                          itemCount: result.length,
                        );
                      }
                    }
                  }
                  return Container(
                      child: Center(
                    child: Text(
                      "No Active Categories Found",
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
                          addcategory();
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

  reArrange(context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Container(
      height: 300.0, // Change as per your requirement
      width: 260.0,
      child: ReorderableListView(
        padding: const EdgeInsets.symmetric(horizontal: 0),
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
      ),
    );
  }

  void reorderData(int oldIndex, int newIndex) {
    print("$_items AAAAA");
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      int item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
  }

  getCategoriesWidget(result) {
    return Container(
      margin: EdgeInsets.only(left: 10, bottom: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                child: Center(
                  child: Text(
                    result.categoryName,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: AppConstant.fontBold,
                        fontSize: 18),
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      editCategory(result.categoryId);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => EditMenuCategoryScreen(categoryId :result.categoryId)));
                    },
                    icon: Icon(Icons.edit),
                    color: Colors.blue,
                  ),
                  IconButton(
                    onPressed: () async {
                      var user = await Utils.getUser();
                      var id = user.data.id;
                      ApiProvider()
                          .deleteCategory(FormData.fromMap({
                        'token': '123456789',
                        'kitchen_id': id,
                        'category_id': result.categoryId
                      }))
                          .then((value) {
                        setState(() {
                          _future = getCategories(context);
                        });
                      });
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryItemsScreen(
                                  categoryId: result.categoryId)));
                    },
                    icon: Icon(Icons.remove_red_eye),
                    color: AppConstant.appColor,
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
                    result.description,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            thickness: 2,
            color: AppConstant.appColor,
          ),
        ],
      ),
    );
  }

  Future<GetCategories> getCategories(BuildContext context) async {
    progressDialog.show();
    var user = await Utils.getUser();
    var id = user.data.id;
    try {
      FormData from =
          FormData.fromMap({"kitchen_id": id, "token": "123456789"});
      GetCategories bean = await ApiProvider().getCategories(from);
      print(bean.data);
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

  addcategory() async {
    var data = await pushNewScreen(context,
        screen: AddMenuCategoryScreen(), withNavBar: false);
    if (data != null) {
      _future = getCategories(context);
    }
    print('io');
  }

  editCategory(categoryId) async {
    var data = await pushNewScreen(context,
        screen: EditMenuCategoryScreen(
          categoryId: categoryId,
        ),
        withNavBar: false);
    if (data != null) {
      _future = getCategories(context);
    }
    print('io');
  }

  arrangeCategory() async {
    var data = await pushNewScreen(context,
        screen: ArrangeCategoryScreen(), withNavBar: false);
    if (data != null) {
      _future = getCategories(context);
    }
    print('io');
  }
}
