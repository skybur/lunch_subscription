import 'package:flutter/material.dart';

class PaddedShadowCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets innerPadding;
  final double borderRadius;

  const PaddedShadowCard({
    Key key,
    this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.innerPadding =
        const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
    this.borderRadius = 4.0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Material(
        color: Colors.white,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(borderRadius),
        elevation: 4.0,
        child: Padding(
          padding: innerPadding,
          child: child,
        ),
      ),
    );
  }
}
