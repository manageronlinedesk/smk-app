import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_getx_template/app/core/values/app_colors.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/config_details_model.dart';
import '../../data/model/customer.dart';
import '../../data/remote/api_data_source.dart';
import '../../data/remote/api_data_source_impl.dart';
import '../model/get_contact_info_model.dart';
import '../values/app_values.dart';
import '/app/core/model/page_state.dart';
import '/app/network/exceptions/api_exception.dart';
import '/app/network/exceptions/app_exception.dart';
import '/app/network/exceptions/json_format_exception.dart';
import '/app/network/exceptions/network_exception.dart';
import '/app/network/exceptions/not_found_exception.dart';
import '/app/network/exceptions/service_unavailable_exception.dart';
import '/app/network/exceptions/unauthorize_exception.dart';
import '/flavors/build_config.dart';

abstract class BaseController extends GetxController {
  final Logger logger = BuildConfig.instance.config.logger;

  AppLocalizations get appLocalization => AppLocalizations.of(Get.context!)!;

  final logoutController = false.obs;

  //Reload the page
  final _refreshController = false.obs;

  refreshPage(bool refresh) => _refreshController(refresh);

  //Controls page state
  final _pageSateController = PageState.DEFAULT.obs;

  PageState get pageState => _pageSateController.value;

  updatePageState(PageState state) => _pageSateController(state);

  resetPageState() => _pageSateController(PageState.DEFAULT);

  showLoading() => updatePageState(PageState.LOADING);

  hideLoading() => resetPageState();

  final _messageController = ''.obs;

  ApiDataSource apiDataSource = ApiDataSourceImpl();

  String get message => _messageController.value;

  showMessage(String msg) => _messageController(msg);

  final _errorMessageController = ''.obs;

  String get errorMessage => _errorMessageController.value;


  showErrorMessage(String msg) {
    _errorMessageController(msg);
  }

  final _successMessageController = ''.obs;

  String get successMessage => _messageController.value;

  showSuccessMessage(String msg) => _successMessageController(msg);

  // ignore: long-parameter-list
  dynamic callDataService<T>(
    Future<T> future, {
    Function(Exception exception)? onError,
    Function(T response)? onSuccess,
    Function? onStart,
    Function? onComplete,
  }) async {
    Exception? _exception;

    onStart == null ? showLoading() : onStart();

    try {
      final T response = await future;

      if (onSuccess != null) onSuccess(response);

      onComplete == null ? hideLoading() : onComplete();

      return response;
    } on ServiceUnavailableException catch (exception) {
      _exception = exception;
      showErrorMessage(exception.message);
    } on UnauthorizedException catch (exception) {
      _exception = exception;
      showErrorMessage(exception.message);
    } on TimeoutException catch (exception) {
      _exception = exception;
      showErrorMessage(exception.message ?? 'Timeout exception');
    } on NetworkException catch (exception) {
      _exception = exception;
    } on JsonFormatException catch (exception) {
      _exception = exception;
      showErrorMessage(exception.message);
    } on NotFoundException catch (exception) {
      _exception = exception;
      showErrorMessage(exception.message);
    } on ApiException catch (exception) {
      _exception = exception;
    } on AppException catch (exception) {
      _exception = exception;
      showErrorMessage(exception.message);
    } catch (error) {
      _exception = AppException(message: "$error");
      logger.e("Controller>>>>>> error $error");
    }

    if (onError != null) onError(_exception);

    onComplete == null ? hideLoading() : onComplete();
  }


  void showToast({required BuildContext context, required String message}) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message,style: const TextStyle(color: Colors.black),),
        duration: const Duration(seconds: 2,),
        backgroundColor: Colors.grey[300],width: Get.width*0.8,
        behavior: SnackBarBehavior.floating,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),

        animation: CurvedAnimation(
          parent: const AlwaysStoppedAnimation(1),
          curve: Curves.easeOut,
        ),
      ),
    );
  }
  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onClose() {
    _messageController.close();
    _refreshController.close();
    _pageSateController.close();
    super.onClose();
  }




  // Shared preferences related methods
  Future<void> saveUserData({required authToken, required String name, required String username, required String userId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('AuthToken', 'Bearer $authToken');
    await prefs.setBool("isLoggedIn", true);
    await prefs.setString('name', name);
    await prefs.setString('username', username);
    await prefs.setString('userId', userId);
  }

  // Method to save all the values in SharedPreferences
  void saveContactData({required ContactData contactData}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mobileNo', contactData.mobileno.toString());
    await prefs.setString('mobileNo2', contactData.mobileno2.toString());
    await prefs.setString('whatsAppNO', contactData.whatsappno.toString());
    await prefs.setString('twitter', contactData.twitter.toString());
    await prefs.setString('instagram', contactData.instagram.toString());
    await prefs.setString('faceBook', contactData.facebook.toString());
    await prefs.setString('email', contactData.email.toString());
  }

  // ---------------- Get WhatsApp Number ----------------
  Future<String?> getWhatsAppNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("whatsAppNO");
  }

  Future<void> saveConfigData({required authToken,required ConfigDetails configDetails}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('AuthToken', 'Bearer $authToken');
    await prefs.setString('accountholdername', configDetails.accountholdername!);
    await prefs.setString('accountnumber', configDetails.accountnumber!);
    await prefs.setString('ifsccode', configDetails.ifsccode!);
    await prefs.setString('upiid', configDetails.upiid!);
    await prefs.setString('applink', configDetails.applink!);
    await prefs.setString('appmsg', configDetails.appmsg!);
    await prefs.setString('starttime', configDetails.starttime!);
    await prefs.setString('endtime', configDetails.endtime!);
    if (configDetails.mindeposit != null) {
      await prefs.setDouble('mindeposit', configDetails.mindeposit!);
    }
    if (configDetails.maxdeposit != null) {
      await prefs.setDouble('maxdeposit', configDetails.maxdeposit!);
    }
    if (configDetails.minwithdraw != null) {
      await prefs.setDouble('minwithdraw', configDetails.minwithdraw!);
    }
    if (configDetails.maxwithdraw != null) {
      await prefs.setDouble('maxwithdraw', configDetails.maxwithdraw!);
    }
    if (configDetails.minbidamount != null) {
      await prefs.setDouble('minbidamount', configDetails.minbidamount!);
    }
    if (configDetails.minbidamount != null) {
      await prefs.setDouble('maxbidamount', configDetails.maxbidamount!);
    }
    await prefs.setBool('has_admin_config', configDetails.has_admin_config);
    await prefs.setBool('has_app_config', configDetails.has_app_config);
    await prefs.setBool('has_amount_config', configDetails.has_amount_config);
  }

  // ------------------- Getting Auth Token -----------------------
  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('AuthToken');
  }

  // -------------------- check login or not ----------------------
  Future<bool?> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLoggedIn");
  }

  // ---------------- clear shared preference data ----------------
  Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void closeKeyboard(BuildContext context){
    FocusScope.of(context).unfocus();
  }

  Widget showLoadingIndicator(){
    return const Center(child: CircularProgressIndicator(color: AppColors.gameAppBarColor));
  }

}

