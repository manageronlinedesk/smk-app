

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../values/app_colors.dart';
import '../values/app_values.dart';
import '../values/text_styles.dart';

class CustomTextInputField extends StatefulWidget{
  final String? text;
  final String? hintText;
  final double? width;
  final String? validationMsg;
  final bool isObscure;
  final TextAlign? textAlign;
  final bool ?checkValidation;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final double? height;
  final TextCapitalization textCapitalization;
  final TextEditingController? controller;
  final Color? textColor;
  final double? roundness;
  final bool? isMandatory;
  final double? borderWidth;
  final String? title;
  final int? maxLength;
  final bool readOnly;
  final TextStyle? titleStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  CustomTextInputField(

      {this.text,
        this.hintText,
        this.width,
        this.height,
        this.titleStyle,
        this.isMandatory,
        this.checkValidation,
        this.controller,
        this.isObscure = false,
        this.keyboardType,
        this.inputFormatters,
        this.textColor,
        this.roundness,
        this.borderWidth,
        this.title,
        this.textAlign,
        this.validator,
        this.suffixIcon,
        this. prefixIcon,
        this. readOnly = false,
        this.maxLength,
        this.validationMsg,
        this.textCapitalization =TextCapitalization.sentences,

      });

  @override
  _CustomTextInputField createState()=> _CustomTextInputField();
}

class _CustomTextInputField extends State<CustomTextInputField> {

  bool isFieldRequired = false;


  void initState() {
    super.initState();
    updateFieldRequired();
    if(widget.checkValidation??false){
      isFieldRequired = widget.isMandatory ?? false;
      if (widget.controller?.text != '') {
        isFieldRequired = false;
      }
    }
  }
  void updateFieldRequired() {
    if (widget.checkValidation ?? false) {
      isFieldRequired = widget.isMandatory ?? false;
      if (widget.controller?.text != '') {
        isFieldRequired = false;
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    if(widget.checkValidation??false){
      isFieldRequired = widget.isMandatory ?? false;
      if (isFieldRequired) {
        if (widget.controller?.text != '') {
          isFieldRequired = false;
        }
      }
    }
    updateFieldRequired();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          RichText(
            text: TextSpan(
              text: '${widget.title}',
              style: widget.titleStyle ??
                  const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 8 * 2,
                  ),
              children: <TextSpan>[
                TextSpan(
                  text: '${widget.isMandatory ?? false ? ' *' : ''}',
                  style: TextStyle(
                    color: Colors.red, // Set the color to red
                  ),
                ),
              ],
            ),
          ),

        SizedBox(
          height: widget.title != null ? 8 : 0,
        ),
        Container(
          width: widget.width,
          height: widget.height ?? Get.height * 0.043,
          child: TextFormField(
            textCapitalization : widget.textCapitalization,
            controller: widget.controller,
            keyboardType:widget. keyboardType,
            obscureText: widget.isObscure,
            inputFormatters: widget.inputFormatters,
            readOnly:widget. readOnly,
            textAlign: widget.textAlign ?? TextAlign.start,

            maxLength: widget.maxLength,
            buildCounter: (BuildContext context,
                {int? currentLength, int? maxLength, bool? isFocused}) {
              return null; // Return null to hide the character count UI
            },
            style: TextStyle(
              // color: context.theme.textTheme.bodyText1?.color,
              color: AppColors.gameAppBarColor
            ),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              hintText: widget.hintText,
              contentPadding: EdgeInsets.all(8),
              hintStyle: TextStyle(
                color: AppColors.gameAppBarColor
                    .withOpacity(AppValues.barrierColorOpacity),
                fontFamily: 'Inter',
              ),
              labelStyle: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.gameAppBarColor
                      .withOpacity(AppValues.barrierColorOpacity),
                  fontSize: titleStyleWhite.height),
              fillColor: AppColors.gameAppBarColor,
              // fillColor: context.theme.textTheme.bodyText1?.color,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: AppColors.gameAppBarColor.withOpacity(AppValues
                      .barrierColorOpacity), // Default focused border color
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: AppColors.errorColor, // Default enabled border color
                  width: 1.0,

                ),
              ),
              errorStyle: TextStyle(
                fontSize: 0,
                height: widget.height ?? Get.height * 0.044,
              ),
              focusedErrorBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(AppValues.barrierColorOpacity), // Default enabled border color
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: AppColors.gameAppBarColor.withOpacity(AppValues
                      .barrierColorOpacity), // Default enabled border color
                  width: 1.0,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: AppColors.errorColor, // Default enabled border color
                  width: 1.0,
                ),
              ),
            ),
            textAlignVertical: TextAlignVertical.center,
            // cursorColor: context.theme.textTheme.bodyText1?.color,
            cursorColor: AppColors.gameAppBarColor,
            cursorHeight: AppValues.margin_20,
            cursorWidth: 1,
            onChanged: (value) {
              print("current Value is : $value");
              if (widget.isMandatory ?? false) {
                if (value.trim() != "") {

                  setState(() {
                    isFieldRequired = false;
                  });
                } else {
                  setState(() {
                    isFieldRequired = true;
                  });
                }
              }

            },

          ),
        ),
        isFieldRequired
            ? SizedBox(
          height: 2,
        )
            : SizedBox.shrink(),
        isFieldRequired
            ? Text(
          '*Please enter ${widget.title}',
          style: TextStyle(
              color: Colors.red ,
              // fontSize: AppValues.margin_11

          ),
        )
            : SizedBox.shrink()
      ],
    );

  }


}