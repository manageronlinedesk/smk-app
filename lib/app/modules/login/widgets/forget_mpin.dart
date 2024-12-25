import 'package:flutter/material.dart';
import 'package:flutter_getx_template/app/core/widget/custom_Button.dart';
import 'package:flutter_getx_template/app/core/widget/custom_text_input_fields.dart';
import 'package:flutter_getx_template/app/modules/login/controllers/login_controller.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widget/custom_input_field_bid_place.dart';

class ForgetMpinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change MPIN',
            style: TextStyle(color: AppColors.colorWhite)),
        iconTheme: const IconThemeData(
            color: AppColors.colorWhite), // Set the icon color here
        backgroundColor: AppColors.gameAppBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                CustomTextInputField(
                  title: "Mobile Number",
                  maxLength: 10,
                  readOnly: controller.isOtpSent.value ? true : false,
                  hintText: 'Enter your mobile number',
                  titleStyle: titleBlackW500,
                  keyboardType: TextInputType.number,
                  isMandatory: true,
                  controller:
                  controller.forgetMpinMobileNumberController,
                  isObscure: false,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextInputField(
                  title: "New MPIN",
                  maxLength: 4,
                  readOnly: controller.isOtpSent.value ? true : false,
                  hintText: 'Enter New MPIN',
                  titleStyle: titleBlackW500,
                  keyboardType: TextInputType.number,
                  isMandatory: true,
                  controller: controller.forgetMpinNumberController,
                  isObscure: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextInputField(
                  title: "Confirm MPIN",
                  maxLength: 4,
                  isMandatory: true,
                  readOnly: controller.isOtpSent.value ? true : false,
                  hintText: 'Enter Confirm MPIN',
                  keyboardType: TextInputType.number,
                  titleStyle: titleBlackW500,
                  controller: controller.forgetConfirmMpinNumberController,
                  isObscure: true,
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
            Obx(() => controller.isOtpSent.value
                ? Column(
                    children: [
                      CustomTextInputField(
                        title: "OTP",
                        maxLength: 6,
                        isMandatory: true,
                        hintText: 'Enter OTP',
                        keyboardType: TextInputType.number,
                        titleStyle: titleBlackW500,
                        controller: controller.forgetMpinOTPController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  )
                : const SizedBox.shrink()),
            Obx(
              () => controller.isOtpSent.value
                  ? CustomButton(
                      text: 'Verify OTP',
                      onPressed: () {
                        final otpCode = controller.forgetMpinOTPController.text.trim();
                        controller.closeKeyboard(context);
                        controller.verifyOtp(context, otpCode: otpCode);
                      },
                    )
                  : CustomButton(
                      text: 'Change MPIN',
                      onPressed: () {
                        controller.closeKeyboard(context);
                        controller.sendOtpForForgetMpin(context);
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
