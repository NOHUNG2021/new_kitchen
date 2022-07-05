import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kitchen/model/AddCategory.dart';
import 'package:kitchen/model/AddCategoryItem.dart';
import 'package:kitchen/model/AddOffer.dart';
import 'package:kitchen/model/BeanAddAccount.dart';
import 'package:kitchen/model/BeanAddLunch.dart';
import 'package:kitchen/model/BeanAddMenu.dart';
import 'package:kitchen/model/BeanAddPackage.dart';
import 'package:kitchen/model/BeanAddPackageMeal.dart';
import 'package:kitchen/model/BeanAddPackagePrice.dart';
import 'package:kitchen/model/BeanApplyOrderFilter.dart';
import 'package:kitchen/model/BeanDeletePackage.dart';
import 'package:kitchen/model/BeanDinnerAdd.dart';
import 'package:kitchen/model/BeanForgotPassword.dart';
import 'package:kitchen/model/BeanGetDashboard.dart';
import 'package:kitchen/model/BeanGetOrderRequest.dart';
import 'package:kitchen/model/BeanGetPackages.dart';
import 'package:kitchen/model/BeanLogin.dart';
import 'package:kitchen/model/BeanOrderAccepted.dart';
import 'package:kitchen/model/BeanOrderRejected.dart';
import 'package:kitchen/model/BeanPackagePriceDetail.dart';
import 'package:kitchen/model/BeanPayment.dart';
import 'package:kitchen/model/BeanSaveMenu.dart';
import 'package:kitchen/model/BeanSendMessage.dart';
import 'package:kitchen/model/BeanSignUp.dart';
import 'package:kitchen/model/BeanUpdateMenuStock.dart';
import 'package:kitchen/model/BeanUpdateSetting.dart';
import 'package:kitchen/model/EditCategory.dart';
import 'package:kitchen/model/EditCategoryItem.dart';
import 'package:kitchen/model/EditOffer.dart';
import 'package:kitchen/model/GetAccountDetail.dart';
import 'package:kitchen/model/GetActiveOrder.dart';
import 'package:kitchen/model/GetArchieveOffer.dart';
import 'package:kitchen/model/GetCategories.dart';
import 'package:kitchen/model/GetCategoryDetails.dart';
import 'package:kitchen/model/GetCategoryItemDetails.dart';
import 'package:kitchen/model/GetCategoryItems.dart';
import 'package:kitchen/model/GetChat.dart';
import 'package:kitchen/model/GetFeedback.dart';
import 'package:kitchen/model/GetLiveOffer.dart';
import 'package:kitchen/model/GetOfferDetail.dart';
import 'package:kitchen/model/GetOrderTrialRequest.dart';
import 'package:kitchen/model/GetPayment.dart';
import 'package:kitchen/model/GetTrackDeliveries.dart';
import 'package:kitchen/model/GetUpComingOrder.dart';
import 'package:kitchen/model/GetorderHistory.dart';
import 'package:kitchen/model/ReadyToPickupOrder.dart';
import 'package:kitchen/model/UpdateMenuDetails.dart';
import 'package:kitchen/model/bankaccountsmodel.dart';
import 'package:kitchen/model/breakfastmodel.dart';
import 'package:kitchen/model/getKitcheStatus.dart';
import 'package:kitchen/model/getMealScreenItems.dart';
import 'package:kitchen/model/rearrageCategory.dart';
import 'package:kitchen/model/rearrageCategoryItems.dart';
import 'package:kitchen/model/start_delivery.dart';
import 'package:kitchen/model/updateItemStock.dart';
import 'package:kitchen/model/updatePackageAvailability.dart';
import 'package:kitchen/network/EndPoints.dart';
import 'package:kitchen/utils/DioLogger.dart';

class ApiProvider {
  static const _baseUrl =
      "https://nohungkitchen.notionprojects.tech/api/kitchen/";
  //static const _baseUrl = "https://nohung.com/api/kitchen/";
  static const String TAG = "ApiProvider";

  Dio _dio;
  DioError _dioError;

  ApiProvider() {
    BaseOptions dioOptions = BaseOptions()..baseUrl = ApiProvider._baseUrl;
    _dio = Dio(dioOptions);
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers = {
        'Content-Type': 'multipart/form-data',
      };
      DioLogger.onSend(TAG, options);
      return handler.next(options);
    }, onResponse:  (response, handler) {
      DioLogger.onSuccess(TAG, response);
      return handler.next(response);
    }, onError: (error, handler) {
      DioLogger.onError(TAG, error);
      return  handler.next(error);
    }));
  }

  Future registerUser(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.register, data: params);
      return BeanSignUp.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future loginUser(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.login, data: params);
      print(" ${response.data} JanniData ");
      return BeanLogin.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
  }

  Future<BeanPayment> beanPayment(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.withdraw_payment, data: params);
      return BeanPayment.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future delete_Menu_item(FormData params) async {
    Response response =
        await _dio.post(EndPoints.delete_menu_item, data: params);
    return json.decode(response.data);
  }

  Future getState(FormData params) async {
    Response response = await _dio.post(EndPoints.get_state, data: params);
    return json.decode(response.data);
  }

  Future deleteOffer(FormData params) async {
    Response response = await _dio.post(EndPoints.delete_offer, data: params);
    return json.decode(response.data);
  }

  Future getCity(FormData params) async {
    Response response = await _dio.post(EndPoints.get_city, data: params);
    return json.decode(response.data);
  }

  Future<BeanAddMenu> getMenuPackageList(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_package_info, data: params);
      return BeanAddMenu.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future updateOrderTrack(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.track_delivery_map, data: params);
      return BeanStartDelivery.fromJson(jsonDecode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanAddAccount> beanAddAccount(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.add_account_details, data: params);
      return BeanAddAccount.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanSaveMenu> beanSaveMenu(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.add_breakfast_menu, data: params);
      return BeanSaveMenu.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future uploadProfileImage(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.update_profile_image, data: params);
      return BeanSaveMenu.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanLunchAdd> beanLunchAdd(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.add_lunch_dinner_menu, data: params);
      return BeanLunchAdd.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanDinnerAdd> beanDinnerAdd(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.add_dinner_menu, data: params);
      return BeanDinnerAdd.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanForgotPassword> forgotPassword(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.forgot_password, data: params);
      return BeanForgotPassword.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BreakfastModel> beanGetLunch(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_lunch_dinner_menu, data: params);
      return BreakfastModel.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BreakfastModel> beanGetDinner(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_dinner_menu, data: params);
      return BreakfastModel.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getArchieveOffer(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_archive_offer, data: params);
      return GetArchieveOffer.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetOfferDetail> getOfferDetail(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_offer_detail, data: params);
      return GetOfferDetail.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanGetDashboard> beanGetDashboard(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_dashboard_detail, data: params);
      return BeanGetDashboard.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetFeedback> getFeedback(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.get_feedback, data: params);

      return GetFeedback.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BreakfastModel> getMenu(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.get_menu, data: params);
      return BreakfastModel.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanGetOrderRequest> getOrderRequest(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_orders_requests, data: params);
      return BeanGetOrderRequest.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetUpComingOrder> getUpComingOrder(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_upcoming_orders, data: params);
      return GetUpComingOrder.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetActiveOrder> getActiveOrder(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_active_orders, data: params);
      return GetActiveOrder.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<ReadyToPickupOrder> readyToPickupOrder(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.ready_to_pick_order, data: params);
      return ReadyToPickupOrder.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetorderHistory> getOrderHistory(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_order_history, data: params);
      return GetorderHistory.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetOrderTrialRequest> geTrialRequest(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_orders_trial_requests, data: params);
      return GetOrderTrialRequest.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetTrackDeliveries> geTrackDeliveries(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_track_deliveries, data: params);
      return GetTrackDeliveries.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanOrderAccepted> ordeAccept(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.accept_order, data: params);
      return BeanOrderAccepted.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanOrderRejected> ordeReject(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.reject_order, data: params);
      return BeanOrderRejected.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<MealScreenItems> getMealScreenItems(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_package_meal, data: params);
      return MealScreenItems.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetPayment> getPay(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_transaction, data: params);
      return GetPayment.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanSendMessage> sendMessage(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.send_message, data: params);
      return BeanSendMessage.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetChat> getChat(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.get_chat, data: params);
      return GetChat.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future updateSetting(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.update_settings, data: params);
      return BeanUpdateSetting.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future updateMenuSetting(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.update_account_detail, data: params);
      return UpdateMenuDetail.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getLiveOffers(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_live_offer, data: params);
      return GetLiveOffer.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanGetPackages> getPackages(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.get_package, data: params);
      return BeanGetPackages.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanApplyOrderFilter> applyOrderFilter(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.apply_order_filter, data: params);
      return BeanApplyOrderFilter.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanAddPackageMeals> addPackageMeal(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.add_package_meal, data: params);
      return BeanAddPackageMeals.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanPackagePriceDetail> getPackagePriceDetail(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_package_price_detail, data: params);
      return BeanPackagePriceDetail.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<MealScreenItems> getSelectedItem(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_selected_item, data: params);
      return MealScreenItems.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanAddPackagePrice> addPackagePrice(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.add_package_price, data: params);
      return BeanAddPackagePrice.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanDeletePackage> deletePackage(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.delete_package, data: params);
      return BeanDeletePackage.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<KitchenStatus> updateKitchenAvailability( FormData value) async {
    try {
      Response response =
          await _dio.post(EndPoints.update_available_status, data: value);
      return KitchenStatus.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future<BeanUpdateMenuStock> updateMenuStock(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.update_menu_stock, data: params);
      return BeanUpdateMenuStock.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<BeanAddPackage> addPackage(FormData params) async {
    try {
      var response = await _dio.post(EndPoints.add_package, data: params);
      var Response = BeanAddPackage.fromJson(json.decode(response.data));
      return Response;
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future<BeanAddPackage> updatePackage(FormData params) async {
    try {
      var response = await _dio.post(EndPoints.update_package, data: params);
      var Response = BeanAddPackage.fromJson(json.decode(response.data));
      return Response;
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future getAccountDetails(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_account_detail, data: params);
      return GetAccountDetails.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future getBankAccounts(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.get_bank_accounts, data: params);
      return BankAccountsModel.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future Editbankacc(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.edit_bank_account, data: params);
      return json.decode(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future Deletebankaacount(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.delete_bank_account, data: params);
      return json.decode(response.data);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future addOffer(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.add_offer, data: params);
      return AddOffer.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future editOffer(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.update_offer, data: params);
      return EditOffer.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  void throwIfNoSuccess(String response) {
    throw new HttpException(response);
  }

  Future getCategories(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.all_category, data: params);
      return GetCategories.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future<GetCategoryDetails> getCategoryDetail(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.category_details, data: params);
      return GetCategoryDetails.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future addCategory(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.add_category, data: params);
      return AddCategory.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<GetCategoryItemDetails> getCategoryItemDetail(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.category_item_details, data: params);
      return GetCategoryItemDetails.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future editCategory(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.update_category, data: params);
      return EditCategory.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future deleteCategory(FormData params) async {
    Response response = await _dio.post(EndPoints.delete_category, data: params);
    return json.decode(response.data);
  }
  Future getCategoryItems(FormData params) async {
    try {
      Response response =
          await _dio.post(EndPoints.category_items, data: params);
      return GetCategoryItems.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future addCategoryItem(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.add_item_to_category, data: params);
      return AddCategoryItem.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future editCategoryItem(FormData params) async {
    try {
      Response response = await _dio.post(EndPoints.update_category_item, data: params);
      print("JAAAAA" + response.statusMessage);
      return EditCategoryItem.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future deleteCategoryItem(FormData params) async {
    Response response = await _dio.post(EndPoints.delete_category_item, data: params);
    return json.decode(response.data);
  }

  Future<UpdateItemStock> updateItemInstock( FormData value) async {
    try {
      Response response =
          await _dio.post(EndPoints.update_item_instock_status, data: value);
      return UpdateItemStock.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<UpdatePackageAvailability> updatePackageStatus( FormData value) async {
    try {
      Response response =
          await _dio.post(EndPoints.change_package_status, data: value);
      return UpdatePackageAvailability.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
  Future<RearrangeCategory> reArrangeCategory( FormData value) async {
    try {
      Response response =
          await _dio.post(EndPoints.rearrange_category, data: value);
      return RearrangeCategory.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
    Future<RearrangeCategoryItems> reArrangeCategoryItems( FormData value) async {
    try {
      Response response =
          await _dio.post(EndPoints.rearrange_category_items, data: value);
      return RearrangeCategoryItems.fromJson(json.decode(response.data));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      Map<dynamic, dynamic> map = _dioError.response.data;
      if (_dioError.response.statusCode == 500) {
        throwIfNoSuccess(map['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }
}
