import 'package:flutter/material.dart';
import 'package:flutter_getx_template/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_getx_template/app/modules/login/controllers/login_controller.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_values.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widget/custom_Button.dart';
import '../../../core/widget/custom_text_input_fields.dart';
import '../controllers/register_controller.dart';


class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  List<bool> get selectdetails => <bool>[true, false];

  Widget buildWhatsAppContactButton(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    return TextButton(
      onPressed: () async {
        if(loginController.whatsAppNO.isEmpty || loginController.whatsAppNO.value == '' || loginController.whatsAppNO.value == null){
          bool isFetched = await loginController.fetchAndSaveContactData();
          if (!isFetched) {
            // Show error message and exit the method
            controller.showToast(context: Get.context!,message: "Error: Check Internet Connection");
            return;
          }        }
        String? whatAppNumber = await controller.getWhatsAppNumber();
        final phoneNumber = whatAppNumber; // Your phone number
        const message = "Welcome to the Kalyan Live Matka app customer support. If you have any queries, please let me know";

        final String url = "https://wa.me/+91$phoneNumber?text=${Uri.encodeComponent(message)}";
        if (await launch(url)) {
          await launch(url);
        } else {
          controller.showToast(context: context, message: "WhatsApp is not Installed");
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('images/whatsapp1.png', width: 34, color: Colors.greenAccent),
          SizedBox(width: 10),
          Text(
            'Contact us with',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.colorWhite, // Set scaffold background colo
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Center(
                child: Image.asset(
                  'images/app_logo_name.png', // Replace 'assets/icon.png' with the actual path to your image
                  width: Get.width*0.5,
                  height: Get.height*0.2, // Set the desired height
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 80),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                         Row(
                          children: const [
                            Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w300,
                                color: AppColors.gameAppBarColor,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height:AppValues.margin_20,
                        ),
                        CustomTextInputField(
                          title: 'Username',
                          controller: controller.usernameController,
                          titleStyle: primaryColorT14W400,
                          hintText: 'Enter username',
                          isMandatory: true,
                          // checkValidation: isEntryRequired,
                          textCapitalization: TextCapitalization.none,
                        ),
                        const SizedBox(
                          height: AppValues.margin_20,
                        ),
                        CustomTextInputField(
                          title: 'Mobile Number',
                          controller: controller.mobileNumberController,
                          titleStyle: primaryColorT14W400,
                          hintText: 'Enter mobile number',
                          isMandatory: true,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          // checkValidation: isEntryRequired,
                          textCapitalization: TextCapitalization.none,
                        ),
                        const SizedBox(
                          height: AppValues.margin_20,
                        ),
                        CustomTextInputField(
                          title: 'Password',
                          controller: controller.passwordController,
                          titleStyle: primaryColorT14W400,
                          hintText: 'Enter Password',
                          // isObscure: controller.passwordCheck.value,
                          isMandatory:true,
                          // checkValidation: isEntryRequired,
                          // suffixIcon: IconButton(
                          //   onPressed: () {
                          //     // controller.passwordCheck.value = !controller.passwordCheck.value;
                          //   },
                          //   // icon:controller.passwordCheck.value?
                          //   // Icon(Icons.visibility_off,
                          //   //     color: AppColors.colorDark,size: 18)
                          //   //     :Icon(Icons.visibility,color: AppColors.colorDark,size: 18,
                          //   // ),
                          // ),
                          textCapitalization: TextCapitalization.none,

                        ),
                        const SizedBox(
                          height: AppValues.margin_20,
                        ),
                        CustomTextInputField(
                          title: 'M-Pin',
                          controller: controller.mPinController,
                          titleStyle: primaryColorT14W400,
                          hintText: 'Enter M-Pin',
                          isMandatory: true,
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          // checkValidation: isEntryRequired,
                          textCapitalization: TextCapitalization.none,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // TextButton(
                            //   onPressed: () {
                            //     controller.forgotController;
                            //   },
                            //   child: const Text(
                            //     'Forgot Password',
                            //     style: TextStyle(fontSize: 15 ,color: AppColors.colorWhite),
                            //   ),
                            // ),
                            TextButton(
                              onPressed: () {
                                controller.loginController;
                                Get.offNamed("/login");
                              },
                              child: const Text(
                                'Already Register',
                                style: TextStyle(fontSize: 15 ,color: AppColors.gameAppBarColor),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                             CustomButton(
                              text: "Register",
                              buttonColor: AppColors.primary,
                              onPressed: () async {
                                await controller.register(context);
                              },
                            ),


                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ),
          buildWhatsAppContactButton(context), // Add this line
        ],
      )
    );
  }
}
