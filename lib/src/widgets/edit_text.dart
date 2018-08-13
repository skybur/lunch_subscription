import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunch_subscription/src/styles/app_theme.dart';

class NumberEditText extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String suffixText;
  final List<TextInputFormatter> inputFormatters;

  const NumberEditText(
      {Key key,
      this.focusNode,
      this.controller,
      this.onChanged,
      this.suffixText,
      this.inputFormatters})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightOrange),
          ),
          suffixText: suffixText,
          contentPadding: EdgeInsets.all(16.0),
        ),
        keyboardType: TextInputType.numberWithOptions(),
        onChanged: onChanged,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
