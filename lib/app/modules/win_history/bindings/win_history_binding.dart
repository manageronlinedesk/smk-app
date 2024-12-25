import 'package:get/get.dart';

import '../controllers/win_history_controller.dart';

class WinHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WinHistoryController>(
      () => WinHistoryController(),
    );
  }
}
