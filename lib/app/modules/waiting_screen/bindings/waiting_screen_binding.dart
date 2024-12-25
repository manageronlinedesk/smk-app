import 'package:get/get.dart';

import '../controllers/waiting_screen_controller.dart';

class WaitingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WaitingScreenController>(
      () => WaitingScreenController(),
    );
  }
}
