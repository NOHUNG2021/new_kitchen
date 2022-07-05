import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/utils/Constents.dart';

class SuccessPackageScreen extends StatefulWidget {
  @override
  _SuccessPackageScreenState createState() => _SuccessPackageScreenState();
}

class _SuccessPackageScreenState extends State<SuccessPackageScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 200,
                child: Center(
                  child: Image.asset(
                    Res.ic_package_success,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  "SUCCESSFULLY PACKAGE UPLOAD",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 18),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  "To Create Many Packages\nclick to add another packages",
                  style: TextStyle(
                      color: Color(0xffA7A8BC),
                      fontFamily: AppConstant.fontRegular,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 60, bottom: 15),
                    height: 55,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Color(0xffFFA451),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Done",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    )),
              ),
            ],
          ),
          physics: BouncingScrollPhysics(),
        ));
  }
}
