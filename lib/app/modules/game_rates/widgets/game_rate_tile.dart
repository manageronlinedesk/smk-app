import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';

class GameRateTile extends StatelessWidget {
  String title;
  String range;

  GameRateTile({required this.title, required this.range});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        width: Get.width - 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(color: AppColors.colorWhite),
            ),
            Text(
              range,
              style: TextStyle(color: AppColors.colorWhite),
            ),
          ],
        ),
      ),
    );
  }
}
