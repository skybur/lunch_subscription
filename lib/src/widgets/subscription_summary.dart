import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunch_subscription/src/models/subscription_data.dart';
import 'package:lunch_subscription/src/styles/app_theme.dart';
import 'package:lunch_subscription/src/utils/utils.dart';
import 'package:lunch_subscription/src/widgets/padded_shadow_card.dart';
import 'package:lunch_subscription/src/widgets/summary_entry.dart';

class SubscriptionSummary extends StatelessWidget {
  final SubscriptionData data;

  const SubscriptionSummary({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var labelStyle = TextStyle(fontSize: 16.0, color: Colors.black87);
    var subLabelStyle = TextStyle(fontSize: 14.0, color: Colors.black45);
    var totalStyle = AppTextStyle.header.copyWith(fontSize: 16.0);
    return PaddedShadowCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text('Rincian Langganan', style: AppTextStyle.header),
          ),
          SummaryEntry(
            entryLabel: 'Harga per box',
            labelStyle: labelStyle,
            entryValue: NumberFormat
                .currency(symbol: 'Rp ', decimalDigits: 0)
                .format(SubscriptionUtils
                    .getPricePerBox(data.subscriptionDates.length)),
            valueStyle: labelStyle,
          ),
          _buildDivider(),
          SummaryEntry(
            entryLabel: 'Jumlah Box',
            labelStyle: labelStyle,
            entryValue: '${data.boxCount} box',
            valueStyle: labelStyle,
          ),
          _buildDivider(),
          SummaryEntry(
            entryLabel: 'Lama Langganan',
            labelStyle: labelStyle,
            entryValue: '${data.subscriptionDates.length} hari',
            valueStyle: labelStyle,
            entrySublabel: 'Mulai ' +
                DateFormat
                    .yMMMMEEEEd('id')
                    .format(data.subscriptionDates.first),
            subLabelStyle: subLabelStyle,
          ),
          _buildDivider(),
          SummaryEntry(
            entryLabel: 'Total',
            labelStyle: totalStyle,
            entryValue: NumberFormat
                .currency(
                  symbol: 'Rp ',
                  decimalDigits: 0,
                )
                .format(computeTotal()),
            valueStyle: totalStyle,
          ),
        ],
      ),
    );
  }

  _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.0),
      child: Container(height: 1.0, color: Colors.grey.shade300),
    );
  }

  int computeTotal() {
    return data.boxCount *
        SubscriptionUtils.getPricePerBox(data.subscriptionDates.length) *
        data.subscriptionDates.length;
  }
}
