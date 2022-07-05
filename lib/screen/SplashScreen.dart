import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/PrefManager.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;
  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    bool isLogined = await PrefManager.getBool(AppConstant.session);
    if (isLogined) {
      Navigator.pushReplacementNamed(context, '/homebase');
    }else {
      Navigator.pushReplacementNamed(context, '/loginSignUp');
    }
  }

  @override
  dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(vsync: this, duration: new Duration(seconds: 2));
    animation = new CurvedAnimation(parent: animationController, curve: Curves.bounceInOut);
    animation.addListener(() => this.setState(() {}));
    animationController.forward();
    setState(() {
      _visible = !_visible;
    });
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return Scaffold(
        body: Center(
          child: Stack(
            children: [
              Image.asset(Res.ic_bg, width: double.infinity,height: double.infinity,fit: BoxFit.fill,),
              Center(

                child: Image.asset(Res.ic_logo,
                    width: animation.value * 100, height: animation.value * 100),
              ),
            ],
          ),

          /*child: Image.asset(
            Res.ic_logo,
            width: animation.value * 160,
            height: animation.value * 160,
          ),*/
        ));
  }
}
