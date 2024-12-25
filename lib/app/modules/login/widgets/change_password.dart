import 'package:flutter/material.dart';
import 'package:flutter_getx_template/app/core/widget/custom_Button.dart';
import 'package:flutter_getx_template/app/core/widget/custom_text_input_fields.dart';
import 'package:flutter_getx_template/app/modules/login/controllers/login_controller.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widget/custom_input_field_bid_place.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginController controller = LoginController();
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
            CustomTextInputField(
              title: "New MPIN",
              maxLength: 4,
              hintText: 'Enter New MPIN',
              keyboardType: TextInputType.number,
              titleStyle: titleBlackW500,
              isMandatory: true,
              controller: controller.newMpinController,
              isObscure: true,
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextInputField(
              title: "Confirm MPIN",
              maxLength: 4,
              isMandatory: true,
              keyboardType: TextInputType.number,
              hintText: 'Enter Confirm MPIN',
              titleStyle: titleBlackW500,
              controller: controller.newConfirmMpinController,
              isObscure: true,
            ),
            const SizedBox(
              height: 16,
            ),
            CustomButton(
              text: 'Change MPIN',
              onPressed: () {
                controller.closeKeyboard(context);
                controller.changeMpin(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
