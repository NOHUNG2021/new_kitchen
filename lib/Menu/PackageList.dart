// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
// import 'package:kitchen/model/BeanDeletePackage.dart';
// import 'package:kitchen/model/BeanGetPackages.dart';
// import 'package:kitchen/model/BeanLogin.dart';
// import 'package:kitchen/network/ApiProvider.dart';
// import 'package:kitchen/utils/Constents.dart';
// import 'package:kitchen/utils/Utils.dart';
// import 'package:kitchen/utils/progress_dialog.dart';
//
// import '../res.dart';
//
// class PackageList extends StatefulWidget {
//   @override
//   _PackageListState createState() => _PackageListState();
// }
//
// class _PackageListState extends State<PackageList> {
//   var userId = "";
//   ProgressDialog progressDialog;
//   BeanLogin userBean;
//
//   Future getUser() async {
//     userBean = await Utils.getUser();
//     userId = userBean.data.id.toString();
//   }
//
//   @override
//   void initState() {
//     getUser().then((value) => getMealScreenItems());
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     progressDialog = ProgressDialog(context);
//     FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
//     FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
//     return Scaffold(
//       body:
//     );
//   }
//
//
//
//   Future<BeanGetPackages> getMealScreenItems() async {
//     progressDialog.show();
//     try {
//       FormData from = FormData.fromMap({
//         "user_id": userId,
//         "token": "123456789",
//       });
//       getPackagesbean = await ApiProvider().getPackages(from);
//       print(getPackagesbean.data);
//       progressDialog.dismiss();
//       if (getPackagesbean.status == true) {
//         setState(() {});
//         return getPackagesbean;
//       } else {
//         Utils.showToast(getPackagesbean.message);
//         setState(() {});
//         return getPackagesbean;
//       }
//
//       return null;
//     } on HttpException catch (exception) {
//       // progressDialog.dismiss();
//       print(exception);
//     } catch (exception) {
//       //  progressDialog.dismiss();
//       print(exception);
//     }
//   }
//
//   Future<BeanDeletePackage> deletePackage(String packageId) async {
//     progressDialog.show();
//     try {
//       FormData from = FormData.fromMap({
//         "kitchen_id": userId,
//         "token": "123456789",
//         "package_id": packageId,
//       });
//       BeanDeletePackage bean = await ApiProvider().deletePackage(from);
//       print(bean.data);
//       if (bean.status == true) {
//         setState(() {
//           getMealScreenItems();
//         });
//         progressDialog.dismiss();
//         return bean;
//       } else {
//         Utils.showToast(bean.message);
//       }
//
//       return null;
//     } on HttpException catch (exception) {
//       progressDialog.dismiss();
//       print(exception);
//     } catch (exception) {
//       progressDialog.dismiss();
//       print(exception);
//     }
//   }
// }
