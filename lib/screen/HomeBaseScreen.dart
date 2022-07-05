
import 'package:flutter/material.dart';
import 'package:kitchen/Menu/MenuDetailScreen.dart';
import 'package:kitchen/Order/OrderScreen.dart';
import 'package:kitchen/model/BeanLogin.dart';
import 'package:kitchen/payment/PaymentScreen.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/screen/AccountScreen.dart';
import 'package:kitchen/screen/CutomerChatScreen.dart';
import 'package:kitchen/screen/DashboardScreen.dart';
import 'package:kitchen/screen/FeedbackScreen.dart';
import 'package:kitchen/screen/MenuCategory.dart';
import 'package:kitchen/screen/OfferManagementScreen.dart';
import 'package:kitchen/screen/PackageScreen.dart';
import 'package:kitchen/screen/TrackDeliveryScreen.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/PrefManager.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBaseScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeBaseScreenState();
}

class HomeBaseScreenState extends State<HomeBaseScreen> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    DashboardScreen(),
    // MenuBaseScreen(0),
    MenuCategoryScreen(),
    OrderScreen(),
    MenuDetailScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  Future<bool> setpage(BuildContext) async {
    if (_controller.index == 0) {
      return true;
    } else {
      setState(() {
        _controller.index = 0;
      });
      return false;
    }
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        opacity: 0.8,
        icon: ImageIcon(
          AssetImage('assets/images/ic_dashboard.png'),
        ),
        title: ("Dashboard"),
        activeColorPrimary: AppConstant.appColor,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        opacity: 0.8,
        icon: ImageIcon(
          AssetImage(
            'assets/images/ic_menu_bottom.png',
          ),
        ),
        title: ("Menu"),
        activeColorPrimary: AppConstant.appColor,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        opacity: 0.8,
        icon: ImageIcon(
          AssetImage('assets/images/ic_order.png'),
        ),
        title: ("Orders"),
        activeColorPrimary: AppConstant.appColor,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        iconSize: 40,
        icon: ImageIcon(
          AssetImage('assets/images/ic_account.png'),
        ),
        opacity: 0.8,
        title: ("Account"),
        activeColorPrimary: AppConstant.appColor,
        inactiveColorPrimary: Colors.white,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,

        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        controller: _controller,
        screens: _children,

        items: _navBarsItems(),
        confineInSafeArea: true,
        navBarHeight: 65,
        backgroundColor: Colors.black, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            colorBehindNavBar: Colors.grey.shade200),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style3,
        onWillPop: setpage,
        // Choose the nav bar style with this property.
      ),
    );
  }
}

class MyDrawers extends StatefulWidget {
  @override
  MyDrawersState createState() => MyDrawersState();
}

class MyDrawersState extends State<MyDrawers> {
  BeanLogin userBean;
  var profileimage = '';
  var name = "";
  var address = "";

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userBean = await Utils.getUser();

    name = userBean.data.kitchenname;
    profileimage = prefs.getString('profile');
    address = userBean.data.address;
    setState(() {});
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: Container(
          width: 300,
          child: Drawer(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50, left: 15,bottom: 15),
                    child: (profileimage.isEmpty)
                        ? Image.asset(
                            Res.ic_chef,
                            width: 90,
                            height: 90,
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(profileimage),
                            radius: 50,
                          ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20, top: 16),
                      child: Text(
                        name,
                        style: TextStyle(
                            fontFamily: AppConstant.fontBold, fontSize: 18),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 20, top: 5),
                      child: Text(
                        address,
                        style: TextStyle(
                            fontFamily: AppConstant.fontRegular,
                            fontSize: 14,
                            color: Colors.grey),
                      )),
                  
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TrackDeliveryScreen()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, top: 15,bottom: 15),
                      child: Row(
                        children: [
                          Image.asset(
                            Res.ic_tracker,
                            color: Colors.grey,
                            width: 25,
                            height: 25,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 16, top: 5),
                              child: Text(
                                'TRACK DELIVERIES',
                                style: TextStyle(
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    color: Colors.black),
                              )),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OfferManagementScreen()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, top: 15,bottom: 15),
                      child: Row(
                        children: [
                          Image.asset(
                            Res.ic_discount,
                            color: Colors.grey,
                            width: 25,
                            height: 25,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 16, top: 5),
                              child: Text(
                                'OFFER MANAGEMENT',
                                style: TextStyle(
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    color: Colors.black),
                              )),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      pushNewScreen(context,
                          screen: FeedbackScreen(), withNavBar: false);
                      // Navigator.push<void>(
                      //   context,
                      //
                      //   MaterialPageRoute(builder: (_) => FeedbackScreen(),),
                      // );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, top: 15,bottom:15),
                      child: Row(
                        children: [
                          Image.asset(
                            Res.ic_feedback,
                            color: Colors.grey,
                            width: 25,
                            height: 25,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 16, top: 5),
                              child: Text(
                                'FEEDBACK/REVIEW',
                                style: TextStyle(
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    color: Colors.black),
                              )),
                        ],
                      ),
                    ),
                  ),
                  
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PackageScreen()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, top: 15,bottom: 15),
                      child: Row(
                        children: [
                          Image.asset(
                            Res.ic_menu_bottom,
                            color: Colors.grey,
                            width: 25,
                            height: 25,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 16, top: 5,),
                              child: Text(
                                'PACKAGE',
                                style: TextStyle(
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    color: Colors.black),
                              )),
                        ],
                      ),
                    ),
                  ),
                  
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentScreen()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, top: 15,bottom: 15),
                      child: Row(
                        children: [
                          Image.asset(
                            Res.ic_payment,
                            color: Colors.grey,
                            width: 25,
                            height: 25,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 16, top: 5),
                              child: Text(
                                'PAYMENT',
                                style: TextStyle(
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    color: Colors.black),
                              )),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CutomerChatScreen()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, top: 15,bottom: 15),
                      child: Row(
                        children: [
                          Image.asset(
                            Res.ic_chat,
                            color: Colors.grey,
                            width: 25,
                            height: 25,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 16, top: 5),
                              child: Text(
                                'ADMIN CHAT',
                                style: TextStyle(
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    color: Colors.black),
                              )),
                          // Container(
                          //   height: 30,
                          //   width: 40,
                          //   margin: EdgeInsets.only(left: 10),
                          //   decoration: BoxDecoration(
                          //       color: Color(0xff7EDABF),
                          //       borderRadius: BorderRadius.circular(60)),
                          //   child: Padding(
                          //       padding: EdgeInsets.only(left: 16, top: 5),
                          //       child: Text(
                          //         '2',
                          //         style: TextStyle(
                          //             fontFamily: AppConstant.fontBold,
                          //             fontSize: 12,
                          //             color: Colors.black),
                          //       )),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccountScreen()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, top: 15,bottom: 15),
                      child: Row(
                        children: [
                          Image.asset(
                            Res.ic_settings,
                            color: Colors.grey,
                            width: 25,
                            height: 25,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 16, top: 5),
                              child: Text(
                                'SETTINGS',
                                style: TextStyle(
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    color: Colors.black),
                              )),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _ackAlert(context);
                    },
                    child: Container(
                      height: 50,
                      width: 130,
                      decoration: BoxDecoration(
                          color: Color(0xffFFA451),
                          borderRadius: BorderRadius.circular(60)),
                      margin: EdgeInsets.only(left: 16, top: 30, bottom: 10),
                      child: Row(
                        children: [
                          Padding(
                            child: Image.asset(
                              Res.ic_logout,
                              color: Colors.white,
                              width: 25,
                              height: 25,
                            ),
                            padding: EdgeInsets.only(left: 10),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                'LOGOUT',
                                style: TextStyle(
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    color: Colors.white),
                              )),
                        ],
                      ),
                    ),
                  ),
                  AppConstant().navBarHt()
                ],
              ),
              physics: BouncingScrollPhysics(),
            ),
          ),
        ));
  }
}

Future<void> _ackAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Logout!'),
        content: const Text('Are you sure want to logout'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              PrefManager.clear();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/loginSignUp', (Route<dynamic> route) => false);
            },
          )
        ],
      );
    },
  );
}
