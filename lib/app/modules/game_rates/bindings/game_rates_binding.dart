import 'package:get/get.dart';

import '../controllers/game_rates_controller.dart';

class GameRatesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameRatesController>(
      () => GameRatesController(),
    );
  }
}
