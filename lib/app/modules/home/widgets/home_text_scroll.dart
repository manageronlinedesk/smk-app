import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_scroll/text_scroll.dart';

class HomeTextScroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 7),
      color: Color.fromARGB(255, 0, 75, 136),
      child: const TextScroll(
        'This is the 100 Percent trust and reliability, prioritizing your security, Enjoy real-time updates and live results, ensuring you never miss a beat. Our 24/7 customer support is always there to assist you, Ready to try your luck? Download the app now!',
        mode: TextScrollMode.endless,
        style: TextStyle(color: Colors.white, fontSize: 15, letterSpacing: 1),
        textAlign: TextAlign.left,
        selectable: true,
      ),
    );
  }
}
