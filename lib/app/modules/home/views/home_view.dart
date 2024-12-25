import 'package:flutter/material.dart';
import 'package:flutter_getx_template/app/core/values/app_colors.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/home_controller.dart';
import '../widgets/home_options.dart';
import '../widgets/home_slider.dart';
import '../widgets/home_text_scroll.dart';
import '../widgets/home_tiles.dart';
import '../widgets/menu.dart';
import '../widgets/wallet_statement.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // String? firstCapital = UserModel.name?.isNotEmpty == true
    //     ? UserModel.name![0].toUpperCase()
    //     : '';

    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    void _onRefresh() async {
      bool isFetched = await controller.fetchAllData();

      if (isFetched) {
        _refreshController.refreshCompleted();
      } else {
        _refreshController.refreshFailed();
      }
    }

    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        elevation: 4,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerHeader(
                decoration:
                    const BoxDecoration(color: Color.fromARGB(255, 0, 75, 136)),
                child: Container(
                    alignment: Alignment.center,
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Obx(
                          () => CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.lightBlue,
                            child: Text(
                              controller.name.substring(0, 1),
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 75, 136),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                          ),
                        )),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => SizedBox(
                                    width: 150,
                                    child: Text(
                                      '${controller.name}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.left,
                                      // softWrap: true,
                                    ),
                                  )),
                              const SizedBox(
                                height: 5,
                              ),
                              Obx(() => Text(
                                    '${controller.userName}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ))
                            ],
                          ),
                        )
                      ],
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Menu()
            ]),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.gameAppBarColor,
        iconTheme:
            const IconThemeData(color: Colors.white), // Set the icon color here
        title: Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Kalyan Live',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
            )),
        titleTextStyle: const TextStyle(),
        actions: [
          Center(
              child: Obx(
            () => Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    'images/coin_image.png',
                    width: Get.width,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(width: 5,),
                Text(
                  '${controller.currentBalance.value}',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.colorWhite),
                ),
              ],
            ),
          )),
          const SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () {
              Get.to(const WalletStatement());
            },
            child: const CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(
                Icons.wallet_giftcard_rounded,
                color: Color.fromARGB(255, 0, 75, 136),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: Get.height / 4,
            width: Get.width,
            color: AppColors.gameAppBarColor,
          ),
          SmartRefresher(
            enablePullDown: true,
            // enablePullUp: true,
            header: const WaterDropHeader(
                waterDropColor: AppColors.colorWhite,
                idleIcon: Icon(
                  Icons.refresh,
                  size: 15,
                  color: Colors.black,
                ),
                complete: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Refresh completed",
                      style: TextStyle(
                          color: AppColors.colorWhite,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 20,
                    )
                  ],
                ),
                failed: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.clear,
                      color: Colors.red,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Refresh Failed",
                      style: TextStyle(
                          color: AppColors.colorWhite,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ],
                ),
                refresh: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.colorWhite,
                      strokeWidth: 2,
                    ))),
            // MaterialClassicHeader(color: AppColors.gameAppBarColor, backgroundColor: AppColors.colorWhite,),
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: Column(
              children: [
                HomeSlider(),
                HomeTextScroll(),
                HomeOptions(),
                HomeTiles(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
