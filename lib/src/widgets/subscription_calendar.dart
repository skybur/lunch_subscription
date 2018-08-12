import 'package:date_utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunch_subscription/src/styles/app_theme.dart';
import 'package:lunch_subscription/src/widgets/padded_shadow_card.dart';

class SubscriptionCalendar extends StatefulWidget {
  final List<DateTime> subscriptionDates;
  final ValueChanged<List<DateTime>> subscriptionDateChanged;

  const SubscriptionCalendar(
      {Key key, this.subscriptionDates, this.subscriptionDateChanged})
      : super(key: key);
  @override
  _SubscriptionCalendarState createState() => _SubscriptionCalendarState();
}

class _SubscriptionCalendarState extends State<SubscriptionCalendar> {
  List<DateTime> _currentlySelectedSubscriptionDates;
  List<DateTime> _currentMonthDates;
  DateTime _currentMonth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentlySelectedSubscriptionDates = widget.subscriptionDates;
    _currentMonth = DateTime(2018, 4);
    // _currentMonth = DateTime.now();
    _currentMonthDates = _generateMonthDates(_currentMonth);
  }

  @override
  Widget build(BuildContext context) {
    var tiles = <CalendarTile>[];
    var radiusBottomLeft = BorderRadius.only(bottomLeft: Radius.circular(8.0));
    var radiusBottomRight =
        BorderRadius.only(bottomRight: Radius.circular(8.0));
    _currentMonthDates.asMap().forEach((index, date) => tiles.add(CalendarTile(
          dateTime: date,
          selected: _currentlySelectedSubscriptionDates
              .any((d) => Utils.isSameDay(date, d)),
          enabled: date.weekday != 6 &&
              date.weekday != 7 &&
              date.compareTo(DateTime(2018, 4, 12)) > 0,
          borderRadius: index == 28
              ? radiusBottomLeft
              : index == 34 ? radiusBottomRight : null,
        )));
    return PaddedShadowCard(
      padding: EdgeInsets.only(top: 16.0),
      innerPadding: EdgeInsets.all(1.0),
      borderRadius: 8.0,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.chevron_left),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    DateFormat.yMMMM('id').format(_currentMonth),
                    style: AppTextStyle.header.copyWith(fontSize: 16.0),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.chevron_right),
              ),
            ],
          ),
          Row(
            children: _generateShortDayName().map((day) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  child: Center(
                      child: Text(day, style: TextStyle(color: Colors.grey))),
                ),
              );
            }).toList(),
          ),
          GridView.count(
            shrinkWrap: true,
            primary: false,
            crossAxisCount: 7,
            children: tiles,
          ),
        ],
      ),
    );
  }

  List<DateTime> _generateMonthDates(DateTime month) {
    var first = Utils.firstDayOfMonth(month);
    var firstDay = first.weekday;
    if (firstDay == DateTime.sunday) {
      first = first.add(Duration(days: 1));
    } else if (firstDay != DateTime.monday) {
      first = first.subtract(Duration(days: (firstDay - 1)));
    }

    var last = Utils.lastDayOfMonth(month);
    var lastDay = last.weekday;
    // if (lastDay == DateTime.monday) {
    //   last = last.subtract(Duration(days: 1));
    // } else if (lastDay != DateTime.sunday) {
    last = last.add(Duration(days: (7 - lastDay)));
    // }

    return Utils.daysInRange(first, last).toList();
  }

  List<String> _generateShortDayName() {
    return ['SEN', 'SEL', 'RAB', 'KAM', 'JUM', 'SAB', 'MIN'];
  }
}

class CalendarTile extends StatefulWidget {
  final DateTime dateTime;
  final bool selected;
  final bool enabled;
  final BorderRadius borderRadius;

  const CalendarTile({
    Key key,
    this.dateTime,
    this.selected = false,
    this.borderRadius,
    this.enabled = true,
  }) : super(key: key);

  @override
  _CalendarTileState createState() => _CalendarTileState();
}

class _CalendarTileState extends State<CalendarTile> {
  bool _currentlySelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentlySelected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.0),
        color:
            _currentlySelected ? AppColors.lightOrange : Colors.grey.shade200,
        borderRadius: widget.borderRadius,
      ),
      child: Text(
        '${widget.dateTime.day}',
        style: TextStyle(
            color: widget.enabled
                ? _currentlySelected ? Colors.white : Colors.black87
                : Colors.grey.shade300),
      ),
    );
  }
}
