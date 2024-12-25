import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_template/app/core/base/base_controller.dart';
import 'package:flutter_getx_template/app/core/values/app_values.dart';
import 'package:flutter_getx_template/app/modules/home/model/amount_history_model.dart';
import 'package:flutter_getx_template/app/modules/login/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/model/bid_place_model.dart';
import '../../../core/model/get_card_model.dart';
import '../../../core/model/get_contact_info_model.dart';
import '../../../data/model/bid_entry.dart';
import '../../../data/model/customer.dart';
import '../../../data/remote/api_data_source_impl.dart';

class HomeController extends BaseController {
  TextEditingController singlePannaDigitController = TextEditingController();
  TextEditingController singlePannaAmountController = TextEditingController();

  TextEditingController doublePannaDigitController = TextEditingController();
  TextEditingController doublePannaAmountController = TextEditingController();

  TextEditingController tripplePannaDigitController = TextEditingController();
  TextEditingController tripplePannaAmountController = TextEditingController();

  TextEditingController halfSangamOpenDigitController = TextEditingController();
  TextEditingController halfSangamCloseDigitController = TextEditingController();
  TextEditingController halfSangamAmountController = TextEditingController();

  TextEditingController fullSangamOpenPaanaDigitController = TextEditingController();
  TextEditingController fullSangamClosePaanaDigitController = TextEditingController();
  TextEditingController fullSangamAmountController = TextEditingController();

  TextEditingController jodiDigitController = TextEditingController();
  TextEditingController jodiAmountController = TextEditingController();

  TextEditingController singleDigitController = TextEditingController();
  TextEditingController singleAmountController = TextEditingController();

  TextEditingController pointsController = TextEditingController();
  TextEditingController withdrawalAmountController = TextEditingController();
  TextEditingController upiNumberController = TextEditingController();

  late String inputString;
  late int tripleDigitOpen;
  late int tripleDigitClose;
  late List<int> results;
  // final RxBool isOpenSelected = RxBool(true);
  String openResult = '';
  String closeResult = '';
  Timer? openSessionTimer;
  final currentTime = DateTime.now();
  final openTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 18, 9);
  final closeTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 19, 0);

  List<BidEntry> openSessionBids = [];
  List<BidEntry> closeSessionBids = [];
  // List<CardResponse> cardListTileData = [];
  var cardListTileData = <CardResponse>[].obs; // This should be observable

  RxDouble currentBalance = 0.0.obs;

  var name = ''.obs;
  var authToken = ''.obs;
  var userId = ''.obs;
  var userName = ''.obs;
  var mPin = 0.obs;

  RxBool cardLoading = true.obs;

  // Initialize the controller
  @override
  void onInit() async {
    super.onInit();
    String balance = Get.arguments;
    currentBalance.value = double.tryParse(balance.toString())!;

    bool isCardsFetched = await fetchCards();
    cardLoading.value = isCardsFetched;

    await loadPreferences();
  }

  LoginController loginController = Get.put(LoginController());

  Future<bool> fetchAllData() async {
    bool fetchSuccess = await fetchCards();
    bool getUser = await getSpecificUser();
    return fetchSuccess && getUser;
  }

  Future<bool> getSpecificUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");

    try{
      Customer customer =
      (await apiDataSource.getSpecificUser(userId: userId));
      currentBalance.value = double.tryParse(customer.data[0].accountBalance.toString())!;
      return true;
    }
    catch(e){
      print(e);
      return false;
    }

  }


  Future<bool> fetchCards() async {
    String? authToken = await getAuthToken();

    try {
      RootResponse response = await apiDataSource.getAllCard(
        authToken: authToken,
        id: AppValues.adminId,
      );

      if (response.data == null || response.data!.isEmpty) {
        print("No cards added.");
        return false; // Indicate fetchCards encountered an error
      }

      List<CardResponse> activeCards = response.data!
          .where((card) => card.isactive == true)
          .toList();

      cardListTileData.assignAll(activeCards);
      return true; // Indicate fetchCards was successful
    } catch (e) {
      print(e);
      return false; // Indicate fetchCards encountered an error
    }
  }

  Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString('name') ?? '';
    authToken.value = prefs.getString('AuthToken') ?? '';
    userId.value = prefs.getString('userId') ?? '';
    userName.value = prefs.getString('username') ?? '';
    mPin.value = prefs.getInt('mPin') ?? 0;
    update();
  }

  void addBidEntry(String userId, String digit, int amount, DateTime timestamp,
      String selectedOption) {
    // final entry = BidEntry(digit, amount, timestamp);

    if (selectedOption == 'Open') {
      // Upload the bid entry under the "open" node for the user.
      // databaseReference.child('users').child(userId).child('open').push().set({
      //   'digit': digit,
      //   'amount': amount,
      //   'timestamp': timestamp.toUtc().toIso8601String(),
      // });
    } else if (selectedOption == 'Close') {
      // Upload the bid entry under the "close" node for the user.
      // databaseReference.child('users').child(userId).child('close').push().set({
      //   'digit': digit,
      //   'amount': amount,
      //   'timestamp': timestamp.toUtc().toIso8601String(),
      // });
    }
  }

  //
  // void addBidEntry(String digit, int amount, DateTime timestamp, String selectedOption) {
  //   final entry = BidEntry(digit, amount, timestamp);
  //
  //   if (selectedOption == 'Open') {
  //     openSessionBids.add(entry);
  //   } else if (selectedOption == 'Close') {
  //     closeSessionBids.add(entry);
  //   }
  // }

  void calculateOpenSessionResult() {
    // Calculate the frequency of each triple digit for open session
    Map<String, int> frequencyMap = {};

    for (BidEntry entry in openSessionBids) {
      String tripleDigit = entry.digit;
      frequencyMap[tripleDigit] = (frequencyMap[tripleDigit] ?? 0) + 1;
    }

    // Find the digit with the minimum frequency
    String minFrequencyDigit = frequencyMap.keys.reduce((a, b) {
      final aCount = frequencyMap[a];
      final bCount = frequencyMap[b];
      return aCount != null && bCount != null ? (aCount < bCount ? a : b) : a;
    });

    // Set the result for open session
    openResult = "Open Session: $minFrequencyDigit";
    print(openResult);
  }

  void calculateCloseSessionResult() {
    // Calculate the frequency of each triple digit for close session
    Map<String, int> frequencyMap = {};

    for (BidEntry entry in closeSessionBids) {
      String tripleDigit = entry.digit;
      frequencyMap[tripleDigit] = (frequencyMap[tripleDigit] ?? 0) + 1;
    }

    // Find the digit with the minimum frequency
    String minFrequencyDigit = frequencyMap.keys.reduce((a, b) {
      final aCount = frequencyMap[a];
      final bCount = frequencyMap[b];
      return aCount != null && bCount != null ? (aCount < bCount ? a : b) : a;
    });

    // Set the result for close session
    closeResult = "Close Session: $minFrequencyDigit";
    print(closeResult);
  }

  void handleFormSubmission(
      String digit, String amount, String selectedOption) {
    // String uid = FirebaseAuth.instance.currentUser!.uid;
    // Convert the amount to an integer
    int bidAmount = int.tryParse(amount) ?? 0;

    // if (bidAmount > 0) {
    //   final timestamp = DateTime.now();
    //   addBidEntry(uid, digit, bidAmount, timestamp, selectedOption);
    // }
  }

  HomeController() {
    inputString = '***-**-***'; // Provide a default value

    try {
      if (DateTime.now().isBefore(openTime)) {
        // Calculate the duration until 6 PM today
        final duration = openTime.difference(DateTime.now());
        print(
            'Scheduling timer for open session in ${duration.inSeconds} seconds');
        // Schedule the timer to run the method at 6 PM
        openSessionTimer = Timer(duration, calculateOpenSessionResult);
      }
      String cleanedString = inputString.replaceAll('*', '');
      tripleDigitOpen = int.parse(cleanedString.substring(0, 3));
      tripleDigitClose = int.parse(cleanedString.substring(8, 11));
      results = calculateResults(tripleDigitOpen, tripleDigitClose);
    } catch (e) {
      print("Invalid input string: $inputString");
      tripleDigitOpen = 0;
      tripleDigitClose = 0;
      results = [0, 0, 0];
    }
  }
  final count = 0.obs;
  int calculateSingleDigit(int tripleDigit) {
    int sum = 0;
    while (tripleDigit > 0) {
      sum += tripleDigit % 10;
      tripleDigit ~/= 10;
    }
    return sum % 10;
  }

  List<int> calculateResults(int openResult, int closeResult) {
    int singleDigitOpenTime = calculateSingleDigit(openResult);
    int singleDigitCloseTime = calculateSingleDigit(closeResult);

    int doubleDigitResult = singleDigitOpenTime * 10 + singleDigitCloseTime;

    return [singleDigitOpenTime, singleDigitCloseTime, doubleDigitResult];
  }

  int calculatePayout(String userInput) {
    // Define the possible digits for each type of panna
    List<String> singlePannaDigits = [
      '127',
      '136',
      '190',
      '235',
      '280',
      '279',
      '370',
      '389',
      '459',
      '460',
      '479',
      '578',
      '128',
      '137',
      '146',
      '236',
      '245',
      '290',
      '380',
      '470',
      '489',
      '560',
      '579',
      '678',
      '129',
      '138',
      '147',
      '156',
      '237',
      '246',
      '345',
      '390',
      '480',
      '570',
      '589',
      '679',
      '120',
      '139',
      '148',
      '157',
      '238',
      '247',
      '256',
      '346',
      '490',
      '580',
      '670',
      '689',
      '130',
      '149',
      '158',
      '167',
      '239',
      '248',
      '257',
      '347',
      '356',
      '590',
      '680',
      '789',
      '140',
      '159',
      '168',
      '230',
      '249',
      '258',
      '267',
      '348',
      '357',
      '456',
      '690',
      '780',
      '123',
      '150',
      '169',
      '178',
      '240',
      '259',
      '268',
      '349',
      '358',
      '457',
      '367',
      '790',
      '124',
      '160',
      '179',
      '250',
      '269',
      '278',
      '340',
      '359',
      '368',
      '458',
      '467',
      '890',
      '125',
      '134',
      '170',
      '189',
      '260',
      '279',
      '350',
      '369',
      '378',
      '459',
      '468',
      '567',
      '126',
      '135',
      '180',
      '234',
      '270',
      '289',
      '360',
      '379',
      '450',
      '469',
      '478',
      '568',
    ];

    List<String> doublePannaDigits = [
      '550',
      '668',
      '244',
      '299',
      '226',
      '488',
      '334',
      '677',
      '118',
      '100',
      '119',
      '155',
      '227',
      '335',
      '344',
      '399',
      '588',
      '669',
      '200',
      '110',
      '228',
      '255',
      '336',
      '499',
      '660',
      '688',
      '778',
      '300',
      '166',
      '229',
      '337',
      '355',
      '445',
      '599',
      '779',
      '788',
      '400',
      '112',
      '220',
      '266',
      '338',
      '446',
      '455',
      '699',
      '770',
      '500',
      '113',
      '122',
      '177',
      '339',
      '366',
      '447',
      '799',
      '889',
      '600',
      '114',
      '277',
      '330',
      '448',
      '466',
      '556',
      '880',
      '899',
      '700',
      '115',
      '133',
      '188',
      '223',
      '377',
      '449',
      '557',
      '566',
      '800',
      '116',
      '224',
      '233',
      '288',
      '440',
      '477',
      '558',
      '990',
      '900',
      '117',
      '144',
      '199',
      '225',
      '388',
      '559',
      '577',
      '667',
    ];

    List<String> triplePannaDigits = [
      '000',
      '111',
      '222',
      '333',
      '444',
      '555',
      '666',
      '777',
      '888',
      '999'
    ];

    // Count the frequency of each digit in user input
    Map<String, int> digitCounts = {};
    for (int i = 0; i < 10; i++) {
      digitCounts[i.toString()] = 0;
    }

    for (int i = 0; i < userInput.length; i++) {
      String digit = userInput[i];
      if (digitCounts.containsKey(digit)) {
        digitCounts[digit] = (digitCounts[digit] ?? 0) + 1;
      } else {
        digitCounts[digit] = 1;
      }
    }

    // Determine the winning number based on the lowest frequency
    String winningNumber = digitCounts.keys.reduce((a, b) {
      final aCount = digitCounts[a];
      final bCount = digitCounts[b];
      return aCount != null && bCount != null ? (aCount < bCount ? a : b) : a;
    });

    // Calculate the payout based on the winning number and type of panna
    int payout = 0;
    if (singlePannaDigits.contains(winningNumber)) {
      payout = 140;
    } else if (doublePannaDigits.contains(winningNumber)) {
      payout = 270;
    } else if (triplePannaDigits.contains(winningNumber)) {
      payout = 600;
    }

    // Calculate the total payout based on the user's bid amount
    int bidAmount = int.parse(userInput);
    int totalPayout = bidAmount * payout;

    return totalPayout;
  }

  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();

  void increment() => count.value++;
  @override
  void onClose() {
    // Cancel the timer when the controller is closed to prevent memory leaks
    openSessionTimer?.cancel();
    super.onClose();
  }

  Future<AmountHistoryModel?> getAmountHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");

    try {
      AmountHistoryModel response = await apiDataSource.getAmountHistory(adminId: AppValues.adminId, userId: userId, pageIndex: 1);
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  RxList<PaymentData> amountHistoryList = <PaymentData>[].obs;

  RxInt amountHistoryCurrentPage = 1.obs;
  RxBool amountHistoryIsLoading = true.obs;
  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  Future<bool> amountHistoryOnRefresh() async {
    amountHistoryCurrentPage.value = 1;
    AmountHistoryModel? response = await apiDataSource.getAmountHistory(adminId: AppValues.adminId, userId: userId.toString(), pageIndex: 1);

    if (response == null) {
      refreshController.refreshFailed();
      return true;
    } else if (response.data.isNotEmpty) {
      amountHistoryList.assignAll(response.data);
      refreshController.refreshCompleted();
      return true;
    } else {
      refreshController.refreshCompleted();
      return true;
    }
  }

  amountHistoryOnLoading() async {
    amountHistoryCurrentPage.value++;
    AmountHistoryModel? response =
    await apiDataSource.getAmountHistory(adminId: AppValues.adminId, userId: userId.toString(), pageIndex: amountHistoryCurrentPage.value);

    if (response == null) {
      refreshController.loadFailed();
    } else if (response.data.isNotEmpty) {
      amountHistoryList.addAll(response.data);
      refreshController.loadComplete();
    } else {
      refreshController.loadNoData();
      await Future.delayed(const Duration(seconds: 1));
      refreshController.loadComplete();
    }
  }


}
