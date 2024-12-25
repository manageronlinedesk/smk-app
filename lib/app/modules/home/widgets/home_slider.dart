import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HomeSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height/3.5,
      width: Get.width,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.amber),
            child: Image.asset(
              'images/god_laxmi.jpg',
              width: Get.width,
              fit: BoxFit.fill,
            ),
          ),
          Lottie.asset(
            'animations/money_animation.json',
            width: Get.width,
            height: Get.height,
            fit: BoxFit.cover,
            repeat: true,
          ),
        ],
      ),
    );
  }
}
