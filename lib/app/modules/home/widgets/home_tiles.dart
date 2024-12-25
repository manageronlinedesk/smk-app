import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_getx_template/app/data/remote/api_data_source_impl.dart';
import 'package:flutter_getx_template/app/modules/home/widgets/resull_chart_screen.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'package:intl/intl.dart';

import '../../../core/model/get_card_model.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_values.dart';
import '../../../data/model/get_result_chart_model.dart';
import '../../game_screens/views/game_screens_view.dart';
import '../controllers/home_controller.dart';

class HomeTiles extends StatefulWidget {
  @override
  _HomeTiles createState() => _HomeTiles();
}

class _HomeTiles extends State<HomeTiles> {
  final HomeController controller = Get.find();

  DateTime _currentTime = DateTime.now();
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(milliseconds: 1000), (Timer timer) {
      print('timer');
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  bool isActive(String time) {
    DateTime currentDateTime = DateTime.now();

    String dt = DateFormat('dd-MM-yyyy ').format(currentDateTime);
    DateTime closingTime =
    DateFormat('dd-MM-yyyy hh:mm a').parse('${dt + time}');

    bool result = true;
    int initialTime = 1;

    _timer = Timer.periodic(Duration(milliseconds: initialTime), (Timer timer) {
      int comparison = DateTime.now().compareTo(closingTime);
      bool res = comparison > 0 ? true : false;
      if (res) {
        if (mounted) {
          setState(() {
            initialTime = 1000;
            result = false;
          });
        }
      }
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        if (controller.cardListTileData.isEmpty) {
          // While waiting for data to load, you can show a loading indicator.
          return controller.cardLoading.value ? const Center(child: CircularProgressIndicator(color: AppColors.gameAppBarColor,)) : SizedBox(height: Get.height, width: Get.width, child:  Center(child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No Game Available!"),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.download),
                  Text("Pull down to refresh"),
                ],
              ),
            ],
          )),);
        } else {
          // If data is loaded, build your card list.
          return ListView.builder(
            itemCount: controller.cardListTileData.length,
            itemBuilder: (BuildContext context, index) {
              // final card = controller.cardData[index];
              // bool result = isActive(card['close_time']);
              CardResponse card = controller.cardListTileData[index];
              return ListComponent(
                data: card,
              );
            },
          );
        }
      }),
    );
  }
}

class ListComponent extends StatefulWidget {
  // var data;
  final CardResponse data;
  ListComponent({required this.data});
  @override
  _ListComponent createState() => _ListComponent();
}

class _ListComponent extends State<ListComponent> {
  bool result = true;
  bool shouldShake = false;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    DateTime currentDateTime = DateTime.now();

    String dt = DateFormat('dd-MM-yyyy ').format(currentDateTime);
    DateTime closingTime = DateFormat('dd-MM-yyyy hh:mm a')
        .parse('${dt + widget.data.closetime!}');
    int initialTime = 1;

    _timer = Timer.periodic(Duration(milliseconds: initialTime), (Timer timer) {
      int comparison = DateTime.now().compareTo(closingTime);
      bool res = comparison > 0 ? true : false;
      if (res) {
        if (mounted) {
          setState(() {
            initialTime = 1000;
            result = false;
            _timer?.cancel();
          });
        }
      }
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    var card = widget.data;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ShakeWidget(
        duration: Duration(milliseconds: 1),
        shakeConstant: ShakeHorizontalConstant1(),
        autoPlay: shouldShake,
        enableWebMouseHover: true,
        child: GestureDetector(
          onTap: () {
            if (result) {
              Get.to(GameScreensView(
                isOpenTimeActive: result,
                openingTime: "${card.opentime!}",
                closingTime: "${card.closetime!}",
                cardId :"${card.cardid!}",
                innerCards: card.innercards!,
              ));
            } else {
              setState(() {
                shouldShake = true;
                Future.delayed(Duration(milliseconds: AppValues.tileShakeTime),
                        () {
                      if (mounted) {
                        setState(() {
                          shouldShake = false;
                        });
                      }
                    });
              });
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 0, 75, 136),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(onPressed: () async {
                  try{
                    ChartResponseModel responseDAta = await controller.apiDataSource.getResultChart( adminId: AppValues.adminId , cardId: card.cardid!);
                    Get.to(ResultScreen(historyList: responseDAta.data));
                  }catch(e){
                    controller.showToast(context: Get.context!,message: "Error: ${e.toString()}");
                  }
                }, icon: const Icon(Icons.credit_card, color: AppColors.colorWhite, size: 40,)),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        card.title!.toString().toUpperCase(),
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${card.result1} - ',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '${card.result2} - ',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '${card.result3}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Open: ${card.opentime} | Close: ${card.closetime}',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Get.width / 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.play_circle_fill_rounded,
                          color: result
                              ? AppColors.activePlayButtonColor
                              : AppColors.inActivePlayButtonColor,
                          size: 40,
                        ),
                      ),
                      Text(
                        result ? 'Running' : 'Stopped',
                        style: TextStyle(
                          color: result
                              ? AppColors.activePlayButtonColor
                              : AppColors.inActivePlayButtonColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
