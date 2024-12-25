import 'package:flutter_getx_template/app/core/base/base_controller.dart';
import 'package:flutter_getx_template/app/core/widget/custom_loading.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/otp_response.dart';
import '../../../routes/app_pages.dart';

class OtpScreenController extends BaseController {

  final OtpFieldController otpFieldController = OtpFieldController();
  RxString mobileNumber = ''.obs;

  @override
  Future<void> onInit() async{
    super.onInit();
    mobileNumber.value = Get.arguments['mobileNumber'];
  }

  Future<void> verifyOtp({required BuildContext context, required otpCode}) async {
    try {
      CustomLoading.showLoading(context);
      OtpResponse response = await apiDataSource.verifyOtp(mobileNumber: mobileNumber.value, otpCode: otpCode);
      if(response.statusCode == 200){
        showToast(context: context, message: response.description!);
        Get.back(); // close loading
        Get.toNamed(Routes.LOGIN);
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
}
