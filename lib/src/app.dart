import 'package:flutter/material.dart';
import 'package:lunch_subscription/src/screens/subscription_screen.dart';
import 'package:lunch_subscription/src/styles/app_theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColors.lightOrange,
        textSelectionColor: AppColors.lightOrange,
        hintColor: AppColors.lightOrange,
      ),
      home: SubscriptionScreen(),
    );
  }
}
