import 'package:flutter/material.dart';
import 'package:flutter_getx_template/app/core/model/bid_place_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_values.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widget/custom_Button.dart';
import '../../../core/widget/custom_show_alert.dart';
import '../../../data/model/customer.dart';
import '../../../data/remote/api_data_source_impl.dart';
import '../../game_screens/widgets/input_box.dart';
import '../controllers/home_controller.dart';
import 'bank_details_screen.dart';

class WithdrawFunds extends StatefulWidget {
  WithdrawFunds({Key? key}) : super(key: key);

  @override
  _WithdrawFundsState createState() => _WithdrawFundsState();
}

class _WithdrawFundsState extends State<WithdrawFunds> {
  String selectedWithdrawalMethod = "PhonePay"; // Default method
  HomeController controller = Get.put(HomeController());
  double minWithdraw = 0;
  double maxWithdraw = 0;

  @override
  void initState() {
    super.initState();
    _loadWithdrawalLimits();
    controller.getSpecificUser();
  }

  Future<void> _loadWithdrawalLimits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      minWithdraw = prefs.getDouble('minwithdraw') ?? 500; // Default to 500 if not set
      maxWithdraw = prefs.getDouble('maxwithdraw') ?? 100000; // Default to 100000 if not set
    });
  }


  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return WillPopScope(
      onWillPop: () async {
        controller.upiNumberController.clear();
        controller.withdrawalAmountController.clear();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Withdraw Funds", style: TextStyle(color: AppColors.colorWhite)),
          iconTheme: IconThemeData(color: Colors.white), // Set the icon color here
          backgroundColor: AppColors.gameAppBarColor,
          actions: [
            Center(
                child: Obx(
                      () => Text(
                    '\u20B9${controller.currentBalance.value}',
                    style: TextStyle(
                        fontSize: 20, color: AppColors.colorWhite),
                  ),
                )),
            SizedBox(
              width: 15,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                InputBox(
                  maxInputLength: AppValues.maxAmountLength,
                  isInputEnabled: true,
                  title: 'Withdrawal Amount',
                  controller: controller.withdrawalAmountController,
                ),
                SizedBox(height: 20),
                InputBox(
                  maxInputLength: 20,
                  isInputEnabled: true,
                  title: 'Enter UPI/Mobile Number',
                  controller: controller.upiNumberController,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20),
                Text(
                  "Select Withdrawal Method",
                  style: titleBlackW500,
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  value: selectedWithdrawalMethod,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedWithdrawalMethod = newValue ?? "PhonePay";
                    });
                  },
                  items: <String>[
                    "PhonePay",
                    "Paytm",
                    "Google Pay",
                    "Bank Account",
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 30),
                CustomButton(
                  text: "Withdraw",
                  onPressed: () async {
                    controller.closeKeyboard(context);

                    double withdrawalAmount = double.tryParse(controller.withdrawalAmountController.text.trim()) ?? 0;
                    String upiNumber = controller.upiNumberController.text.trim();

                    if(withdrawalAmount == 0 || upiNumber == ''){
                      await ShowAlertMessage.showSimpleDialog(
                        context,
                        title: "Validation Error!",
                        message: "Amount and number Cannot be Empty or zero",
                        isSuccess: false,
                      );
                      return;
                    }

                    double? amount = double.tryParse(controller.withdrawalAmountController.text);
                    if (amount! < minWithdraw || amount > maxWithdraw) {
                      await ShowAlertMessage.showSimpleDialog(
                        context,
                        title: "Validation Error!",
                        message: "Amount must be between ₹${minWithdraw.toStringAsFixed(0)} and ₹${maxWithdraw.toStringAsFixed(0)}",
                        isSuccess: false,
                      );
                      return;
                    }

                    if ((double.tryParse(withdrawalAmount.toString())??0.0) > (double.tryParse(controller.currentBalance.toString().trim())??0.0)) {
                      await ShowAlertMessage.showSimpleDialog(
                        context,
                        title: "Validation Error!",
                        message: "Insufficient Fund",
                        isSuccess: false,
                      );
                      return;
                    }

                    // Add your withdrawal logic here
                   try{
                     Customer response = await controller.apiDataSource.withdrawAmountReq(
                       adminId: AppValues.adminId,
                       userId: controller.userId.value,
                       amount: withdrawalAmount,
                       mobileNo: upiNumber,
                       paymentType: selectedWithdrawalMethod
                     );
                     controller.currentBalance.value = (double.tryParse(response.data[0].accountBalance.toString()) ?? 0.0);

                     controller.showToast(context: context, message: response.response.description);
                     controller.withdrawalAmountController.clear();
                     controller.upiNumberController.clear();
                   }catch(e){
                     print(e);
                   }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
