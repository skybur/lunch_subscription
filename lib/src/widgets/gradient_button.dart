import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Widget child;
  final double cornerRadius;
  final List<Color> gradientColors;
  final Alignment begin;
  final Alignment end;
  final Alignment alignment;
  final EdgeInsets innerPadding;
  final EdgeInsets padding;
  final VoidCallback onTap;

  const GradientButton({
    Key key,
    this.cornerRadius = 0.0,
    @required this.gradientColors,
    this.onTap,
    this.child,
    this.alignment,
    this.innerPadding = EdgeInsets.zero,
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          child: Container(
            alignment: alignment,
            padding: innerPadding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(cornerRadius),
              gradient: LinearGradient(
                colors: gradientColors,
                begin: begin,
                end: end,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
