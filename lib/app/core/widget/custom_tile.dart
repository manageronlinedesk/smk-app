import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../values/app_colors.dart';

class CustomTile extends StatefulWidget {
  final VoidCallback? onTap1;
  final String title1;
  final String iconSvgName;
  final String label1;
  final Color iconColor;

  CustomTile({
    this.onTap1,
    required this.title1,
    required this.label1,
    required this.iconSvgName,
    required this.iconColor,
  });

  @override
  _CustomTileState createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: widget.onTap1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: Get.width * 0.45,
                height: Get.height * 0.13,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textColorSecondary
                          .withOpacity(0.08), // Shadow color
                      blurRadius: 1.0,
                      offset: Offset(0, 5), // Offset for left and bottom shadow
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.colorWhite),
                    color: AppColors.colorWhite,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(widget.iconSvgName,
                          // height: Get.height * 0.04,
                          // width: Get.height * 0.03,
                          color: widget.iconColor),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.title1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w700),
                          ),
                          Container(
                            width: Get.width * 0.25,
                            child: Text(
                              widget.label1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  wordSpacing: 1,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
