import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunch_subscription/src/screens/custom_period_dialog.dart';
import 'package:lunch_subscription/src/styles/app_theme.dart';
import 'package:lunch_subscription/src/utils/utils.dart';

class SubscriptionPeriodChooser extends StatefulWidget {
  final List<DateTime> selectedSubcriptionDate;
  final ValueChanged<int> onPeriodSelected;

  const SubscriptionPeriodChooser(
      {Key key, this.selectedSubcriptionDate, this.onPeriodSelected})
      : super(key: key);

  @override
  _SubscriptionPeriodChooserState createState() =>
      _SubscriptionPeriodChooserState();
}

class _SubscriptionPeriodChooserState extends State<SubscriptionPeriodChooser> {
  PeriodEntry _selectedPeriod;
  List<PeriodEntry> _periods;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateDataSet();
  }

  @override
  void didUpdateWidget(SubscriptionPeriodChooser oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _updateDataSet();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 16.0),
          child: Text('Lama Langganan', style: AppTextStyle.header),
        ),
        GridView.count(
          shrinkWrap: true,
          primary: false,
          crossAxisCount: 2,
          childAspectRatio: 5 / 2,
          children: _periods.map((p) {
            return PeriodButton(
              entry: p,
              selected: p.periodType == _selectedPeriod.periodType,
              onPeriodSelected: onPeriodSelected,
            );
          }).toList(),
        ),
      ],
    );
  }

  void onPeriodSelected(PeriodEntry entry) async {
    if (entry.periodType == PeriodEnum.custom) {
      var custLength = await showDialog<int>(
          context: context,
          barrierDismissible: false,
          builder: (context) => CustomPeriodDialog(
                currentLength: _selectedPeriod.periodValue,
              ));
      if (custLength == null) return;
      entry = PeriodEntry(entry.periodType, custLength);
    }
    setState(() {
      _selectedPeriod = entry;
    });
    widget.onPeriodSelected(_selectedPeriod.periodValue);
  }

  void _updateDataSet() {
    _periods = [
      PeriodEntry(PeriodEnum.twenty, 20),
      PeriodEntry(PeriodEnum.ten, 10),
      PeriodEntry(PeriodEnum.five, 5),
      PeriodEntry(PeriodEnum.custom, widget.selectedSubcriptionDate.length),
    ];
    var periodCount = widget.selectedSubcriptionDate.length;
    _selectedPeriod =
        _periods.firstWhere((entry) => entry.periodValue == periodCount);
  }
}

class PeriodButton extends StatelessWidget {
  final PeriodEntry entry;
  final bool selected;
  final ValueChanged<PeriodEntry> onPeriodSelected;

  const PeriodButton(
      {Key key, this.entry, this.selected, this.onPeriodSelected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var labelStyle = TextStyle(
        fontSize: 16.0,
        color: selected ? Colors.white : Colors.black54,
        fontWeight: FontWeight.bold);
    var subLabelStyle = TextStyle(
        fontSize: 14.0, color: selected ? Colors.white : Colors.black54);
    var buttonDisplay = <Widget>[];
    if (entry.periodType == PeriodEnum.custom && !selected) {
      buttonDisplay.addAll([
        Text('Pilih Sendiri', style: labelStyle),
        Text('Min. 2 hari', style: subLabelStyle),
      ]);
    } else {
      var priceString = NumberFormat
          .currency(symbol: 'Rp ', decimalDigits: 0)
          .format(SubscriptionUtils.getPricePerBox(entry.periodValue));
      buttonDisplay.addAll([
        Text('${entry.periodValue} hari', style: labelStyle),
        Text('$priceString/hari', style: subLabelStyle),
      ]);
    }
    return GestureDetector(
      onTap: () => onPeriodSelected(entry),
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: selected ? AppColors.lightOrange : Colors.white,
            border: Border.all(color: AppColors.lightOrange, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buttonDisplay,
          ),
        ),
      ),
    );
  }
}

class PeriodEntry {
  final PeriodEnum periodType;
  final int periodValue;
  PeriodEntry(this.periodType, this.periodValue);
}

enum PeriodEnum { custom, five, ten, twenty }
