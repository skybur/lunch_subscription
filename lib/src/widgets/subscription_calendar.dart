import 'package:date_utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunch_subscription/src/styles/app_theme.dart';
import 'package:lunch_subscription/src/utils/tuple.dart';
import 'package:lunch_subscription/src/utils/utils.dart';
import 'package:lunch_subscription/src/widgets/calendar_tile.dart';
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
    //hardcoded
    _currentMonth = DateTime(2018, 4);
  }

  @override
  void didUpdateWidget(SubscriptionCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _currentlySelectedSubscriptionDates = widget.subscriptionDates;
  }

  @override
  Widget build(BuildContext context) {
    _currentMonthDates = SubscriptionUtils.generateMonthDates(_currentMonth);
    return PaddedShadowCard(
      padding: EdgeInsets.only(top: 20.0),
      innerPadding: EdgeInsets.all(1.0),
      borderRadius: 8.0,
      child: Column(
        children: <Widget>[
          _generateCalendarHeader(),
          _generateCalendarDayDisplay(),
          GridView.count(
            shrinkWrap: true,
            primary: false,
            crossAxisCount: 7,
            children: _generateCalendarTiles(),
          ),
        ],
      ),
    );
  }

  List<CalendarTile> _generateCalendarTiles() {
    var tiles = <CalendarTile>[];
    var radiusBottomLeft = BorderRadius.only(bottomLeft: Radius.circular(8.0));
    var radiusBottomRight =
        BorderRadius.only(bottomRight: Radius.circular(8.0));
    _currentMonthDates.asMap().forEach((index, date) => tiles.add(
          CalendarTile(
            onDateStateChanged: onDateStateChanged,
            dateTime: date,
            selected: _currentlySelectedSubscriptionDates
                .any((d) => Utils.isSameDay(date, d)),
            enabled: date.weekday != DateTime.saturday &&
                date.weekday != DateTime.sunday &&
                //hardcoded today to 11 April 2018
                date.compareTo(DateTime(2018, 4, 12)) > 0,
            borderRadius: index == 28
                ? radiusBottomLeft
                : index == 34 ? radiusBottomRight : null,
          ),
        ));
    return tiles;
  }

  void onDateStateChanged(Tuple<DateTime, bool> value) {
    var selected = value.item2;
    var date = value.item1;
    if (!selected && _currentlySelectedSubscriptionDates.contains(date)) {
      _currentlySelectedSubscriptionDates.remove(date);
    }
    if (selected) {
      _currentlySelectedSubscriptionDates.add(date);
    }
    if (_currentlySelectedSubscriptionDates.length < 2) {
      var nextDay = date.add(Duration(days: 1));
      var latestDay = _currentlySelectedSubscriptionDates.last;
      if (Utils.isSameDay(nextDay, latestDay))
        nextDay = nextDay.add(Duration(days: 1));
      if (nextDay.weekday == DateTime.saturday)
        nextDay = nextDay.add(Duration(days: 2));
      if (Utils.isSameDay(nextDay, latestDay))
        nextDay = nextDay.add(Duration(days: 1));
      _currentlySelectedSubscriptionDates.add(nextDay);
    }
    setState(() {});
    widget.subscriptionDateChanged(_currentlySelectedSubscriptionDates);
  }

  Widget _generateCalendarHeader() {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () {
            _currentMonth =
                DateTime(_currentMonth.year, _currentMonth.month - 1);
            setState(() {});
          },
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
          onPressed: () {
            _currentMonth =
                DateTime(_currentMonth.year, _currentMonth.month + 1);
            setState(() {});
          },
          icon: Icon(Icons.chevron_right),
        ),
      ],
    );
  }

  Widget _generateCalendarDayDisplay() {
    return Row(
      children: SubscriptionUtils.generateShortDayName().map((day) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Center(
              child: Text(
                day,
                style: TextStyle(color: Colors.grey, fontSize: 12.0),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
