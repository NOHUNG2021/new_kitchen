// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kitchen/model/BeanLogin.dart';
import 'package:kitchen/model/BeanSignUp.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/PrefManager.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginSignUpScreen extends StatefulWidget {
  @override
  _LoginSignUpScreenState createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  List state = [];
  List city = [];
  String state_id;
  String city_id;
  // var password_controller = TextEditingController();
  var Kitchen_Name = TextEditingController();
  var Kitchen_Address = TextEditingController();
  var Pincode = TextEditingController();
  var ContactPersonName = TextEditingController();
  var ContactPersonRole = TextEditingController();
  var MobileNumber = TextEditingController();
  var KitchenContactNo = TextEditingController();
  var FSSAILicenseNo = TextEditingController();
  var ExpiryDate = TextEditingController();
  var Email = TextEditingController();
  var PanCard = TextEditingController();
  var GstRegister = TextEditingController();

  var kitchenId = TextEditingController();
  var password = TextEditingController();
  var dateCtl = TextEditingController();
  ProgressDialog _progressDialog;
  final KitchenId = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool selected = false;
  File _image;
  File _uploadimage;
  var type = "";
  var menuFile = "";
  var document = "";

  _imgFromCamera() async {
    var permission = await Permission.camera.request();
    if (permission.isGranted) {
      // DecorationImage image = DecorationImage(image: ImageSource.camera as ImageProvider,filterQuality:FilterQuality.medium);
      XFile image = await ImagePicker().pickImage(
          source: ImageSource.camera, imageQuality: 50);
      setState(() {
        _image = File(image.path);
      });
    }
  }

  _imgFromGallery() async {
    var permission = await Permission.storage.request();
    if (permission.isGranted) {
      // DecorationImage image = DecorationImage(image: ImageSource.camera as ImageProvider,filterQuality:FilterQuality.medium);
      XFile image = await ImagePicker().pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      setState(() {
        _image = File(image.path);
      });
    }
  }

  _uploadImgFromCamera() async {
    var permission = await Permission.camera.request();
    if (permission.isGranted) {
      // DecorationImage uploadimage = DecorationImage(image: ImageSource.camera as ImageProvider,filterQuality:FilterQuality.medium);
      XFile uploadimage = await ImagePicker().pickImage(
          source: ImageSource.camera, imageQuality: 50);
      setState(() {
        _uploadimage = File(uploadimage.path);
      });
    }
  }

  Widget commonSizedBoc() => SizedBox(
        height: 15,
      );
  _uploadimgFromGallery() async {
    var permission = await Permission.storage.request();
    if (permission.isGranted) {
      // DecorationImage uploadimage = DecorationImage(image: ImageSource.camera as ImageProvider,filterQuality:FilterQuality.medium);
      XFile uploadimage = await ImagePicker().pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      setState(() {
        _uploadimage = File(uploadimage.path);
      });
    }
  }

  FormData from = FormData.fromMap({'token': '123456789'});

  @override
  void initState() {
    super.initState();

    ApiProvider().getState(from).then((value) {
      setState(() {
        print(value);
        print(value['data']);
        state = value['data'];
      });
    });
    setState(() {
      selected = !selected;
    });
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          new Container(
            height: 160,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/ic_bg_login.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
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
                              color: Colors.white,
                              child: TabBar(
                                unselectedLabelColor: Colors.grey,
                                labelColor: Colors.black,
                                indicatorColor: Colors.black,
                                isScrollable: true,
                                controller: _controller,
                                tabs: [
                                  Tab(child: Text("Login")),
                                  Tab(child: Text("SignUp")),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
          ),
          Expanded(
            child: Container(
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 300,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome Back",
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.black,
                                          fontFamily: AppConstant.fontRegular),
                                    ),
                                    Text(
                                      "User",
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.black,
                                          fontFamily: AppConstant.fontBold),
                                    ),
                                    // SizedBox(
                                    //   height: 20,
                                    // ),
                                    TextFormField(
                                      controller: kitchenId,
                                      decoration: InputDecoration(
                                        labelText: "Enter Kitchen ID",
                                        labelStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        fillColor: Colors.grey,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 30,
                                    // ),
                                    commonSizedBoc(),
                                    TextField(
                                      controller: password,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        labelText: "Password",
                                        labelStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        fillColor: Colors.grey,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            commonSizedBoc(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/forgot');
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 16, left: 8),
                                        child: Text(
                                          "Forgot password?",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily:
                                                  AppConstant.fontRegular),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    validationLogin();
                                  },
                                  child: Container(
                                    height: 55,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        color: Color(0xffFFA451),
                                        borderRadius:
                                            BorderRadius.circular(13)),
                                    margin:
                                        EdgeInsets.only(bottom: 16, right: 8),
                                    child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Center(
                                          child: Image.asset(Res.ic_back,
                                              width: 20, height: 20),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Welcome,\nUser",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontRegular),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Enter you basic details here",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontBold),
                                ),
                                commonSizedBoc(),
                                TextFormField(
                                  controller: Kitchen_Name,
                                  decoration: InputDecoration(
                                    labelText: "Kitchen Name",
                                    fillColor: Colors.grey,
                                    labelStyle: TextStyle(color: Colors.grey),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                commonSizedBoc(),
                                TextField(
                                  controller: Kitchen_Address,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: "Kitchen Address",
                                    labelStyle: TextStyle(color: Colors.grey),
                                    fillColor: Colors.grey,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                commonSizedBoc(),
                                Container(
                                  height: 50,
                                  child: DropdownButton(
                                    isExpanded: true,
                                    items: state.map((item) {
                                      return DropdownMenuItem(
                                        child: Text(item['name']),
                                        value: item['state_id'].toString(),
                                      );
                                    }).toList(),
                                    onChanged: (String newVal) {
                                      setState(() {
                                        city = [];
                                        state_id = newVal;
                                        print(newVal);
                                        ApiProvider()
                                            .getCity(FormData.fromMap({
                                          'token': '123456789',
                                          'state_id': state_id
                                        }))
                                            .then((value) {
                                          setState(() {
                                            city = value['data'];
                                            city_id = null;
                                          });
                                        });
                                      });
                                    },
                                    value: state_id,
                                    hint: Text('Select State'),
                                  ),
                                ),
                                commonSizedBoc(),
                                Container(
                                  height: 50,
                                  child: DropdownButton(
                                    isExpanded: true,
                                    items: city.map((item) {
                                      return DropdownMenuItem(
                                        child: Text(item['name']),
                                        value: item['city_id'].toString(),
                                      );
                                    }).toList(),
                                    onChanged: (String newVal) {
                                      setState(() {
                                        city_id = newVal;
                                        print(newVal);
                                      });
                                    },
                                    value: city_id,
                                    hint: Text('Select City'),
                                  ),
                                ),
                                commonSizedBoc(),
                                TextField(
                                  controller: Pincode,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: "Pincode",
                                    labelStyle: TextStyle(color: Colors.grey),
                                    fillColor: Colors.grey,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                commonSizedBoc(),
                                TextField(
                                  controller: ContactPersonName,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: "Contact Person Name",
                                    labelStyle: TextStyle(color: Colors.grey),
                                    fillColor: Colors.grey,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                commonSizedBoc(),
                                TextField(
                                  controller: ContactPersonRole,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: "Contact Person Role",
                                    fillColor: Colors.grey,
                                    labelStyle: TextStyle(color: Colors.grey),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                commonSizedBoc(),
                                TextField(
                                  controller: MobileNumber,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  decoration: InputDecoration(
                                    labelText: "Mobile Number",
                                    fillColor: Colors.grey,
                                    labelStyle: TextStyle(color: Colors.grey),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                commonSizedBoc(),
                                TextField(
                                  controller: KitchenContactNo,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  decoration: InputDecoration(
                                    labelText: "Kitchen Contact Number",
                                    fillColor: Colors.grey,
                                    labelStyle: TextStyle(color: Colors.grey),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                commonSizedBoc(),
                                SizedBox(height: 5),
                                Text(
                                  "Enter you business details here",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontBold),
                                ),
                                commonSizedBoc(),
                                TextFormField(
                                  controller: FSSAILicenseNo,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    labelText: "FSSAI Licence Number",
                                    fillColor: Colors.grey,
                                    labelStyle: TextStyle(color: Colors.grey),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                commonSizedBoc(),
                                TextFormField(
                                  controller: dateCtl,
                                  keyboardType: TextInputType.text,
                                  onTap: () async {
                                    var currentDate = DateTime.now();
                                    var firstDate = currentDate
                                        .subtract(Duration(days: 365 * 2));
                                    var lastDate = currentDate
                                        .add(Duration(days: 365 * 2));
                                    var result = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate:
                                            DateTime(DateTime.now().year - 10),
                                        lastDate:
                                            DateTime(DateTime.now().year + 10));
                                    print('$result');
                                    setState(() {
                                      dateCtl.text = DateFormat('dd-MMM-yyyy')
                                          .format(result);
                                    });
                                  },
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    labelText: "Expiry Date Date",
                                    fillColor: Colors.grey,
                                    labelStyle: TextStyle(color: Colors.grey),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                commonSizedBoc(),
                                TextFormField(
                                  controller: Email,
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    labelStyle: TextStyle(color: Colors.grey),
                                    fillColor: Colors.grey,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                commonSizedBoc(),
                                TextFormField(
                                  controller: PanCard,
                                  decoration: InputDecoration(
                                    labelText: "Pan Card",
                                    fillColor: Colors.grey,
                                    labelStyle: TextStyle(color: Colors.grey),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                commonSizedBoc(),
                                TextFormField(
                                  controller: GstRegister,
                                  decoration: InputDecoration(
                                    labelText: "Gst Registration",
                                    labelStyle: TextStyle(color: Colors.grey),
                                    fillColor: Colors.grey,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                commonSizedBoc(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 0, top: 20, right: 16),
                                          child: Text(
                                            "Upload Documents",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily:
                                                    AppConstant.fontRegular,
                                                fontSize: 16),
                                          )),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          _uploadProfile(context);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 16, top: 20, right: 16),
                                          height: 45,
                                          width: 100,
                                          color: Color(0xffF6F6F6),
                                          child: Center(
                                            child: Text(
                                              "Upload",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                      AppConstant.fontRegular),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      alignment: Alignment.center,
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(top: 10, right: 16),
                                        height: 50,
                                        width: double.infinity,
                                        child: _uploadimage == null
                                            ? Container(
                                                child: Image.network(
                                                  document,
                                                  width: double.infinity,
                                                  height: 150,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : Container(
                                                color: Color(0xffF9F9F9),
                                                child: Image.file(
                                                  _uploadimage,
                                                  width: double.infinity,
                                                  height: 150,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                                commonSizedBoc(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 0, top: 20, right: 16),
                                          child: Text(
                                            "Upload Menu",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily:
                                                    AppConstant.fontRegular,
                                                fontSize: 16),
                                          )),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          _showPicker(context);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 16, top: 20, right: 16),
                                          height: 45,
                                          width: 100,
                                          color: Color(0xffF6F6F6),
                                          child: Center(
                                            child: Text(
                                              "Upload",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                      AppConstant.fontRegular),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      alignment: Alignment.center,
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(top: 10, right: 16),
                                        height: 50,
                                        width: double.infinity,
                                        child: _image == null
                                            ? Container(
                                                child: Image.network(
                                                  menuFile,
                                                  width: double.infinity,
                                                  height: 150,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : Container(
                                                color: Color(0xffF9F9F9),
                                                child: Image.file(
                                                  _image,
                                                  width: double.infinity,
                                                  height: 150,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                                commonSizedBoc(),
                                Text(
                                  "(you can upload  your menu in PNG,JPEG or PDF Format)",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: AppConstant.fontRegular,
                                      fontSize: 12),
                                ),
                                commonSizedBoc(),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              validation();
                            },
                            child: Container(
                              height: 55,
                              width: 90,
                              decoration: BoxDecoration(
                                  color: Color(0xffFFA451),
                                  borderRadius: BorderRadius.circular(13)),
                              margin: EdgeInsets.only(bottom: 16, right: 8),
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Center(
                                    child: Image.asset(Res.ic_back,
                                        width: 20, height: 20),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showDetailsVerifyDialog(
      String kitchenName,
      String kitchenAddress,
      String pincode,
      String contactpersonname,
      String contactpersonrole,
      String mobileno,
      String kitchencontactno,
      String licence,
      String expDate,
      String panCard,
      String gst,
      String email) {
    showDialog(
        context: context,
        builder: (_) => Center(
                // Aligns the container to center
                child: GestureDetector(
              onTap: () {},
              child: Wrap(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ), // A simplified version of dialog.
                      width: 270.0,
                      height: 280.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              Res.ic_verify,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 16, top: 20, right: 16),
                                child: Text(
                                  "User Under Verification",
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontBold,
                                      fontSize: 18),
                                )),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 16, top: 20, right: 16),
                                child: Text(
                                  "Now You can add your kitchen and start",
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.grey,
                                      fontFamily: AppConstant.fontRegular,
                                      fontSize: 12),
                                )),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 16, top: 5, right: 16),
                                child: Text(
                                  "your business!",
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.grey,
                                      fontFamily: AppConstant.fontRegular,
                                      fontSize: 12),
                                )),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                SingupUser(
                                    kitchenName,
                                    kitchenAddress,
                                    pincode,
                                    contactpersonname,
                                    contactpersonrole,
                                    mobileno,
                                    kitchencontactno,
                                    licence,
                                    expDate,
                                    panCard,
                                    gst,
                                    email);
                              },
                              child: Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Color(0xffFFA451),
                                    borderRadius: BorderRadius.circular(13)),
                                margin: EdgeInsets.only(top: 25),
                                child: Center(
                                    child: Text(
                                  "Ok",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    decoration: TextDecoration.none,
                                  ),
                                )),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            )));
  }

  void validation() {
    var kitchenName = Kitchen_Name.text.toString();
    var kitchenAddress = Kitchen_Address.text.toString();
    var pincode = Pincode.text.toString();
    var contactPersonName = ContactPersonName.text.toString();
    var contactPersonRole = ContactPersonRole.text.toString();
    var mobileNumber = MobileNumber.text.toString();
    var kitchenContactNumber = KitchenContactNo.text.toString();
    var licence = FSSAILicenseNo.text.toString();
    var expDate = ExpiryDate.text.toString();
    var panCard = PanCard.text.toString();
    var gst = GstRegister.text.toString();
    var email = Email.text.toString();
    RegExp regexEmail = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (kitchenName.isEmpty) {
      Utils.showToast("Enter Kitchen Name");
    } else if (kitchenAddress.isEmpty) {
      Utils.showToast("Enter Kitchen Address");
    } else if (state_id == null) {
      Utils.showToast("Select state");
    } else if (city_id == null) {
      Utils.showToast("Select city");
    } else if (pincode.isEmpty) {
      Utils.showToast("Enter Pincode ");
    } else if (contactPersonName.isEmpty) {
      Utils.showToast("Enter Contact Person Name ");
    } else if (contactPersonRole.isEmpty) {
      Utils.showToast("Enter Contact Person Role ");
    } else if (mobileNumber.isEmpty) {
      Utils.showToast("Enter Mobile Number ");
    } else if (kitchenContactNumber.isEmpty) {
      Utils.showToast("Enter Kitchen Contact Number ");
    } else if (licence.isEmpty) {
      Utils.showToast("Enter licence no ");
    } else if (dateCtl.text.isEmpty) {
      Utils.showToast("Enter Exp Date ");
    } else if (email.isEmpty) {
      Utils.showToast("Enter Email ");
    } else if (!regexEmail.hasMatch(email)) {
      Utils.showToast("please enter valid email");
    } else if (panCard.isEmpty) {
      Utils.showToast("Enter Pan Card ");
    } else if (gst.isEmpty) {
      Utils.showToast("Enter Gst Registration ");
    } else if (_uploadimage == null) {
      Utils.showToast("Document is empty");
    } else if (_image == null) {
      Utils.showToast(" Menu is empty");
    } else {
      showDetailsVerifyDialog(
          kitchenName,
          kitchenAddress,
          pincode,
          contactPersonName,
          contactPersonRole,
          mobileNumber,
          kitchenContactNumber,
          licence,
          expDate,
          panCard,
          gst,
          email);
    }
  }

  Future<BeanSignUp> SingupUser(
      String kitchenName,
      String kitchenAddress,
      String pincode,
      String contactPersonName,
      String contactPersonRole,
      String mobileNumber,
      String kitchenContactNumber,
      String licence,
      String expDate,
      String panCard,
      String gst,
      String email) async {
    _progressDialog.show();
    try {
      FormData data = FormData.fromMap({
        "token": "123456789",
        "kitchenname": kitchenName,
        "address": kitchenAddress,
        "stateid": state_id.toString(),
        "cityid": city_id.toString(),
        "pincode": pincode,
        "contactpersonname": contactPersonName,
        "contactpersonrole": contactPersonRole,
        "mobilenumber": mobileNumber,
        "kitchenscontactnumber": kitchenContactNumber,
        "email": email,
        "FSSAILicenceNo": licence,
        "expirydate": dateCtl.text.toString(),
        "pancard": panCard,
        "gstnumber": gst,
        "menufile":
            await MultipartFile.fromFile(_image.path, filename: _image.path),
        "documents": await MultipartFile.fromFile(_uploadimage.path,
            filename: _uploadimage.path),
      });
      BeanSignUp bean = await ApiProvider().registerUser(data);
      print(bean.data);
      _progressDialog.dismiss();
      if (bean.status == true) {
        PrefManager.putBool(AppConstant.session, true);
        PrefManager.putString(AppConstant.user, jsonEncode(bean));
        Utils.showToast(bean.message);
        _controller.animateTo(0);
        // Navigator.pushReplacementNamed(context, '/homebase');
      } else {
        Utils.showToast(bean.message);
      }
    } on HttpException catch (exception) {
      _progressDialog.dismiss();
    } catch (exception) {
      _progressDialog.dismiss();
    }
  }

  void _showPicker(context) {
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
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _uploadProfile(context) {
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
                        _uploadimgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _uploadImgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void validationLogin() {
    var id = kitchenId.text.toString();
    var pass = password.text.toString();
    if (id.isEmpty) {
      Utils.showToast("Please enter kitchen id");
    } else if (pass.isEmpty) {
      Utils.showToast("Please enter  password");
    } else {
      loginUser(id, pass);
    }
  }

  Future<BeanLogin> loginUser(String kitchenId, String password) async {
    _progressDialog.show();
    try {
      FormData data = FormData.fromMap({
        "kitchen_id": kitchenId,
        "token": "123456789",
        "password": password,
      });
      BeanLogin bean = await ApiProvider().loginUser(data);
      print(" ${bean.data} Jani Res");
      _progressDialog.dismiss();
      if (bean.status == true) {
        print(jsonEncode(bean).toString() +
            'jsoooooooooooooooooooooooooooonnnnnnnnnnnnnnnnnnnnnnn');
        PrefManager.putBool(AppConstant.session, true);
        PrefManager.putString(AppConstant.user, jsonEncode(bean));
        Utils.showToast(bean.message);
        Navigator.pushReplacementNamed(context, '/homebase');
      } else {
        Utils.showToast(bean.message);
      }
    } on HttpException catch (exception) {
      _progressDialog.dismiss();
    } catch (exception) {
      _progressDialog.dismiss();
    }
  }
}
