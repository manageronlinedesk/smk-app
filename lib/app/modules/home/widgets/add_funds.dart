
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_template/app/core/widget/custom_Button.dart';
import 'package:flutter_getx_template/app/modules/home/widgets/upi_payment_options.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widget/custom_input_field_bid_place.dart';
import '../../../core/widget/custom_show_alert.dart';
import '../../../core/widget/custom_text_input_fields.dart';
import '../controllers/home_controller.dart';

class AddFunds extends StatefulWidget {
  const AddFunds({Key? key}) : super(key: key);

  @override
  _AddFundsState createState() => _AddFundsState();
}

class _AddFundsState extends State<AddFunds> {
  HomeController controller = HomeController();
  double minDeposit = 0;
  double maxDeposit = 0;
  List<double> points = [];

  @override
  void initState() {
    super.initState();
    _loadDepositLimits();
  }

  Future<void> _loadDepositLimits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      minDeposit = prefs.getDouble('mindeposit') ?? 500; // Default to 500 if not set
      maxDeposit = prefs.getDouble('maxdeposit') ?? 100000; // Default to 100000 if not set
      // Generate points
      points = _generatePoints(minDeposit, maxDeposit, 5);
    });
  }

  List<double> _generatePoints(double min, double max, int divisions) {
    double step = (max - min) / (divisions - 1);
    List<double> generatedPoints = [];
    for (int i = 0; i < divisions; i++) {
      generatedPoints.add(min + step * i);
    }
    return generatedPoints;
  }

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());

    return WillPopScope(
      onWillPop: () async {
        controller.pointsController.clear();
        return Future.value(true); // Allow the screen to be popped
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Points",
            style: TextStyle(color: AppColors.colorWhite),
          ),
          iconTheme: IconThemeData(color: AppColors.colorWhite),
          backgroundColor: AppColors.gameAppBarColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: CustomInputBox(
                  title: 'Points',
                  hintText: "Enter Points",
                  isInputEnabled: true,
                  controller: controller.pointsController,
                  maxInputLength: 5,
                  keyboardType: TextInputType.number,
                  suggestions: [],
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: Get.width,
                  height: 50,
                  child: CustomButton(
                    onPressed: () async{
                      controller.closeKeyboard(context);
                      if(controller.pointsController.text == null || controller.pointsController.text == '' ){
                        await ShowAlertMessage.showSimpleDialog(
                          context,
                          title: "Validation Error!",
                          message: "Amount Cannot be empty",
                          isSuccess: false,
                        );
                      }else{
                        double? amount = double.tryParse(controller.pointsController.text);
                        if (amount! < minDeposit || amount > maxDeposit) {
                          await ShowAlertMessage.showSimpleDialog(
                            context,
                            title: "Validation Error!",
                            message: "Amount must be between ₹${minDeposit.toStringAsFixed(0)} and ₹${maxDeposit.toStringAsFixed(0)}",
                            isSuccess: false,
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpiOptions(amount: amount!),
                            ),
                          );
                        }
                      }
                    },
                    text: 'Add Points',
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Select Points Amount",
                  style: titleBlackW500,
                ),
              ),
              Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      for (int i = 0; i < points.length; i++)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: SizedBox(
                            width: 108,
                            height: 50,
                            child: CustomButton(
                              onPressed: () {
                                setState(() {
                                  controller.pointsController.text = points[i].toStringAsFixed(0);
                                });
                              },
                              text: points[i].toStringAsFixed(0),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  _buildFundNoticeCard(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFundNoticeCard() {
    return Card(
      color: AppColors.gameAppBarColor,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Center(
              child: Text(
                "!! Add Fund Notice !!",
                style: TextStyle(
                  color: AppColors.colorWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "1. Minimum Deposit: ₹${minDeposit.toStringAsFixed(0)}\n"
                  "2. Maximum Deposit: ₹${maxDeposit.toStringAsFixed(0)}\n"
                  "3. 24x7 Customer Service Support",
              style: TextStyle(
                color: AppColors.colorWhite,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Note:\n"
                  "If you need any kind of information, contact us on WhatsApp.",
              style: TextStyle(
                color: AppColors.colorWhite,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

