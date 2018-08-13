import 'package:flutter/material.dart';
import 'package:lunch_subscription/src/styles/app_theme.dart';

class ValueChangedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback valueChange;
  final EdgeInsets padding;
  final double textScaleFactor;
  final BorderRadius radius;

  const ValueChangedButton(
      {Key key,
      this.buttonText,
      this.valueChange,
      this.padding,
      this.textScaleFactor,
      this.radius})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: radius,
      color: AppColors.lightOrange,
      child: InkWell(
        highlightColor: AppColors.darkOrange,
        splashColor: AppColors.darkOrange,
        onTap: valueChange,
        child: Padding(
          padding: padding,
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white),
            textScaleFactor: textScaleFactor,
          ),
        ),
      ),
    );
  }
}
