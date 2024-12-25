import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/waiting_screen_controller.dart';

class WaitingScreenView extends GetView<WaitingScreenController> {
  const WaitingScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaitingScreenController>(builder: (controller){
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child:  Image.asset(
                  'images/app_logo_name.png',
                ),
                // Lottie.asset(
                //   'animations/waiting_animation.json',
                //   width: 300,
                //   height: 300,
                //   reverse: false,
                // ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
