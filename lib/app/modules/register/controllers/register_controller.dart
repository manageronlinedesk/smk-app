import 'package:flutter/material.dart';
import 'package:flutter_getx_template/app/core/base/base_controller.dart';
import 'package:flutter_getx_template/app/core/values/app_values.dart';
import 'package:flutter_getx_template/app/data/model/customer.dart';
import 'package:flutter_getx_template/app/data/model/otp_response.dart';
import 'package:flutter_getx_template/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../core/widget/custom_loading.dart';

class RegisterController extends BaseController {
  //TODO: Implement RegisterController
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController mPinController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController loginController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> register(BuildContext context) async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    final mobileNumber = mobileNumberController.text.trim();
    final mPin = mPinController.text.isNotEmpty ? mPinController.text : null;

    try {
      CustomLoading.showLoading(context);
      Customer customer = Customer(
          // statusCode: 0, description: '',
          response: ApiResponse(statusCode: 0, description: ''), token: '',
          data: [ UserData(id: 0, userId: "", adminId: AppValues.adminId, name: username, email: '', mobileNo: mobileNumber, password: password, address: '', userType: 2, mPin: mPin.toString(), accountBalance: '', accountStatus: 1, isMobileVerified: 0, paymentId: '', datetime: '',)]
      );

      // Creating Account
      Customer response = await apiDataSource.register(customer: customer);

      print(response.response.statusCode);
        // Sending OTP After Successfully Account Created
        OtpResponse otpResponse = await apiDataSource.sendOtp(mobileNumber: mobileNumber);
        showToast(context: context, message: otpResponse.error.toString());
        if(otpResponse.statusCode == 200){
          if(response.response.statusCode == 201) {
            showToast(
                context: context, message: response.response.description!);
          }
          Get.back(); // close loading
          Get.toNamed(Routes.OTPSCREEN, arguments: {'mobileNumber': mobileNumber});
          showToast(context: context, message: otpResponse.description!);
        }
        else{
          Get.back(); // close loading
        }

    } catch (e) {
      Get.back(); // close loading
      showToast(context: context, message: e.toString());
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
}
