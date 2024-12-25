import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/model/get_card_model.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_values.dart';
import '../../home/controllers/home_controller.dart';
import '../widgets/double_panna.dart';
import '../widgets/full_sangam.dart';
import '../widgets/half_sangam.dart';
import '../widgets/jodi_digit.dart';
import '../widgets/single_digit.dart';
import '../widgets/single_panna.dart';
import '../widgets/tripple_panna.dart';

class GameScreensView extends StatefulWidget {
  final bool isOpenTimeActive;
  final String openingTime;
  final String closingTime;
  final String cardId;
  final List<InnerCard> innerCards;

  const GameScreensView(
      {Key? key,
        required this.isOpenTimeActive,
        required this.openingTime,
        required this.closingTime,
        required this.cardId,
        required this.innerCards,})
      : super(key: key);
  @override
  _GameScreenView createState() => _GameScreenView();
}

class _GameScreenView extends State<GameScreensView> {
  HomeController basebtn = HomeController();
  HomeController controller = Get.put(HomeController());
  Timer? _timer;
  bool result = true;
  int initialSeconds = 1;


  @override
  void initState() {
    super.initState();
    DateTime currentDateTime = DateTime.now();

    String dt = DateFormat('dd-MM-yyyy ').format(currentDateTime);
    DateTime openingTime =
    DateFormat('dd-MM-yyyy hh:mm a').parse(dt + widget.openingTime);

    _timer =
        Timer.periodic(Duration(milliseconds: initialSeconds), (Timer timer) {
          int openComparison = DateTime.now().compareTo(openingTime);
          bool res = openComparison > 0 ? true : false;
          if (res && result) {
            if (mounted) {
              setState(() {
                initialSeconds = 1000;
                result = false;
                _timer?.cancel();
              });
            }
          }
        });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Game',style: TextStyle(color: AppColors.colorWhite)),
          iconTheme: IconThemeData(color: Colors.white), // Set the icon color here
          centerTitle: true,
          backgroundColor: AppColors.gameAppBarColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            width: Get.width,
            height: Get.height - kToolbarHeight - kToolbarHeight,
            color: AppColors.colorWhite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: result
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        InnerCard selectedInnerCard = widget.innerCards.elementAt(0);
                        Get.to(
                            SingleDigit(
                                openingTime: widget.openingTime,
                                closingTime: widget.closingTime,
                                innerCardData: selectedInnerCard, cardId: widget.cardId,
                        ));
                      },
                      child: Image.asset(
                        'images/single-digit.png',
                        width: AppValues.gameCardSize,
                      ),
                    ),
                    result
                        ? GestureDetector(
                      onTap: () {
                        InnerCard selectedInnerCard = widget.innerCards.elementAt(1);
                        Get.to(JodiDigit(
                          openingTime: widget.openingTime,
                          closingTime: widget.closingTime,
                            cardId: widget.cardId,
                            innerCardData: selectedInnerCard
                        ));
                      },
                      child: Image.asset(
                        'images/jodi-digit.png',
                        width: AppValues.gameCardSize,
                      ),
                    )
                        : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
                  ],
                ),
                SizedBox(
                  height: AppValues.gameCardVerticalSpacing,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        InnerCard selectedInnerCard = widget.innerCards.elementAt(2);
                        Get.to(SinglePanna(
                          openingTime: widget.openingTime,
                          closingTime: widget.closingTime,
                            cardId: widget.cardId,
                            innerCardData: selectedInnerCard
                        ));
                      },
                      child: Image.asset(
                        'images/single-panna.png',
                        width: AppValues.gameCardSize,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        InnerCard selectedInnerCard = widget.innerCards.elementAt(3);
                        Get.to(DoublePanna(
                          openingTime: widget.openingTime,
                          closingTime: widget.closingTime,
                            cardId: widget.cardId,
                            innerCardData: selectedInnerCard
                        ));
                      },
                      child: Image.asset(
                        'images/double-panna.png',
                        width: AppValues.gameCardSize,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AppValues.gameCardVerticalSpacing,
                ),
                GestureDetector(
                  onTap: () {
                    InnerCard selectedInnerCard = widget.innerCards.elementAt(4);
                    Get.to(TriplePanna(
                      openingTime: widget.openingTime,
                      closingTime: widget.closingTime,
                        cardId: widget.cardId,
                        innerCardData: selectedInnerCard
                    ));
                  },
                  child: Image.asset(
                    'images/triple-panna.png',
                    width: AppValues.gameCardSize,
                  ),
                ),

                SizedBox(
                  height: AppValues.gameCardVerticalSpacing,
                ),
                result
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        InnerCard selectedInnerCard = widget.innerCards.elementAt(5);
                        Get.to(HalfSangam(
                          openingTime: widget.openingTime,
                          closingTime: widget.closingTime,
                            cardId: widget.cardId,
                            innerCardData: selectedInnerCard
                        ));
                      },
                      child: Image.asset(
                        'images/half_sangam.jpeg',
                        width: AppValues.gameCardSize,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        InnerCard selectedInnerCard = widget.innerCards.elementAt(6);
                        Get.to(FullSangam(
                          openingTime: widget.openingTime,
                          closingTime: widget.closingTime,
                            cardId: widget.cardId,
                            innerCardData: selectedInnerCard
                        ));
                      },
                      child: Image.asset(
                        'images/full_sangam.jpeg',
                        width: AppValues.gameCardSize,
                      ),
                    ),
                  ],
                )
                    : const SizedBox(
                  height: 0,
                  width: 0,
                ),
              ],
            ),
          ),
        ));
  }
}
