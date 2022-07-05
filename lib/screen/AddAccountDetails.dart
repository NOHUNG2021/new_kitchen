import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';
import '../res.dart';

class AddAccountDetails extends StatefulWidget {
  @override
  _AddAccountDetailsState createState() => _AddAccountDetailsState();
}

class _AddAccountDetailsState extends State<AddAccountDetails> {
  int _radioValue = -1;
  bool isChecked = false;
  ProgressDialog _progressDialog;
  var number = TextEditingController();
  var cardholdername = TextEditingController();
  var valid = TextEditingController();
  Future future;
  var name = "";
  var holderName = "";
  var numbercard = "";
  var expirydate = "";
  var through = "";

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = 'dxcf';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      // future = getCard(context);
    });
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          setState(() {});
          break;

        case 1:
          setState(() {});
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Image.asset(
                            Res.ic_back,
                            width: 16,
                            height: 16,
                          )),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "Your Location",
                              style: TextStyle(color: Color(0xffA7A8BC)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "To 89 Palmspring Way Roseville,\nCA 39847",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: AppConstant.fontBold,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(13)),
                    margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                    width: double.infinity,
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          child: Text(
                            "Card Number",
                            style:
                                TextStyle(color: Colors.yellow, fontSize: 14),
                          ),
                          padding:
                              EdgeInsets.only(left: 16, right: 16, top: 16),
                        ),
                        Padding(
                          child: Text(
                            numbercard,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          padding:
                              EdgeInsets.only(left: 16, right: 16, top: 16),
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  child: Text(
                                    "Holder Name",
                                    style: TextStyle(
                                        color: Colors.yellow, fontSize: 14),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 16),
                                ),
                                Padding(
                                  child: Text(
                                    holderName,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 16),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  child: Text(
                                    "Expiry Date",
                                    style: TextStyle(
                                        color: Colors.yellow, fontSize: 14),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 16),
                                ),
                                Padding(
                                  child: Text(
                                    expirydate,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 16),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    )),
                // CreditCardWidget(
                //   cardNumber: cardNumber,
                //   expiryDate: expiryDate,
                //   cardHolderName: cardHolderName,
                //   cvvCode: cvvCode,
                //   showBackView: isCvvFocused,
                //   obscureCardNumber: true,
                //   obscureCardCvv: true,
                //   //isHolderNameVisible: true,
                //   cardBgColor: Colors.grey,
                //   // backgroundImage:
                //   //     useBackgroundImage ? 'assets/card_bg.png' : null,
                //   // isSwipeGestureEnabled: true,
                //   // onCreditCardWidgetChange:
                //   //     (CreditCardBrand creditCardBrand) {},
                //   // customCardTypeIcons: <CustomCardTypeIcon>[
                //   //   CustomCardTypeIcon(
                //   //     cardType: CardType.mastercard,
                //   //     cardImage: Image.asset(
                //   //       'assets/mastercard.png',
                //   //       height: 48,
                //   //       width: 48,
                //   //     ),
                //   //   ),
                //   // ],
                // ),

                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    "Type your card details",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: number,
                    decoration: InputDecoration(hintText: 'Card Number'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: TextField(
                    controller: cardholdername,
                    decoration: InputDecoration(hintText: 'Card holder name'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: TextField(
                    controller: valid,
                    decoration: InputDecoration(hintText: 'Valid thru'),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: Color(0xff7EDABF),
                      onChanged: (value) {
                        setState(() {
                          isChecked = value;
                        });
                      },
                      value: isChecked == null ? false : isChecked,
                    ),
                    Text(
                      "Mark card as a default for all payments",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstant.fontRegular,
                          fontSize: 14),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    validation();

                    /*     showDetailsVerifyDialog();*/
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 26),
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(13)),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "CHECKOUT",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Image.asset(
                            Res.ic_right_arrow,
                            width: 17,
                            height: 17,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void showDetailsVerifyDialog() {
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
                      height: 260.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  child: Image.asset(
                                    Res.ic_cross,
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.cover,
                                  ),
                                  padding: EdgeInsets.only(right: 16),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              Res.ic_package_success,
                              width: 150,
                              height: 80,
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
                                    left: 16, top: 10, right: 16),
                                child: Text(
                                  "Payment Completed\nSuccessfully!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontRegular,
                                      fontSize: 16),
                                )),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: Container(
                              height: 35,
                              width: 120,
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  color: AppConstant.appColor,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Center(
                                child: Text(
                                  "View Booking",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            )));
  }

  void validation() {
    if (number.text.isEmpty) {
      Utils.showToast("Enter Card Number");
    } else if (cardholdername.text.isEmpty) {
      Utils.showToast("Enter Card Holder Name");
    } else if (valid.text.isEmpty) {
      Utils.showToast("Enter Valid ");
    } else {
      //  addCardDetail();
    }
  }

  // Future<BeanAddCard> addCardDetail() async {
  //   _progressDialog.show();
  //   try {
  //     FormData from = FormData.fromMap({
  //       "token": "123456789",
  //       "userid": "77",
  //       "card_number": number.text.toString(),
  //       "valid_thru": valid.text.toString(),
  //       "holder_name": cardholdername.text.toString(),
  //       "is_default": "y"
  //     });
  //     BeanAddCard bean = await ApiProvider().beanAddcard(from);
  //     print(bean.data);
  //     _progressDialog.dismiss();
  //     if (bean.status == true) {
  //       Utils.showToast(bean.message);
  //       setState(() {
  //         valid.clear();
  //         number.clear();
  //         cardholdername.clear();
  //       });
  //     } else {
  //       Utils.showToast(bean.message);
  //     }
  //   } on HttpException catch (exception) {
  //     _progressDialog.dismiss();
  //     print(exception);
  //   } catch (exception) {
  //     _progressDialog.dismiss();
  //     print(exception);
  //   }
  // }
  //
  // Future<BeanGetCard> getCard(BuildContext context) async {
  //   _progressDialog.show();
  //   try {
  //     FormData from = FormData.fromMap({
  //       "token": "123456789",
  //       "userid": "77",
  //     });
  //     BeanGetCard bean = await ApiProvider().beanGetCard(from);
  //     print(bean.data);
  //     _progressDialog.dismiss();
  //     if (bean.status == true) {
  //       Utils.showToast(bean.message);
  //       setState(() {
  //         holderName = bean.data[0].holderName;
  //         numbercard = bean.data[0].cardNumber;
  //         expirydate = bean.data[0].validThru;
  //       });
  //     } else {
  //       Utils.showToast(bean.message);
  //     }
  //   } on HttpException catch (exception) {
  //     _progressDialog.dismiss();
  //     print(exception);
  //   } catch (exception) {
  //     _progressDialog.dismiss();
  //     print(exception);
  //   }
  // }

}
