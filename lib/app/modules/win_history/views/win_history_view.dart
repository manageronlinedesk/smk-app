import 'package:flutter/material.dart';
import 'package:flutter_getx_template/app/core/values/app_colors.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/win_history_controller.dart';

class WinHistoryView extends GetView<WinHistoryController> {
  const WinHistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Win History',
          style: TextStyle(color: AppColors.colorWhite),
        ),
        centerTitle: true,
        iconTheme:
        const IconThemeData(color: Colors.white), // Set the icon color here
        backgroundColor: AppColors.primary,
      ),
      body: Obx(() {
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: const WaterDropHeader(),
          controller: controller.refreshController,
          onRefresh: controller.onRefresh,
          onLoading: controller.onLoading,
          child: controller.winHistoryList.isEmpty // Check if the list is empty
              ? controller.isLoading.value ?  controller.showLoadingIndicator() :   Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No History Available',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.download),
                    Text("Pull down to refresh"),
                  ],
                ),
              ],
            ),
          )
              : ListView.builder(
            itemCount: controller.winHistoryList.length,
            itemBuilder: (context, index) {
              var bid = controller.winHistoryList[index];
              return Card(
                elevation: 0,
                margin: const EdgeInsets.symmetric(
                    vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.grey),
                ),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 5),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  bid.title ?? 'No Title',
                                  style: const TextStyle(
                                      color: AppColors.gameAppBarColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('Amount: ${bid.amount}'),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Digit: ${bid.digit}'),
                                Text('ID: ${bid.id}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
