import 'package:flutter/material.dart';
import 'package:lunch_subscription/src/models/subscription_data.dart';
import 'package:lunch_subscription/src/styles/app_theme.dart';
import 'package:lunch_subscription/src/utils/utils.dart';
import 'package:lunch_subscription/src/widgets/custom_stepper.dart';
import 'package:lunch_subscription/src/widgets/gradient_button.dart';
import 'package:lunch_subscription/src/widgets/subscription_form.dart';
import 'package:lunch_subscription/src/widgets/subscription_summary.dart';

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  SubscriptionData _subscriptionData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var initialDates = SubscriptionUtils.defaultSubscriptionDates(10);
    _subscriptionData = SubscriptionData(
      boxCount: 1,
      subscriptionDates: initialDates,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        backgroundColor: Colors.grey.shade300,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SubscriptionForm(
                initialBoxCount: _subscriptionData.boxCount,
                boxCountChanged: onBoxCountChanged,
                subscriptionDates: _subscriptionData.subscriptionDates,
                subscriptionDateChanged: onSubcriptionDatesChanged,
              ),
              SubscriptionSummary(data: _subscriptionData),
              GradientButton(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                innerPadding: EdgeInsets.all(16.0),
                gradientColors: [AppColors.darkOrange, AppColors.orange],
                cornerRadius: 4.0,
                onTap: () {},
                child: Text(
                  'Selanjutnya',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(128.0),
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading:
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
              title: Text('Mulai Langganan'),
            ),
            CustomStepper(
              steps: [
                StepperStep(title: "Mulai", selected: true, isStart: true),
                StepperStep(title: "Pengiriman", selected: false),
                StepperStep(title: "Pembayaran", selected: false, isEnd: true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onBoxCountChanged(int newBoxCount) {
    setState(() {
      _subscriptionData = _subscriptionData.copyWith(boxCount: newBoxCount);
    });
  }

  void onSubcriptionDatesChanged(List<DateTime> newDates) {
    setState(() {
      _subscriptionData =
          _subscriptionData.copyWith(subscriptionDate: newDates);
    });
  }
}
