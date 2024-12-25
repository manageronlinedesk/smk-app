import 'package:get/get.dart';

import '../controllers/game_screens_controller.dart';

class GameScreensBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameScreensController>(
      () => GameScreensController(),
    );
  }
}
