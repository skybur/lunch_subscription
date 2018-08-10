import 'package:date_utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:lunch_subscription/src/models/subscription_data.dart';
import 'package:lunch_subscription/src/styles/app_theme.dart';
import 'package:lunch_subscription/src/widgets/custom_stepper.dart';
import 'package:lunch_subscription/src/widgets/gradient_button.dart';
import 'package:lunch_subscription/src/widgets/subscription_form.dart';

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
    var now = DateTime.now();
    var start = startDate(now);
    var end = start.add(Duration(days: 5));
    var initialDates = Utils.daysInRange(start, end).toList();
    _subscriptionData =
        SubscriptionData(boxCount: 1, subscriptionDate: initialDates);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        backgroundColor: Colors.grey.shade300,
        body: ListView(
          children: <Widget>[
            //todo subscription form
            SubscriptionForm(
              initialBoxCount: _subscriptionData.boxCount,
              boxCountChanged: onBoxCountChanged,
            ),
            //todo subscription summary
            Padding(
              padding: EdgeInsets.all(16.0),
              child: GradientButton(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                gradientColors: [AppColors.darkOrange, AppColors.orange],
                cornerRadius: 4.0,
                onTap: () {},
                child: Text(
                  'Selanjutnya',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
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
              leading: InkWell(
                  onTap: () {},
                  child: Container(child: Icon(Icons.arrow_back))),
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

  DateTime startDate(DateTime now) {
    var hour = now.hour;
    var weekday = now.weekday;
    var additionalDay = hour < 19 ? 1 : weekday == 5 ? 3 : 2;
    return now.add(Duration(days: additionalDay));
  }

  void onBoxCountChanged(int newBoxCount) {
    setState(() {
      _subscriptionData = _subscriptionData.copyWith(boxCount: newBoxCount);
      debugPrint(_subscriptionData.boxCount.toString());
    });
  }
}
