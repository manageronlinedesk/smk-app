import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_getx_template/app/modules/game_screens/controllers/game_screens_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/model/bid_place_model.dart';
import '../../../core/model/get_card_model.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_values.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widget/custom_Button.dart';
import '../../../core/widget/custom_bid_place_dialog.dart';
import '../../../core/widget/custom_input_field_bid_place.dart';
import '../../../core/widget/custom_loading.dart';
import '../../../core/widget/custom_show_alert.dart';
import '../../../data/model/customer.dart';
import '../../../data/model/input_validations.dart';
import '../../home/controllers/home_controller.dart';
import 'input_box.dart';

class SinglePanna extends StatefulWidget {
  String openingTime;
  String closingTime;
  String cardId;
  final InnerCard innerCardData;
  SinglePanna(
      {required this.openingTime,
      required this.cardId,
      required this.closingTime,
      required this.innerCardData});
  @override
  _SinglePanna createState() => _SinglePanna();
}

class _SinglePanna extends State<SinglePanna> {
  HomeController controller = Get.put(HomeController());
  GameScreensController gameScreensController = Get.put(GameScreensController());

  double minbidamount = 0;
  double maxbidamount = 0;

  DateTime openTime = DateTime.now();
  bool isOpenResultActive = true;
  bool isCloseResultActive = true;
  //for selecting between radio buttons
  bool isOpenSelected = true;
  List<bool> radioSelection = [true, false];

  Timer? _timer;
  bool result = true;
  int initialSeconds = 1;
  DateTime currentTime = DateTime.now();

  void initState() {
    super.initState();

    _loadBidLimits();

    DateTime currentDateTime = DateTime.now();

    String dt = DateFormat('dd-MM-yyyy ').format(currentDateTime);
    DateTime openingTime =
        DateFormat('dd-MM-yyyy hh:mm a').parse(dt + widget.openingTime);
    DateTime closingTime =
        DateFormat('dd-MM-yyyy hh:mm a').parse(dt + widget.closingTime);

    _timer =
        Timer.periodic(Duration(milliseconds: initialSeconds), (Timer timer) {
      int openResultCheck = DateTime.now().compareTo(openingTime);
      bool openResult = openResultCheck > 0 ? true : false;

      int closeResultCheck = DateTime.now().compareTo(closingTime);
      bool closeResult = closeResultCheck > 0 ? true : false;
      if (mounted) {
        setState(() {
          isCloseResultActive = !closeResult;
          isOpenResultActive = !openResult;
          if (!isOpenResultActive) {
            isOpenSelected = false;
          }
        });
      }
    });
  }

  Future<void> _loadBidLimits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      minbidamount = prefs.getDouble('minbidamount') ?? 500; // Default to 500 if not set
      maxbidamount = prefs.getDouble('maxbidamount') ?? 100000; // Default to 100000 if not set
    });
  }

  Future<void> _onSubmit() async {
    controller.closeKeyboard(context);

    String digit =
    controller.singlePannaDigitController.text.trim();

    String amount =
    controller.singlePannaAmountController.text.trim();

    double? checkBidAmount = double.tryParse(controller.singlePannaAmountController.text);


    // Check if the entered digit matches any item in the suggestion list
    bool isValidDigit = gameScreensController.SinglePannaSuggestionList.contains(digit);

    if (!isValidDigit) {
      // Show warning if the entered digit doesn't match any item in the suggestion list
      await ShowAlertMessage.showSimpleDialog(
        context,
        title: "Invalid Digit",
        message: "The entered single panna digit is not valid.",
        isSuccess: false,
      );
      return; // Stop execution if the digit is not valid
    }

    if (checkBidAmount! < minbidamount || checkBidAmount > maxbidamount) {
      await ShowAlertMessage.showSimpleDialog(
        context,
        title: "Validation Error!",
        message: "Amount must be between ₹${minbidamount.toStringAsFixed(0)} and ₹${maxbidamount.toStringAsFixed(0)}",
        isSuccess: false,
      );
      return;
    }

    if (isCloseResultActive) {

      String selectedOption =
      isOpenSelected ? 'Open' : 'Close';

      List validationResult = InputValidation.validator(
          Digit: digit, amount: amount, currentBalance: controller.currentBalance.value.toString());
      // controller.handleFormSubmission(
      //     digit, amount, selectedOption);
      if (!validationResult[0]) {

        await ShowAlertMessage.showSimpleDialog(
          context,
          title: validationResult[1],
          message: validationResult[2],
          isSuccess: validationResult[3],
        );
      }else{
        double walletAmountBefore = controller.currentBalance.value;
        double bidAmount = double.tryParse(controller.singlePannaAmountController.text.trim()) ?? 0.0;
        double digit = double.tryParse(controller.singlePannaDigitController.text.trim()) ?? 0.0;
        double walletAmountAfter = walletAmountBefore - bidAmount;

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ConfirmBidDialog(
              totalBids: 1,
              digit: digit,
              totalBidAmount: bidAmount,
              walletAmountBefore: walletAmountBefore,
              walletAmountAfter: walletAmountAfter,
              onConfirm: () => _confirmBid(amount: amount),
              onCancel: () => Navigator.of(context).pop(),
            );
          },
        );
      }
    } else {
      Get.back(); // stop loading
      await ShowAlertMessage.showSimpleDialog(
        context,
        title: "Timeout",
        message: "Bid timeout!\nTry again later",
        isSuccess: false,
      );
    }


  }
  void _confirmBid({required amount}) async {
   try{
     CustomLoading.showLoading(context);
     final applyBid = PaymentPayload(
       userId: controller.userId.value,
       cardId: widget.cardId,
       innerCardId: widget.innerCardData.innerCardId,
       amount: controller.singlePannaAmountController.text,
       digit: controller.singlePannaDigitController.text,
       isOpen: isOpenSelected.toString(),
       adminId: AppValues.adminId,
     );
     String? authToken = await controller.getAuthToken();
     Customer response =
     await controller.apiDataSource.bidPlace(authToken: authToken, bidDetails: applyBid);
     controller.currentBalance.value = (double.tryParse(response.data[0].accountBalance.toString()) ?? 0.0);

     controller.singlePannaDigitController.clear();
     controller.singlePannaAmountController.clear();

     Get.back(); // close dialog
     Get.back(); // stop loading

     controller.showToast(context: context, message: response.response.description.toString());
   }catch(e){
     Get.back(); // close dialog
     Get.back(); // stop loading

     controller.showToast(context: context, message: e.toString());
   }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Single Paana',
            style: TextStyle(color: AppColors.colorWhite),
          ),
          iconTheme: const IconThemeData(color: Colors.white), // Set the icon color here
          backgroundColor: AppColors.gameAppBarColor,
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
                      color: AppColors.colorWhite,
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(
              width: 15,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            width: Get.width,
            height: Get.height - 100,
            child: Column(
              children: [
                InputBox(
                  maxInputLength: 100,
                  title: 'Choose Date',
                  isInputEnabled: false,
                  controller: TextEditingController(
                      text:
                          DateFormat('E dd-MMM-yyyy').format(DateTime.now())),
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Choose Session",
                      style: titleBlackW500,
                    ),
                    Row(
                      children: [
                        Radio(
                          value: true,
                          groupValue: isOpenSelected,
                          onChanged: (bool? newValue) {
                            if (mounted) {
                              setState(() {
                                isOpenSelected = true;
                              });
                            }
                          },
                          activeColor: AppColors.gameAppBarColor, // Color when this radio button is selected
                          fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return AppColors.gameAppBarColor; // Color for the selected state
                            }
                            return Colors.grey; // Color for the unselected state
                          }),
                        ),
                        const Text('Open'),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        Radio(
                          value: false,
                          groupValue: isOpenSelected,
                          onChanged: (bool? newValue) {
                            if (mounted) {
                              setState(() {
                                isOpenSelected = false;
                              });
                            }
                          },
                          activeColor: AppColors.gameAppBarColor, // Color when this radio button is selected
                          fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return AppColors.gameAppBarColor; // Color for the selected state
                            }
                            return Colors.grey; // Color for the unselected state
                          }),
                        ),
                        const Text('Close'),
                      ],
                    ),
                  ],
                ),
                CustomInputBox(
                  title: 'Enter Single Paana',
                  isInputEnabled: true,
                  controller: controller.singlePannaDigitController,
                  maxInputLength: 3,
                  keyboardType: TextInputType.number,
                  suggestions: gameScreensController.SinglePannaSuggestionList,
                ),
                const SizedBox(
                  height: 15,
                ),
                InputBox(
                  maxInputLength: AppValues.maxAmountLength,
                  isInputEnabled: true,
                  title: 'Enter Amount',
                  controller: controller.singlePannaAmountController,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomButton(text: "Submit Request",
                  onPressed: _onSubmit,),
              ],
            ),
          ),
        ));
  }
}
