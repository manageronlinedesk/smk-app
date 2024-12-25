import 'package:flutter/material.dart';
import 'package:flutter_getx_template/app/core/values/app_colors.dart';

import '../values/text_styles.dart';

class CustomInputBox extends StatelessWidget {
  final String title;
  final bool isInputEnabled;
  final TextEditingController controller;
  final int maxInputLength;
  final List<String> suggestions;
  final TextInputType keyboardType;
  final String? hintText;
  final bool obscureText; // New optional parameter for obscuring text

  CustomInputBox({
    required this.title,
    required this.isInputEnabled,
    required this.controller,
    required this.maxInputLength,
    required this.suggestions,
    this.keyboardType = TextInputType.text,
    this.hintText,
    this.obscureText = false, // Initialize obscureText to false by default
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleBlackW500,
        ),
        SizedBox(height: 8),
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable<String>.empty();
            }
            return suggestions.where((String option) {
              return option.contains(textEditingValue.text);
            });
          },
          onSelected: (String selection) {
            controller.text = selection;
          },
          fieldViewBuilder: (
              BuildContext context,
              TextEditingController fieldTextEditingController,
              FocusNode fieldFocusNode,
              VoidCallback onFieldSubmitted,
              ) {
            if (fieldTextEditingController.text != controller.text) {
              fieldTextEditingController.text = controller.text;
              fieldTextEditingController.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
            }

            return TextField(
              controller: fieldTextEditingController,
              focusNode: fieldFocusNode,
              enabled: isInputEnabled,
              maxLength: maxInputLength,
              keyboardType: keyboardType,
              obscureText: obscureText, // Use obscureText parameter
              style: TextStyle(fontSize: 14),
              cursorColor: AppColors.gameAppBarColor,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                hintText: hintText,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                counterText: '',
              ),
              onChanged: (String value) {
                controller.text = value;
              },
            );
          },
        ),
      ],
    );
  }
}
