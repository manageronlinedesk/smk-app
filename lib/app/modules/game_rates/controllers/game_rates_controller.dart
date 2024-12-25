import 'package:flutter_getx_template/app/core/base/base_controller.dart';
import 'package:flutter_getx_template/app/core/values/app_values.dart';
import 'package:flutter_getx_template/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../../data/model/game_rates_model.dart';

class GameRatesController extends BaseController {
  Rx<GameRates?> gameRatesData = Rx<GameRates?>(null);
  RxBool isLoading = false.obs;

  final count = 0.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchGameRates();
  }
  Future<void> fetchGameRates() async {
    try {
      isLoading.value = true;
      // Fetch the game rates data and store it in the observable variable
      GameRates response = await apiDataSource.getGameRates(adminId: AppValues.adminId);
      gameRatesData.value = response;
      isLoading.value = true;
    } catch (e) {
      isLoading.value = true;
      print("Error fetching game rates: $e");
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
