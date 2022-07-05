// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitchen/model/BeanLogin.dart';
import 'package:kitchen/model/BeanUpdateSetting.dart';
import 'package:kitchen/model/GetAccountDetail.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/screen/HomeBaseScreen.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  BeanLogin userBean;

  ProgressDialog progressDialog;
  File mediaFile = null;
  var name = "";
  var email = "";
  var address = "";
  var number = "";
  var password = "";
  var id;
  var imageURL;
  var name_controller = TextEditingController();
  var password_controller = TextEditingController();
  var description_controller = TextEditingController();
  var address_controller = TextEditingController();
  var email_controller = TextEditingController();
  var number_controller = TextEditingController();

  Future getUser() async {
    userBean = await Utils.getUser();
    name = userBean.data.kitchenname;
    email = userBean.data.email;
    address = userBean.data.address;
    password = userBean.data.password;
    id = userBean.data.id;
  }

  Future future;

  @override
  void initState() {
    getUser().then((value) {
      setState(() {
        future = getAccountDetails(context);
      });
    });

    super.initState();
  }

  Future<void> _showPicker(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Photo Library'),
                      onTap: () {
                        setState(() {
                          _imgFromGallery();
                        });

                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      setState(() {
                        _imgFromCamera();
                      });

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future _imgFromCamera() async {
    // var image = DecorationImage(image: ImageSource.gallery as ImageProvider,filterQuality:FilterQuality.medium);
    var image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      mediaFile = File(image.path);
    });
  }

  Future _imgFromGallery() async {
    // var image = DecorationImage(image: ImageSource.gallery as ImageProvider,filterQuality:FilterQuality.medium);
    var image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      mediaFile = File(image.path);
    });
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
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                color: AppConstant.appColor,
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
                        child: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Image.asset(
                            Res.ic_menu,
                            width: 30,
                            height: 30,
                            color: Colors.white,
                          ),
                        )),
                    SizedBox(
                      width: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 20),
                      child: Text(
                        "SETTINGS",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ],
                ),
                height: 100,
              ),
              (imageURL == null)
                  ? Container(
                      height: 150,
                      width: double.infinity,
                      child: Image.asset(
                        Res.ic_gallery,
                        fit: BoxFit.cover,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, top: 16),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: (mediaFile == null)
                                      ? NetworkImage(imageURL)
                                      : FileImage(File(mediaFile.path)))),
                        ),
                      ),
                    ),
              Container(
                  decoration: BoxDecoration(
                    //  color: Colors.yellow,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Image.asset(
                              Res.ic_contact,
                              width: 18,
                              height: 18,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: TextField(
                                controller: name_controller,
                                style: TextStyle(
                                    fontFamily: AppConstant.fontRegular,
                                    fontSize: 14,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xffd3dde4),
                                            width: 3)),
                                    labelText: "Kitchen Name",
                                    labelStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontFamily: "CentraleSansRegular")),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Image.asset(
                              Res.ic_loc,
                              width: 18,
                              height: 18,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: TextField(
                                controller: address_controller,
                                style: TextStyle(
                                    fontFamily: AppConstant.fontRegular,
                                    fontSize: 14,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xffd3dde4),
                                            width: 3)),
                                    labelText: "Location",
                                    labelStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontFamily: "CentraleSansRegular")),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Image.asset(
                              Res.ic_messag,
                              width: 18,
                              height: 18,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: TextField(
                                controller: email_controller,
                                style: TextStyle(
                                    fontFamily: AppConstant.fontRegular,
                                    fontSize: 14,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xffd3dde4),
                                            width: 3)),
                                    labelText: "Email",
                                    labelStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontFamily: "CentraleSansRegular")),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Image.asset(
                              Res.ic_phn,
                              width: 18,
                              height: 18,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: TextField(
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xffd3dde4),
                                            width: 3)),
                                    labelText: "Mobile Number",
                                    labelStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontFamily: "CentraleSansRegular")),
                                controller: number_controller,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    fontFamily: AppConstant.fontRegular,
                                    fontSize: 14,
                                    color: Colors.black),
                                //decoration: InputDecoration.collapsed(
                                //hintText: number == "" ? "Number" : number,
                                //),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Image.asset(
                              Res.ic_pass,
                              width: 18,
                              height: 18,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: TextField(
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xffd3dde4),
                                            width: 3)),
                                    labelText: "Password",
                                    labelStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontFamily: "CentraleSansRegular")),
                                controller: password_controller,
                                obscureText: true,
                                style: TextStyle(
                                    fontFamily: AppConstant.fontRegular,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                            ),
                          )
                        ],
                      ),

                      SizedBox(
                        height: 30,
                      ),Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Image.asset(
                              Res.ic_messag,
                              width: 18,
                              height: 18,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: TextField(
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xffd3dde4),
                                            width: 3)),
                                    labelText: "Description",
                                    labelStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontFamily: "CentraleSansRegular")),
                                controller: description_controller,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    fontFamily: AppConstant.fontRegular,
                                    fontSize: 14,
                                    color: Colors.black),
                                //decoration: InputDecoration.collapsed(
                                //hintText: number == "" ? "Number" : number,
                                //),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      
                      InkWell(
                        onTap: () {
                          uploadProfileImage();
                          updateAccount();
                        },
                        child: Container(
                          height: 55,
                          margin: EdgeInsets.only(
                              left: 16, right: 16, bottom: 16, top: 16),
                          decoration: BoxDecoration(
                              color: AppConstant.appColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: AppConstant.fontBold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      AppConstant().navBarHt()
                    ],
                  )),
            ],
          ),
        ));
  }

  Future uploadProfileImage() async {
    var userBean = await Utils.getUser();
    try {
      FormData from = await FormData.fromMap({
        "user_id": userBean.data.id,
        "token": "123456789",
        "profile_image": await MultipartFile.fromFile(mediaFile.path,
            filename: mediaFile.path),
      });
      var bean = await ApiProvider().uploadProfileImage(from);

      if (bean.status == true) {
        setState(() {
          getAccountDetails(context);
        });

        Utils.showToast(bean.message);
        return bean;
      } else {
        setState(() {});
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      print(exception);
    } catch (exception) {
      print(exception);
    }
  }

  Future<BeanUpdateSetting> updateAccount() async {
    var name = name_controller.text.toString();
    var address = address_controller.text.toString();
    var email = email_controller.text.toString();
    var number = number_controller.text.toString();
    var password = password_controller.text.toString();
    var description = description_controller.text.toString();
    progressDialog.show();
    try {
      FormData data = FormData.fromMap({
        "token": "123456789",
        "user_id": id,
        "kitchen_name": name.toString(),
        "address": address.toString(),
        "email": email.toString(),
        "mobile_number": number,
        "password": password,
        "description":description,
      });
      BeanUpdateSetting bean = await ApiProvider().updateSetting(data);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        Utils.showToast(bean.message);
        Navigator.pop(context);
      } else {
        Utils.showToast(bean.message);
      }
    } on HttpException catch (exception) {
      progressDialog.dismiss();
    } catch (exception) {
      progressDialog.dismiss();
    }
  }

  Future<GetAccountDetails> getAccountDetails(BuildContext context) async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({"user_id": id, "token": "123456789"});
      GetAccountDetails bean = await ApiProvider().getAccountDetails(from);
      progressDialog.dismiss();
      if (bean.status) {
        if (bean.data != null) {
          setState(() {
            name_controller.text = bean.data.kitchenName;
            address_controller.text = bean.data.address;
            email_controller.text = bean.data.email;
            number_controller.text = bean.data.mobileNumber;
            password_controller.text = bean.data.password;
            description_controller.text = bean.data.description;
            imageURL = bean.data.profileImage;
          });
        }

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
}
