import 'package:flutter_getx_template/app/core/base/base_controller.dart';
import 'package:flutter_getx_template/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../login/widgets/m_pin_widget.dart';

class WaitingScreenController extends BaseController {
  //TODO: Implement WaitingScreenController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 1), () {
      checkLogin();
    });
  }

  checkLogin() async {
    bool isLogin = await isLoggedIn() ?? false;
    if (isLogin) {
      Get.offAll(MPINScreen());
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
