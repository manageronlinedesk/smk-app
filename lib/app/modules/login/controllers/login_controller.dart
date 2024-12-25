import 'package:flutter/material.dart';
import 'package:flutter_getx_template/app/core/base/base_controller.dart';
import 'package:flutter_getx_template/app/core/values/app_values.dart';
import 'package:flutter_getx_template/app/core/widget/custom_loading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/model/get_contact_info_model.dart';
import '../../../core/widget/custom_show_alert.dart';
import '../../../data/model/config_details_model.dart';
import '../../../data/model/customer.dart';
import '../../../data/model/otp_response.dart';
import '../../../network/exceptions/base_exception.dart';
import '../../../routes/app_pages.dart';
import '../widgets/m_pin_widget.dart';

double statusCode = 200;

class LoginController extends BaseController {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController forgotController = TextEditingController();
  final TextEditingController registerController = TextEditingController();

  final TextEditingController newMpinController= TextEditingController();
  final TextEditingController newConfirmMpinController= TextEditingController();

  final TextEditingController forgetMpinNumberController= TextEditingController();
  final TextEditingController forgetConfirmMpinNumberController= TextEditingController();
  final TextEditingController forgetMpinMobileNumberController = TextEditingController();
  final TextEditingController forgetMpinOTPController = TextEditingController();
  RxBool isOtpSent = false.obs;
  RxString forgetMpinMobileNumber = ''.obs;

  final formKey = GlobalKey<FormState>();

  RxString mPin = ''.obs;
  bool isLogin=false;

  RxString mobileno = ''.obs;
  RxString mobileno2 = ''.obs;
  RxString whatsAppNO = ''.obs;
  RxString email = ''.obs;
  RxString instagram = ''.obs;
  RxString twitter = ''.obs;
  RxString faceBook = ''.obs;



  checkLogin() async{
    isLogin = await isLoggedIn() ?? false;
    if(isLogin){
      Get.offAll(MPINScreen());
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchAndSaveContactData();
  }

  Future<bool> fetchAndSaveContactData() async {
    try {
      ResponseModel response = await apiDataSource.getContactInfo(adminId: AppValues.adminId);

      // Ensure that the data list is not empty before accessing its first element.
      if (response.data.isNotEmpty) {
        ContactData responseContactData = response.data.first;

        saveContactData(contactData: responseContactData);

         mobileno.value = responseContactData.mobileno.toString();
         mobileno2.value  = responseContactData.mobileno2.toString();
         whatsAppNO.value  = responseContactData.whatsappno.toString();
         email.value  = responseContactData.email.toString();
         instagram.value  = responseContactData.instagram.toString();
         twitter.value  = responseContactData.twitter.toString();
         faceBook.value  = responseContactData.facebook.toString();

      } else {
        // Handle the case where data is empty.
      }
      return true;
    } catch (exception) {
      logger.e("Error fetching contact data: $exception");
      showErrorMessage(exception.toString());
      return false;
    }
  }

  Future<void> login(BuildContext context) async {
    final username = userNameController.text.trim();
    final mPin = int.tryParse(passwordController.text.trim());

    try {
      CustomLoading.showLoading(context);

      Customer customer = Customer(
          response: ApiResponse(statusCode: 0, description: ''), token: '',
          data: [ UserData(id: 0, userId: "", adminId: '', name: '', email: '', mobileNo: username, password: '', address: '', userType: 2, mPin: mPin.toString(), accountBalance: '', accountStatus: 1, isMobileVerified: 0, paymentId: '', datetime: '',)]
      );
      Customer response = await apiDataSource.login(customer: customer);
      showToast(context: context, message: response.response.description);

      if (response.response.statusCode == statusCode && response.token != null || response.token!.isNotEmpty || response.token != '') {
        await saveUserData(authToken: "${response.token}", name: response.data[0].name, username: response.data[0].mobileNo, userId:  response.data[0].userId,);
        ConfigDetails responseDAta = await apiDataSource.getConfigSetting( adminId: AppValues.adminId);
        await saveConfigData(authToken: "${response.token}", configDetails: responseDAta,  );
        Get.back();
        Get.offAllNamed(Routes.HOME, arguments: response.data[0].accountBalance);
        
      } else {
        Get.back(); // close loading

      }
    } catch (error) {
      Get.back(); // close loading
      showToast(context: context, message: error.toString());
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Credentials'),
          content: const Text('Please Enter Correct Details'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void clearMPin(){
    mPin.value = '';
  }


  Future<void> loginWithMPIN({required BuildContext context, required String mpin}) async {
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? '';
    int mPin = int.tryParse(mpin) ?? 0;
    try {
      CustomLoading.showLoading(context);
      Customer customer = Customer(
          response: ApiResponse(statusCode: 0, description: ''), token: '',
          data: [ UserData(id: 0, userId: "", adminId: '', name: '', email: '', mobileNo: username, password: '', address: '', userType: 2, mPin: mPin.toString(), accountBalance: '', accountStatus: 1, isMobileVerified: 0, paymentId: '', datetime: '',)]
      );
      Customer response =
      await apiDataSource.login(customer: customer);

      if (response.response.statusCode == statusCode && response.token != null || response.token!.isNotEmpty || response.token != '') {
        Get.back(); // close loading
        await saveUserData(authToken: "${response.token}", name: response.data[0].name, username: response.data[0].mobileNo, userId:  response.data[0].userId);
        ConfigDetails responseDAta = await apiDataSource.getConfigSetting( adminId: AppValues.adminId);
        await saveConfigData(authToken: "${response.token}", configDetails: responseDAta,  );
        Get.offAllNamed(Routes.HOME, arguments: response.data[0].accountBalance);
      }
      else {
        Get.back(); // close loading
        clearMPin();
        showToast(context: Get.context!,message: "Login Error: ${response.response.description.toString()}");

      }
    } catch (e) {
      Get.back(); // close loading
      clearMPin();
      showToast(context: Get.context!,message: "Login Error: ${(e as BaseException).message.toString()}");

    }
  }

  Future<void> changeMpin(BuildContext context) async {
    final newPassword = newMpinController.text.trim();
    final confirmPassword = newConfirmMpinController.text.trim();

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      await ShowAlertMessage.showSimpleDialog(
        context,
        title: "validation error",
        message: "Please Enter new password and confirm password",
        isSuccess: false,
      );
      return; // Stop execution if the digit is not valid
    }
    // Check if new password and confirm password match
    if (newPassword != confirmPassword) {
      await ShowAlertMessage.showSimpleDialog(
        context,
        title: "validation error",
        message: "Confirm Password not match!",
        isSuccess: false,
      );
      return; // Stop execution if the digit is not valid
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId =  prefs.getString('userId') ?? '';

    try {
      CustomLoading.showLoading(context);
      Customer response = await apiDataSource.changeMpin(userId: userId , mpin: newPassword );
      if (response.response.statusCode == statusCode) {
        Get.back(); // close loading
      } else {
        Get.back(); // close loading
      }
      showToast(context: context, message: response.response.description);
    } catch (error) {
      Get.back(); // close loading
      showToast(context: context, message: error.toString());
    }
  }

  Future<bool> checkUserExist(BuildContext context) async {
    forgetMpinMobileNumber.value = forgetMpinMobileNumberController.text.trim();

    try {
      Customer response = await apiDataSource.checkUserExist(mobileNumber: forgetMpinMobileNumber.value);
      return response.response.statusCode == 200 && response.data.isNotEmpty;
    } catch (error) {
      showToast(context: context, message: error.toString());
      return false; // Error occurred
    }
  }



  Future<void> sendOtpForForgetMpin(BuildContext context) async {
    forgetMpinMobileNumber.value = forgetMpinMobileNumberController.text.trim();
    final mPin = forgetMpinNumberController.text.trim();
    final confirmMpin = forgetConfirmMpinNumberController.text.trim();

    if (mPin.isEmpty || confirmMpin.isEmpty || forgetMpinMobileNumber.isEmpty) {
      await ShowAlertMessage.showSimpleDialog(
        context,
        title: "validation error",
        message: "Please Enter Mobile, MPIN and Confirm Mpin",
        isSuccess: false,
      );
      return; // Stop execution if the digit is not valid
    }
    // Check if new password and confirm password match
    if (mPin != confirmMpin) {
      await ShowAlertMessage.showSimpleDialog(
        context,
        title: "validation error",
        message: "Confirm MPIN not match!",
        isSuccess: false,
      );
      return; // Stop execution if the digit is not valid
    }

    try {
      CustomLoading.showLoading(context);

      bool userExists = await checkUserExist(context); // Check if the user exists

      if (userExists) { // Proceed only if user exists
        // Sending OTP After Successfully Account Created
        OtpResponse otpResponse = await apiDataSource.sendOtp(mobileNumber: forgetMpinMobileNumber.value);
        showToast(context: context, message: otpResponse.description!);

        if (otpResponse.statusCode == 200) {
          Get.back(); // close loading
          isOtpSent.value = true;
        } else {
          Get.back(); // close loading
        }
      } else {
        Get.back(); // close loading
        // Handle case when user does not exist
        showToast(context: context, message: "User does not exist");
      }
    } catch (error) {
      Get.back(); // close loading
      showToast(context: context, message: error.toString());
    }
  }

  Future<void> verifyOtp(BuildContext context, { required otpCode}) async {
    try {
      CustomLoading.showLoading(context);
      OtpResponse response = await apiDataSource.verifyOtp(mobileNumber: forgetMpinMobileNumber.value, otpCode: otpCode);
      if(response.statusCode == 200){
        showToast(context: context, message: response.description!);
        Get.back(); // close loading

        await changeMPinByMobileNumber(context);
        isOtpSent.value = false;
        forgetMpinMobileNumberController.clear();
        forgetMpinNumberController.clear();
        forgetConfirmMpinNumberController.clear();
        forgetMpinOTPController.clear();

      }else{
        Get.back(); // close loading
        showToast(context: context, message: response.description!);
      }
    } catch (error) {
      Get.back(); // close loading
      showDialog(
        context: Get.context!,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Credentials'),
          content: const Text('Invalid Otp.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> changeMPinByMobileNumber(BuildContext context) async {
    final mpin = forgetMpinNumberController.text.trim();
    try {
      CustomLoading.showLoading(context);
      Customer response = await apiDataSource.changeMpinByMobile(mobileNumber: forgetMpinMobileNumber.value, mPin: mpin);
      if (response.response.statusCode == statusCode) {
        Get.back(); // close loading

        Get.toNamed(Routes.LOGIN);
      } else {
        Get.back(); // close loading
      }
      showToast(context: context, message: response.response.description!);
    } catch (error) {
      showToast(context: context, message: "some error occur");

      Get.back(); // close loading
    }
  }



}
