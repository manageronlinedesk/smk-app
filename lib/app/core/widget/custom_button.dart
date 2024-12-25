import 'package:flutter/material.dart';
import '../values/app_colors.dart';
import '../values/app_values.dart';
import '../values/text_styles.dart';
class CustomButton extends StatelessWidget {
  @override
  CustomButton(
      {this.height,
        this.color,
        this.width,
        this.buttonColor,
        this.textStyle,
        required this.text,
        this.icon,
        this.onPressed});
  final Color? color;
  final double? height;
  final double? width;
  final Color? buttonColor;
  final IconData? icon;
  final String text;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40 ,
        width: width ,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  buttonColor ?? AppColors.gameAppBarColor)),
          onPressed: onPressed,
          child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style:textStyle?? TextStyle(
                      fontSize: AppValues.margin,
                      fontWeight: whiteText18.fontWeight,
                      color: color ?? AppColors.textColorWhite),
                ),
              )),
        ));
  }
}