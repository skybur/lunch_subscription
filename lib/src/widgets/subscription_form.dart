import 'package:flutter/material.dart';
import 'package:lunch_subscription/src/widgets/box_count_field.dart';

class SubscriptionForm extends StatefulWidget {
  final int initialBoxCount;
  final ValueChanged<int> boxCountChanged;
  final ValueChanged<List<DateTime>> subscriptionDateChanged;

  const SubscriptionForm(
      {Key key,
      this.boxCountChanged,
      this.subscriptionDateChanged,
      this.initialBoxCount})
      : super(key: key);
  @override
  _SubscriptionFormState createState() => _SubscriptionFormState();
}

class _SubscriptionFormState extends State<SubscriptionForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        color: Colors.white,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(4.0),
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BoxCountField(
                boxCountChanged: widget.boxCountChanged,
                initialBoxCount: widget.initialBoxCount,
              ),
              //todo subscriptionlength
              //todo calendars
              //todo protips
            ],
          ),
        ),
      ),
    );
  }
}
