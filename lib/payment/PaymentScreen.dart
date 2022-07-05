import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/model/BeanAddAccount.dart';
import 'package:kitchen/model/BeanLogin.dart';
import 'package:kitchen/model/BeanPayment.dart';
import 'package:kitchen/model/GetPayment.dart';
import 'package:kitchen/model/bankaccountsmodel.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/payment/bankaccounts.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/screen/HomeBaseScreen.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future future;

  var accountName = TextEditingController();
  var bank = TextEditingController();
  var IfscCode = TextEditingController();
  var accountnumber = TextEditingController();
  var amount = TextEditingController();
  BankAccountsModel bankaccounts;
  BeanLogin userBean;
  ProgressDialog progressDialog;
  var userId = "";
  List<Transaction> data = [];
  TextEditingController _c;
  var totalEarning = "";
  var currentBalance = '';
  void getUser() async {
    userBean = await Utils.getUser();
    userId = userBean.data.id.toString();

    setState(() {});
  }

  @override
  void initState() {
    getUser();
    super.initState();
    Future.delayed(Duration.zero, () {
      future = getPayment(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        key: _scaffoldKey,
        drawer: MyDrawers(),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _scaffoldKey.currentState.openDrawer();
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 80),
                      child: Image.asset(
                        Res.ic_menu,
                        width: 30,
                        height: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                      height: 180,
                      child: Center(
                        child: Image.asset(
                          Res.ic_payment_default,
                        ),
                      )),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (BuildContext context) =>
                      //             AddAccountDetails()));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        "Total Earning",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, top: 0),
                          child: Text(
                            AppConstant.rupee + totalEarning,
                            style: TextStyle(
                                color: AppConstant.lightGreen,
                                fontSize: 22,
                                fontFamily: AppConstant.fontBold),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          addAcountDetail();
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 16, top: 16),
                          height: 55,
                          width: 160,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "Add Account Details",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontFamily: AppConstant.fontBold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  data.isEmpty
                      ? Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                getItem(data[index]),
                                (index + 1 == data.length)
                                    ? AppConstant().navBarHt()
                                    : Container()
                              ],
                            );
                          },
                          itemCount: data.length,
                        ),
                  SizedBox(height: 100)
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      withdrawAmountDialog();

/*                  payment();*/
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 16, right: 16, bottom: 16, top: 16),
                      height: 55,
                      decoration: BoxDecoration(
                          color: AppConstant.appColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Center(
                          child: Text(
                            "WITHDRAW PAYMENT",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppConstant.fontBold,
                                fontSize: 10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AppConstant().navBarHt()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, right: 20),
              child: Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  child: Text(
                    'My Accounts',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    pushNewScreen(context,
                        screen: BankAccounts(
                          user_id: userId,
                        ),
                        withNavBar: false);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => BankAccounts(
                    //               user_id: userId,
                    //             )));
                  },
                ),
              ),
            )
          ],
        ));
  }

  Widget getItem(Transaction data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Customer ID 1234",
                  style: TextStyle(
                      color: Colors.black, fontFamily: AppConstant.fontRegular),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16, right: 16),
              child: Text(
                AppConstant.rupee + data.amount,
                style: TextStyle(
                    color: Colors.black, fontFamily: AppConstant.fontBold),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 16),
          child: Text(
            data.transactionDate,
            style:
                TextStyle(color: Colors.grey, fontFamily: AppConstant.fontBold),
          ),
        ),
        Divider(
          color: Colors.grey.shade400,
        ),
      ],
    );
  }

  Future<GetPayment> getPayment(BuildContext context) async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId,
        "token": "123456789",
      });
      GetPayment bean = await ApiProvider().getPay(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        data = bean.data.transaction;
        totalEarning = bean.data.totalEarning;
        currentBalance = bean.data.currentBalance;
        setState(() {});

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

  Future<BeanPayment> withdrawPayment(
      String amount, BuildContext context) async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId,
        "token": "123456789",
        "withdraw_amount": amount,
      });
      BeanPayment bean = await ApiProvider().beanPayment(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        Utils.showToast(bean.message);

        Navigator.pop(context);
        setState(() {});

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

  void addAcountDetail() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 6,
            backgroundColor: Colors.transparent,
            child: _DialogWithTextField(context),
          );
        });
  }

  Widget _DialogWithTextField(BuildContext context) => Container(
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
                "Add Account Detail".toUpperCase(),
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
                    style: ElevatedButton.styleFrom(primary: AppConstant.appColor,shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(108.0),
                    ),),
                    child: Text(
                      "Save Details".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      validation(context);

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

  void validation(BuildContext context) {
    if (accountName.text.isEmpty) {
      Utils.showToast("Please Enter Account Name");
    } else if (bank.text.isEmpty) {
      Utils.showToast("Please Enter Bank Name");
    } else if (IfscCode.text.isEmpty) {
      Utils.showToast("Please Enter IFSC Code");
    } else if (accountnumber.text.isEmpty) {
      Utils.showToast("Please Enter Account Number");
    } else {
      addAccount(context);
    }
  }

  Future<BeanAddAccount> addAccount(BuildContext context) async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({
        "kitchen_id": userId,
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
        Navigator.pop(context);

        setState(() {});

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

  void withdrawAmountDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 6,
            backgroundColor: Colors.transparent,
            child: dialog(context),
          );
        });
  }

  Widget dialog(BuildContext context) => Container(
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Current Balance ".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    AppConstant.rupee + currentBalance,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppConstant.lightGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
                child: TextFormField(
                  maxLines: 1,
                  autofocus: false,
                  controller: amount,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Withdraw Amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                )),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextButton(
                  onPressed: () {
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
                  style: ElevatedButton.styleFrom(primary: AppConstant.appColor,shape:RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0), ),),
                  child: Text(
                    "Send Message".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (amount.text.isEmpty) {
                      Utils.showToast("Please enter withdraw amount");
                    } else {
                      withdrawPayment(amount.text, context);
                    }

                    // return Navigator.of(context).pop(true);
                  },
                )
              ],
            ),
          ],
        ),
      );
}
