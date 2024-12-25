import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_colors.dart';
import '../controllers/game_rates_controller.dart';
import '../widgets/game_rate_tile.dart';

class GameRatesView extends GetView<GameRatesController> {
  const GameRatesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Rates', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primary,
      ),
      body: SafeArea(
        child: Obx(
              () {
            final gameRates = controller.gameRatesData.value;
            if (gameRates == null) {
              return controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator(color: AppColors.gameAppBarColor,))
                  : SizedBox(
                height: Get.height,
                width: Get.width,
                child: const Center(child: Text("No Game Rates Available!")),
              );
            }
            if (gameRates.data.isEmpty) {
              return const Center(child: Text("No Game Rates Available!"));
            }
            final firstDataItem = gameRates.data.first;

            return SizedBox(
              width: Get.width,
              height: Get.height,
              child: Column(
                children: [
                  GameRateTile(title: 'Single Digit', range: '${firstDataItem.singledigit1}-${firstDataItem.singledigit2}'),
                  GameRateTile(title: 'Jodi Digit', range: '${firstDataItem.jodidigit1}-${firstDataItem.jodidigit2}'),
                  GameRateTile(title: 'Single Panna', range: '${firstDataItem.singlepanna1}-${firstDataItem.singlepanna2}'),
                  GameRateTile(title: 'Double Panna', range: '${firstDataItem.doublepanna1}-${firstDataItem.doublepanna2}'),
                  GameRateTile(title: 'Triple Panna', range: '${firstDataItem.triplepanna1}-${firstDataItem.triplepanna2}'),
                  GameRateTile(title: 'Half Sangam', range: '${firstDataItem.halfsangam1}-${firstDataItem.halfsangam2}'),
                  GameRateTile(title: 'Full Sangam', range: '${firstDataItem.fullsangam1}-${firstDataItem.fullsangam2}'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
