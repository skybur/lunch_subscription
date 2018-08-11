import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunch_subscription/src/models/subscription_data.dart';
import 'package:lunch_subscription/src/styles/app_theme.dart';
import 'package:lunch_subscription/src/widgets/padded_shadow_card.dart';

class SubscriptionSummary extends StatelessWidget {
  final SubscriptionData data;

  const SubscriptionSummary({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PaddedShadowCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Rincian Langganan',
            style: AppTextStyle.header,
          ),
          Text('${data.boxCount} box'),
          Text('${data.subscriptionDate.length} hari'),
          Text('Mulai ' +
              DateFormat.yMMMMEEEEd('id').format(data.subscriptionDate.first)),
          Text(NumberFormat
              .currency(
                symbol: 'Rp ',
                decimalDigits: 0,
              )
              .format(computeTotal()))
        ],
      ),
    );
  }

  int computeTotal() {
    return data.boxCount * 25000 * data.subscriptionDate.length;
  }
}
