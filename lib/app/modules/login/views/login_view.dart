import 'package:flutter/material.dart';
import 'package:flutter_getx_template/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_values.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widget/custom_Button.dart';
import '../../../core/widget/custom_text_input_fields.dart';
import '../controllers/login_controller.dart';
import '../widgets/forget_mpin.dart';


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with WidgetsBindingObserver {
  LoginController controller = LoginController();
  bool isEntryRequired = false;
  var isScreenLoaded = true.obs;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // check user is logged in or not
    // controller.checkLogin();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (WidgetsBinding.instance.window.viewInsets.bottom == 0.0) {
      isScreenLoaded(false);
      isScreenLoaded(true);
    }
  }

  Widget buildWhatsAppContactButton(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    return TextButton(
      onPressed: () async {
        if(controller.whatsAppNO.isEmpty || controller.whatsAppNO.value == '' || controller.whatsAppNO.value == null){
          bool isFetched = await controller.fetchAndSaveContactData();
          if (!isFetched) {
            // Show error message and exit the method
            controller.showToast(context: Get.context!,message: "Error: Check Internet Connection");
            return;
          }
        }
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
      backgroundColor:
          AppColors.colorWhite,
      extendBodyBehindAppBar: true,
      body: Obx(
        () => isScreenLoaded.value
            ? Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Image.asset(
                        'images/app_logo_name.png',
                        width: Get.width * 0.5,
                        height: Get.height * 0.2, // Set the desired height
                        // color: AppColors.colorWhite,
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
                                  children: [
                                    Text(
                                      'Login',
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
                                  height: AppValues.margin_20,
                                ),
                                CustomTextInputField(
                                  title: 'Mobile Number',
                                  controller: controller.userNameController,
                                  titleStyle: primaryColorT14W400,
                                  hintText: 'Enter mobile number',
                                  isMandatory: true,
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  checkValidation: isEntryRequired,
                                  textCapitalization: TextCapitalization.none,
                                ),
                                const SizedBox(
                                  height: AppValues.margin_20,
                                ),
                                CustomTextInputField(
                                  title: 'M-pin',
                                  controller: controller.passwordController,
                                  titleStyle: primaryColorT14W400,
                                  hintText: 'Enter M-pin',
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  // isObscure: controller.passwordCheck.value,
                                  isMandatory: true,
                                  checkValidation: isEntryRequired,
                                  textCapitalization: TextCapitalization.none,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Get.to(ForgetMpinScreen());
                                      },
                                      child: const Text(
                                        'Forgot Password',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.gameAppBarColor),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        controller.registerController;
                                        Get.offNamed("/register");
                                      },
                                      child: const Text(
                                        '|   Register Here',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.gameAppBarColor),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    CustomButton(
                                      text: "Login",
                                      buttonColor: AppColors.primary,
                                      onPressed: () async {
                                        await controller.login(context);
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
            : const SizedBox.shrink(),
      ),

    );
  }
}
