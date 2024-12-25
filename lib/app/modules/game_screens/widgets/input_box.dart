import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_getx_template/app/core/values/text_styles.dart';

import '../../../core/values/app_colors.dart';

class InputBox extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool isInputEnabled;
  final int maxInputLength;
  final TextInputType keyboardType; // New parameter for keyboard type

  InputBox({
    required this.title,
    required this.controller,
    required this.isInputEnabled,
    required this.maxInputLength,
    this.keyboardType = TextInputType.number, // Default to TextInputType.number
  });

  @override
  Widget build(BuildContext context) {
    String? validateInput(String? value) {
      if (value == null || value.isEmpty) {
        return null; // Allow empty input
      }

      if (keyboardType == TextInputType.text) {
        return null; // Allow any text input
      }

      final intValue = int.tryParse(value);
      if (intValue == null || intValue <= 0) {
        return 'Please enter a positive integer';
      }

      return null; // Input is valid
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleBlackW500
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              border: Border.all(width: 1, color: AppColors.primary)),
          child: SizedBox(
            height: 45,
            child: TextFormField(
              enabled: isInputEnabled,
              controller: controller,
              decoration: InputDecoration(
                contentPadding:
                EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                fillColor: Colors.transparent,
                filled: false,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: title,
              ),
              keyboardType: keyboardType,
              inputFormatters: [
                if (keyboardType == TextInputType.number)
                  FilteringTextInputFormatter.digitsOnly,
              ],
              validator: validateInput,
              maxLength: maxInputLength,
              maxLines: 1,
              buildCounter: (BuildContext context,
                  {int currentLength = 0,
                    bool isFocused = false,
                    int? maxLength}) {
                return Container(
                  height: 0,
                  width: 0,
                  child: SizedBox.shrink(), // Return an empty Text widget
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
