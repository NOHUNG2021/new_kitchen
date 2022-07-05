// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/model/BeanAddAccount.dart';
import 'package:kitchen/model/bankaccountsmodel.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';

class BankAccounts extends StatefulWidget {
  final String user_id;
  const BankAccounts({Key key, @required this.user_id}) : super(key: key);

  @override
  _BankAccountsState createState() => _BankAccountsState();
}

class _BankAccountsState extends State<BankAccounts> {
  BankAccountsModel banks;
  ProgressDialog progressDialog;
  var id = '';
  var accountName = TextEditingController();
  var bank = TextEditingController();
  var IfscCode = TextEditingController();
  var accountnumber = TextEditingController();

  void clearControllers() {
    bank.clear();
    IfscCode.clear();
    accountName.clear();
    accountnumber.clear();
  }

  bool loading = true;
  Future<BankAccountsModel> getBankAccounts(BuildContext context) async {
    try {
      FormData from = FormData.fromMap(
          {"kitchen_id": widget.user_id, "token": "123456789"});
      BankAccountsModel bean = await ApiProvider().getBankAccounts(from);

      if (bean.status) {
        if (bean.data != null) {
          setState(() {
            banks = bean;
          });
        }

        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      print(exception);
    } catch (exception) {
      print(exception);
    }
  }

  Future EditBank(BuildContext context) async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "token": "123456789",
        "id": id,
        "account_name": accountName.text,
        "bank_name": bank.text,
        "ifsc_code": IfscCode.text,
        "account_number": accountnumber.text
      });
      var bean = await ApiProvider().Editbankacc(from);
      progressDialog.dismiss();

      if (bean['status']) {
        if (bean["data"] != null) {
          setState(() {
            Navigator.pop(context);
            getBankAccounts(context);
          });
        }

        return bean;
      } else {
        Utils.showToast(bean["message"]);
      }

      return null;
    } on HttpException catch (exception) {
      print(exception);
      progressDialog.dismiss();
    } catch (exception) {
      print(exception);
      progressDialog.dismiss();
    }
  }

  Future DeleteBank(BuildContext context, String id) async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "token": "123456789",
        "id": id,
      });
      var bean = await ApiProvider().Deletebankaacount(from);
      progressDialog.dismiss();
      if (bean['status']) {
        if (bean["data"] != null) {
          setState(() {
            getBankAccounts(context);
          });
        }

        return bean;
      } else {
        Utils.showToast(bean["message"]);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBankAccounts(context).then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bank Accounts'),
        centerTitle: true,
        backgroundColor: AppConstant.appColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addAcountDetail(false);
        },
        backgroundColor: AppConstant.appColor,
        child: Icon(Icons.add),
      ),
      body: (loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (!banks.status)
              ? Center(
                  child: Text('No Bank Details Added'),
                )
              : ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 170,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () {
                                          id = banks.data[index].id;
                                          bank.text =
                                              banks.data[index].bankName;
                                          accountnumber.text =
                                              banks.data[index].accountNumber;
                                          accountName.text =
                                              banks.data[index].accountName;
                                          IfscCode.text =
                                              banks.data[index].ifscCode;
                                          addAcountDetail(true);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          DeleteBank(
                                              context, banks.data[index].id);
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: Text('ACCOUNT NAME')),
                                      Expanded(
                                          child: Text(
                                              banks.data[index].accountName))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: Text('ACCOUNT NUMBER')),
                                      Expanded(
                                          child: Text(
                                              banks.data[index].accountNumber))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: Text('BANK NAME')),
                                      Expanded(
                                          child:
                                              Text(banks.data[index].bankName))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: Text('IFSC CODE')),
                                      Expanded(
                                          child:
                                              Text(banks.data[index].ifscCode))
                                    ],
                                  ),
                                ],
                              ),
                              // Align(
                              //   alignment: Alignment.topRight,
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.end,
                              //     children: [
                              //       IconButton(
                              //         icon: Icon(Icons.edit),
                              //         onPressed: () {},
                              //       ),
                              //       IconButton(
                              //         icon: Icon(Icons.delete),
                              //         onPressed: () {},
                              //       )
                              //     ],
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: banks.data.length,
                ),
    );
  }

  void addAcountDetail(bool edit) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 6,
            backgroundColor: Colors.transparent,
            child: _DialogWithTextField(context, edit),
          );
        });
  }

  Widget _DialogWithTextField(BuildContext context, bool edit) => Container(
        height: 450,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 16),
              Text(
                (edit)
                    ? "Edit Account Detail".toUpperCase()
                    : "Add Account Detail".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: 15),
              Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
                  child: TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: accountName,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Account Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 10, right: 15, left: 15),
                  child: TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: bank,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Bank',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 10, right: 15, left: 15),
                  child: TextFormField(
                    maxLines: 1,
                    controller: IfscCode,
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: 'IFSC CODE',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 10, right: 15, left: 15),
                  child: TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: accountnumber,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Account Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  )),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      clearControllers();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Close",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary:AppConstant.appColor ,shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(108.0),),),
                    child: Text(
                      "Save Details".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      validation(edit);

                      print('Update the user info');
                      // return Navigator.of(context).pop(true);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      );

  void validation(bool edit) {
    if (accountName.text.isEmpty) {
      Utils.showToast("Please Enter Account Name");
    } else if (bank.text.isEmpty) {
      Utils.showToast("Please Enter Bank Name");
    } else if (IfscCode.text.isEmpty) {
      Utils.showToast("Please Enter IFSC Code");
    } else if (accountnumber.text.isEmpty) {
      Utils.showToast("Please Enter Account Number");
    } else {
      (edit) ? EditBank(context) : addAccount();
    }
  }

  Future<BeanAddAccount> addAccount() async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": widget.user_id,
        "token": "123456789",
        "account_name": accountName.text.toString(),
        "bank_name": bank.text.toString(),
        "ifsc_code": IfscCode.text.toString(),
        "account_number": accountnumber.text.toString(),
      });
      BeanAddAccount bean = await ApiProvider().beanAddAccount(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        Utils.showToast(bean.message);
        getBankAccounts(context);
        clearControllers();
        Navigator.pop(context);

        setState(() {});

        return bean;
      } else {
        clearControllers();
        getBankAccounts(context);
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      getBankAccounts(context);
      clearControllers();
      progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      clearControllers();
      progressDialog.dismiss();
      getBankAccounts(context);
      print(exception);
    }
  }
}
