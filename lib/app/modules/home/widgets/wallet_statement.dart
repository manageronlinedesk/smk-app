import 'package:flutter/material.dart';
import 'package:flutter_getx_template/app/core/values/app_colors.dart';
import 'package:flutter_getx_template/app/core/widget/custom_Button.dart';
import 'package:flutter_getx_template/app/modules/home/widgets/withdrawal_funds.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/home_controller.dart';
import 'add_funds.dart';

class WalletStatement extends StatefulWidget {
  const WalletStatement({Key? key}) : super(key: key);

  @override
  _WalletStatementState createState() => _WalletStatementState();
}

class _WalletStatementState extends State<WalletStatement> {
  String openWithdrawTime = '';
  String closeWithdrawTime = '';
  double minWithdraw = 0;
  final HomeController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.getSpecificUser();
    _loadWithdrawalSettings();
  }

  Future<void> _loadWithdrawalSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // openWithdrawTime = prefs.getString('open_withdraw_time') ?? '7:00 AM';
      // closeWithdrawTime = prefs.getString('close_withdraw_time') ?? '10:00 PM';
      minWithdraw = prefs.getDouble('minwithdraw') ?? 500;
    });
    bool isInitialRefreshComplete = await controller.amountHistoryOnRefresh();
    controller.amountHistoryIsLoading.value = !isInitialRefreshComplete;
  }

  @override
  Widget build(BuildContext context) {
    // HomeController controller = HomeController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet Statement",
            style: TextStyle(color: AppColors.colorWhite)),
        iconTheme:
            const IconThemeData(color: Colors.white), // Set the icon color here
        backgroundColor: AppColors.gameAppBarColor,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: Get.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 200,
                    child: Card(
                      elevation: 5,
                      color: AppColors
                          .gameAppBarColor, // Set the background color here
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), // Set the circular border radius here
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.lightGreen,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    "Balance",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                // SizedBox(height: 8),
                                Obx(
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
                                        "${controller.currentBalance.value}", // Replace with the actual wallet balance
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Text(
                              "Withdraw Open Time is 7:00 AM.",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Withdraw Close Time is 10:00 PM.",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Minimal Withdrawal Points are \u20B9$minWithdraw.",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: SizedBox(
                        width: 160, // Adjust the width as needed
                        height: 45, // Adjust the height as needed
                        child: CustomButton(
                          onPressed: () {
                            Get.to(WithdrawFunds());
                          },
                          text: 'WITHDRAW',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: SizedBox(
                        width: 160, // Adjust the width as needed
                        height: 45, // Adjust the height as needed
                        child: CustomButton(
                          onPressed: () {
                            Get.to(AddFunds());
                          },
                          text: 'ADD FUNDS',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Obx(() {
            return Expanded(
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: const WaterDropHeader(),
                controller: controller.refreshController,
                onRefresh: controller.amountHistoryOnRefresh,
                onLoading: controller.amountHistoryOnLoading,
                child: controller
                        .amountHistoryList.isEmpty // Check if the list is empty
                    ? controller.amountHistoryIsLoading.value
                        ? controller.showLoadingIndicator()
                        : const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'No History Available',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
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
                        itemCount: controller.amountHistoryList.length,
                        itemBuilder: (context, index) {
                          var amountHistory =
                              controller.amountHistoryList[index];
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
                                            amountHistory.isPaid == true
                                                ? const Text(
                                                    "Amount Added",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .gameAppBarColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                : const Text(
                                                    "Requested",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .gameAppBarColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                            Text(
                                              '\u20B9${amountHistory.amount}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              DateFormat('dd MMM yyyy HH:mm:ss')
                                                  .format(DateTime.parse(
                                                      amountHistory.datetime
                                                          .toString())),
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                            amountHistory.isPaid == true
                                                ? const Text("Paid",
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                    ))
                                                : amountHistory
                                                            .isRequestCancelled ==
                                                        true
                                                    ? const Text(
                                                        "Cancelled",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )
                                                    : const Text(
                                                        "Pending",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.orange),
                                                      ),
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
              ),
            );
          }),
        ],
      ),
    );
  }
}
