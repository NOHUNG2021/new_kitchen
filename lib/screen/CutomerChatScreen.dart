import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/model/BeanLogin.dart';
import 'package:kitchen/model/GetChat.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';
import 'package:kitchen/model/GetChat.dart' as response;
import 'package:kitchen/model/BeanSendMessage.dart' as Chat;

import '../res.dart';

class CutomerChatScreen extends StatefulWidget {
  @override
  _CutomerChatScreenState createState() => _CutomerChatScreenState();
}

class _CutomerChatScreenState extends State<CutomerChatScreen> {
  var type = "";
  Future future;
  ScrollController scrollController = ScrollController();

  List<response.Chat> list;
  List<response.Data> temp;
  Future<List<response.Chat>> _future;

  BeanLogin userBean;
  var userId = "";

  var _msg = TextEditingController();
  ProgressDialog progressDialog;
  void getUser() async {
    userBean = await Utils.getUser();
    userId = userBean.data.id.toString();

    setState(() {});
  }

  @override
  void initState() {
    getUser();
    Future.delayed(Duration.zero, () {
      _future = getChat(context);
    });
    super.initState();
  }

/*
  Future<List<Chat.Result>> getChat(BuildContext context) async {
    var user = await Utils.getUser();
    userID = user.result[0].userId;
    FormData data = FormData.fromMap({
      "user_id": userID,
      "fri_id": bean.tutorId
    });
    GetMsg getMsg = await ApiProvider.baseUrl().getMsg(data);
    list = getMsg.result;
    if(list==null){
      list = List();
    }
    return list;

  }*/

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Appbar(context),
            Expanded(
                child: FutureBuilder<List<response.Chat>>(
              future: _future,
              builder: (context, projectSnap) {
                print(projectSnap);
                if (projectSnap.connectionState == ConnectionState.done) {
                  if (projectSnap.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      reverse: true,
                      //controller: scrollController,
                      itemBuilder: (context, index) {
                        return chatDesign(list[index]);
                      },
                    );
                  } else {
                    return Container();
                  }
                } else {
                  return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xffF3F6FA),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 10),
                          child: TextField(
                            controller: _msg,
                            decoration: InputDecoration.collapsed(
                                hintText: "Write message"),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          validation();
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.only(right: 16, bottom: 16, top: 8),
                          child: Image.asset(
                            Res.ic_send,
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            AppConstant().navBarHt(),
            SizedBox(
              height: 10,
            ),
          ],
        ));
  }

  Widget Appbar(BuildContext context) {
    return Container(
      color: AppConstant.appColor,
      margin: EdgeInsets.only(top: 16),
      child: Row(
        children: [
          SizedBox(
            width: 16,
          ),
          InkWell(
              onTap: () {},
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    )),
              )),
          SizedBox(
            width: 16,
          ),
          Padding(
              padding: EdgeInsets.only(top: 20),
              child: Image.asset(
                Res.ic_chef,
                width: 50,
                height: 50,
              )),
          Padding(
            child: Text(
              "Admin",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: AppConstant.fontBold,
                  fontSize: 20),
            ),
            padding: EdgeInsets.only(top: 20, left: 16),
          )
        ],
      ),
      height: 100,
    );
  }

  Future<List<response.Chat>> getChat(BuildContext context) async {
    FormData from =
        FormData.fromMap({"kitchen_id": userId, "token": "123456789"});
    GetChat bean = await ApiProvider().getChat(from);

    list = bean.data.chat.reversed.toList();
    if (bean.status == true) {
      if (list == null) {
        list = List();
      }
      setState(() {});

      return list;
    }
  }
  /*Future<List<response.Data>> getChat(BuildContext context) async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({"userid": "70", "token": "123456789"});
      GetChat bean = await ApiProvider().getChat(from);
      list=bean.data;
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        if(list==null){
          list=List();
        }
        setState(() {


        });

        return list;
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
  }*/

  chatDesign(response.Chat result) {
    if (result.msgType == "sent") {
      return Container(
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                  width: 100,
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
                  decoration: BoxDecoration(
                      color: Color(0xffBEE8FF),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          result.message + '',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(result.time,
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xff757575))),
                        ),
                      )
                    ],
                  )),
            ),
          ));
    } else if (result.msgType == "received") {
      return Container(
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                  width: 100,
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
                  decoration: BoxDecoration(
                      color: Color(0xffF3F6FA),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16, top: 16, right: 16, bottom: 16),
                          child: Text(
                            result.message,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ));
    }
  }

  Future<Chat.BeanSendMessage> sendMessage(String messageInput) async {
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId,
        "token": "123456789",
        "message": messageInput,
      });
      Chat.BeanSendMessage bean = await ApiProvider().sendMessage(from);
      print(bean.data);
      if (bean.status == true) {
        Utils.showToast(bean.message);
        getChat(context);

        messageInput = _msg.text = "";
        response.Chat result = response.Chat();
        result.message = bean.data.message;
        result.msgType = bean.data.msgType;
        result.createddate = bean.data.createddate;

        if (list != null) {
          // temp.add(result);
          list.add(result);
        } else {
          list = List();
          list.add(result);
        }
        setState(() {
          messageInput = _msg.text = "";
        });

        // Future.delayed(const Duration(milliseconds: 500), () {
        //   scrollController.animateTo(scrollController.position.maxScrollExtent,
        //       curve: Curves.ease, duration: Duration(milliseconds: 300));
        // });
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

  void validation() {
    var messageInput = _msg.text.toString();
    if (messageInput.isEmpty) {
      Utils.showToast("Please Enter Message");
    } else {
      sendMessage(messageInput);
    }
  }
}
