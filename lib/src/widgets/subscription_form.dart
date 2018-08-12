import 'package:flutter/material.dart';
import 'package:lunch_subscription/src/widgets/box_count_field.dart';
import 'package:lunch_subscription/src/widgets/padded_shadow_card.dart';
import 'package:lunch_subscription/src/widgets/subscription_calendar.dart';

class SubscriptionForm extends StatefulWidget {
  final int initialBoxCount;
  final ValueChanged<int> boxCountChanged;
  final List<DateTime> subscriptionDates;
  final ValueChanged<List<DateTime>> subscriptionDateChanged;

  const SubscriptionForm(
      {Key key,
      this.boxCountChanged,
      this.subscriptionDateChanged,
      this.initialBoxCount,
      this.subscriptionDates})
      : super(key: key);
  @override
  _SubscriptionFormState createState() => _SubscriptionFormState();
}

class _SubscriptionFormState extends State<SubscriptionForm> {
  List<DateTime> _currentlySelectedDates;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentlySelectedDates = widget.subscriptionDates;
  }

  @override
  Widget build(BuildContext context) {
    return PaddedShadowCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BoxCountField(
            boxCountChanged: widget.boxCountChanged,
            initialBoxCount: widget.initialBoxCount,
          ),
          //todo subscriptionlength
          SubscriptionCalendar(
            subscriptionDates: _currentlySelectedDates,
            subscriptionDateChanged: widget.subscriptionDateChanged,
          ),
          Padding(padding: EdgeInsets.only(top: 16.0), child: _buildProTips()),
        ],
      ),
    );
  }

  Widget _buildProTips() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.orange.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Pro Tips',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            'Atur jadwal langganan dengan menekan tanggal pada kalender. ' +
                'Selesaikan transaksi sebelum pukul 19:00 untuk mulai pengiriman besok.',
            style: TextStyle(color: Colors.black38),
          ),
        ],
      ),
    );
  }
}
