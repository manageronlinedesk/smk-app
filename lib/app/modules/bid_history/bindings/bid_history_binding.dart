import 'package:get/get.dart';

import '../controllers/bid_history_controller.dart';

class BidHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BidHistoryController>(
      () => BidHistoryController(),
    );
  }
}
