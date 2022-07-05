// ignore_for_file: unnecessary_statements


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kitchen/model/GetAccountDetail.dart';
import 'package:kitchen/model/UpdateMenuDetails.dart';
import 'package:kitchen/network/ApiProvider.dart';
import 'package:kitchen/res.dart';
import 'package:kitchen/utils/Constents.dart';
import 'package:kitchen/utils/HttpException.dart';
import 'package:kitchen/utils/Utils.dart';
import 'package:kitchen/utils/progress_dialog.dart';

class KitchenDetailScreen extends StatefulWidget {
  final GetAccountDetails accDetails;

  const KitchenDetailScreen({Key key, @required this.accDetails})
      : super(key: key);
  @override
  _KitchenDetailScreenState createState() => _KitchenDetailScreenState();
}

class _KitchenDetailScreenState extends State<KitchenDetailScreen> {
  var timeFrom = TextEditingController();
  var timeTo = TextEditingController();
  int _radioValue = -1;
  Future future;
  List<String> food = [];
  List<String> day = [];
  List<String> meal = [];
  var type1 = "";
  var typ2 = "";
  var type3 = "";
  bool checkMeals = false;
  bool checkFood = false;
  bool checkDays = false;
  TimeOfDay selectedTime = TimeOfDay.now();
  var _description = TextEditingController();

  ProgressDialog progressDialog;

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

  checkmeal() {
    for (int i = 0; i < meals.length; i++) {
      if (widget.accDetails.data.typeOfMeals.contains(meals[i].title)) {
        meals[i].isCheckedMeals = true;
      } else {}
    }
  }

  checkdays() {
    for (int i = 0; i < days.length; i++) {
      if (widget.accDetails.data.openDays.contains(days[i].title)) {
        days[i].isCheckedDays = true;
      } else {}
    }
  }

  checktypeoffood() {
    for (int i = 0; i < choices.length; i++) {
      if (widget.accDetails.data.typeOfFood.contains(choices[i].title)) {
        choices[i].isChecked = true;
      } else {}
    }
  }

  @override
  void initState() {
    super.initState();
    checkmeal();
    checkdays();
    checktypeoffood();
    setState(() {
      _description.text = widget.accDetails.data.description;
      _radioValue = int.parse(widget.accDetails.data.typeOfFirm);
      // timeFrom.text = widget.accDetails.data.fromTime.substring(0, 5);
      // timeTo.text = (widget.accDetails.data.toTime.substring(6, 8) == 'PM')
      //     ? (int.parse(widget.accDetails.data.toTime.substring(0, 2)) + 12)
      //             .toString() +
      //         widget.accDetails.data.toTime.substring(2, 5)
      //     : widget.accDetails.data.toTime.substring(0, 5);
      timeFrom.text = widget.accDetails.data.fromTime;
      timeTo.text = widget.accDetails.data.toTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 1, top: 40),
                height: 60,
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        Res.ic_right_arrow,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Kitchens Details",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "Type of Firm",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  new Radio(
                    value: 0,
                    groupValue: _radioValue,
                    activeColor: Color(0xff7EDABF),
                    onChanged: _handleRadioValueChange,
                  ),
                  new Text(
                    'Kitchen only for delivery',
                    style: new TextStyle(
                        fontSize: 14, fontFamily: AppConstant.fontRegular),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: _radioValue,
                    activeColor: Color(0xff7EDABF),
                    onChanged: _handleRadioValueChange,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 1),
                    child: Text(
                      'Restaurants for delivery',
                      style: new TextStyle(
                          fontSize: 14, fontFamily: AppConstant.fontRegular),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "What type of food you provide",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 16),
                ),
              ),
              Container(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 1,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: List.generate(choices.length, (index) {
                    return getTypeOfFood(choices[index], index);
                  }),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Operation Timings of kitchen",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 16),
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16, top: 16),
                        child: Text(
                          "Time From",
                          style: TextStyle(color: AppConstant.appColor),
                        ),
                      ),
                      Row(
                        children: [
                             Container(
                              width: 100,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 16, top: 16),
                                  child: TextField(
                                    controller: timeFrom,
                                    decoration: InputDecoration(hintText: "00:00"),
                                  )),
                            ),
                          GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectTime(context, timeFrom);
                        timeFrom;
                      });
                    },
                    child: Container(
                        margin: EdgeInsets.only(top: 16, right: 16),
                        child: Image.asset(
                          Res.ic_time_circle,
                          width: 15,
                          height: 15,
                          color: Colors.grey,
                        )),
                  ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 50, top: 16),
                        child: Text(
                          "Time To",
                          style: TextStyle(color: AppConstant.appColor),
                        ),
                      ),
                      Row(
                        children: [
                             Container(
                              width: 150,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 50, top: 16),
                                  child: TextField(
                                    controller: timeTo,
                                    decoration: InputDecoration(hintText: "00:00"),
                                  )),
                            ),
                          GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectTime(context, timeTo);
                        timeTo;
                      });
                    },
                    child: Container(
                        margin: EdgeInsets.only(top: 16, right: 16),
                        child: Image.asset(
                          Res.ic_time_circle,
                          width: 15,
                          height: 15,
                          color: Colors.grey,
                        )),
                  ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Operation Day & Respective Timings",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                // height: 150,
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 3 / 1,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(days.length, (index) {
                    return getDays(days[index], index);
                  }),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Type Of Meals you",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 16),
                ),
              ),
              Container(
                // height: 140,
                child: GridView.count(
                  crossAxisCount: 2,
                 childAspectRatio: 4 / 1,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(meals.length, (index) {
                    return getMeals(meals[index], index);
                  }),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Description",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _description,
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter description here...'),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  validatin();
                },
                child: Container(
                  height: 55,
                  margin:
                      EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
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
          ),
          physics: BouncingScrollPhysics(),
        ));
  }

  void validatin() {
    var time = timeFrom.text.toString();
    var timeto = timeTo.text.toString();
    if (_radioValue == -1) {
      Utils.showToast("Please add type of firm");
    } else if (time.isEmpty) {
      Utils.showToast("Please add form time");
    } else if (timeto.isEmpty) {
      Utils.showToast("Please add to time");
    } else {
      apiCall(time, timeto);
    }
  }

  Future<UpdateMenuDetail> updateMenuSetting(String time, String timeto,
      bool checkFood, bool checkMeals, bool checkDays) async {
    progressDialog.show();
    var user = await Utils.getUser();
    try {
      FormData data = FormData.fromMap({
        "token": "123456789",
        "user_id": user.data.id,
        "type_of_firm": _radioValue == 0 ? "0" : "1",
        //"type_of_food": json.encode(food.toString()),
        "type_of_food": food
            .toString()
            .replaceAll("[", "")
            .replaceAll("]", "")
            .replaceAll(" ", ""),
        "from_time": time.toString(),
        "to_time": timeto.toString(),
        //"open_days": json.encode(day.toString()),
        "open_days": day
            .toString()
            .replaceAll("[", "")
            .replaceAll("]", "")
            .replaceAll(" ", ""),
        //"type_of_meals": json.encode(meal.toString()),
        "type_of_meals": meal
            .toString()
            .replaceAll("[", "")
            .replaceAll("]", "")
            .replaceAll(" ", ""),
        'description': _description.text.toString(),
      });
      UpdateMenuDetail bean = await ApiProvider().updateMenuSetting(data);
      //print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        Utils.showToast(bean.message);
        Navigator.pop(context, true);
      } else {
        Utils.showToast(bean.message);
      }
    } on HttpException {
      progressDialog.dismiss();
    } catch (exception) {
      progressDialog.dismiss();
    }
  }

  Widget getTypeOfFood(Choice choic, int index) {
    return Row(
      children: [
        Checkbox(
          activeColor: Color(0xff7EDABF),
          onChanged: (value) {
            setState(() {
              choic.isChecked = value;
            });
          },
          value: choic.isChecked == null ? false : choic.isChecked,
        ),
        Text(
          choic.title,
          style: TextStyle(
              color: Colors.black,
              fontFamily: AppConstant.fontRegular,
              fontSize: 14),
        ),
      ],
    );
  }

  Widget getDays(Days day, int index) {
    return (Row(
      children: [
        Checkbox(
          activeColor: Color(0xff7EDABF),
          onChanged: (value) {
            setState(() {
              day.isCheckedDays = value;
            });
          },
          value: day.isCheckedDays == null ? false : day.isCheckedDays,
        ),
        Text(
          day.title,
          style: TextStyle(
              color: Colors.black,
              fontFamily: AppConstant.fontRegular,
              fontSize: 14),
        ),
      ],
    ));
  }

  Widget getMeals(Meals meals, int index) {
    return Row(
      children: [
        Checkbox(
          activeColor: Color(0xff7EDABF),
          onChanged: (value) {
            setState(() {
              meals.isCheckedMeals = value;
            });
          },
          value: meals.isCheckedMeals == null ? false : meals.isCheckedMeals,
        ),
        Text(
          meals.title,
          style: TextStyle(
              color: Colors.black,
              fontFamily: AppConstant.fontRegular,
              fontSize: 14),
        ),
      ],
    );
  }

  void apiCall(String time, String timeto) {
    choices.forEach((data) {
      if (data.isChecked) {
        food.add(data.title);
        print("food" + food.toString());
        type1 = "first";
        checkFood = data.isChecked;
      }
    });
    days.forEach((data) {
      if (data.isCheckedDays) {
        day.add(data.title);
        print("day" + day.toString());
        typ2 = "second";
        checkDays = data.isCheckedDays;
      }
    });
    meals.forEach((data) {
      if (data.isCheckedMeals) {
        meal.add(data.title);
        checkMeals = data.isCheckedMeals;
        type3 = "third";
      }
    });
    if (type1 == "first" && typ2 == "second" && type3 == "third") {
      updateMenuSetting(time, timeto, checkFood, checkMeals, checkDays);
      checkMeals = false;
    } else {
      Utils.showToast("Please check types");
    }
  }
  _selectTime(BuildContext context, TextEditingController time) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        var type = (timeOfDay.hour >= 12) ? 'PM' : 'AM';
        time.text = timeOfDay.hour.toString() +
            ":" +
            timeOfDay.minute.toString() +
            ' $type';
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('You cannot Select present time'),
      ));
    }
  }
}

class Choice {
  Choice({this.title, this.isChecked});
  String title;
  bool isChecked = false;
}

class Days {
  Days({this.title, this.isCheckedDays});
  String title;
  bool isCheckedDays = false;
}

class Meals {
  Meals({this.title, this.isCheckedMeals});
  String title;
  bool isCheckedMeals = false;
}

List<Choice> choices = <Choice>[
  Choice(title: 'NorthIndianMeals', isChecked: false),
  Choice(title: 'SouthIndianMeals', isChecked: false),
  Choice(title: 'DietMeals', isChecked: false),
  Choice(title: 'Others', isChecked: false),
];

List<Days> days = <Days>[
  Days(title: 'Sunday', isCheckedDays: false),
  Days(title: 'Monday', isCheckedDays: false),
  Days(title: 'Tuesday', isCheckedDays: false),
  Days(title: 'Wednesday', isCheckedDays: false),
  Days(title: 'Thursday', isCheckedDays: false),
  Days(title: 'Friday', isCheckedDays: false),
  Days(title: 'Saturday', isCheckedDays: false),
];

List<Meals> meals = <Meals>[
  Meals(title: 'Breakfast', isCheckedMeals: false),
  Meals(title: 'Lunch&Dinner', isCheckedMeals: false),
  // Meals(title: 'Dinner', isCheckedMeals: false),
  Meals(title: 'Veg', isCheckedMeals: false),
  Meals(title: 'NonVeg', isCheckedMeals: false),
];
