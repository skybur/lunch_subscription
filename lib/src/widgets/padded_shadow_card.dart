import 'package:flutter/material.dart';

class PaddedShadowCard extends StatelessWidget {
  final Widget child;

  const PaddedShadowCard({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Material(
        color: Colors.white,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4.0),
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 16.0,
          ),
          child: child,
        ),
      ),
    );
  }
}
