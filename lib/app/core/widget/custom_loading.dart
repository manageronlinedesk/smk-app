import 'package:flutter/material.dart';

import '../values/app_colors.dart';
class CustomLoading {
  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return  Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppColors.colorWhite,),
            ],
          ),
        );

      },
    );
  }
  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }
}