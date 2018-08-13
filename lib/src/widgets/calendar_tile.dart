import 'package:flutter/material.dart';
import 'package:lunch_subscription/src/styles/app_theme.dart';
import 'package:lunch_subscription/src/utils/tuple.dart';

class CalendarTile extends StatelessWidget {
  final DateTime dateTime;
  final bool selected;
  final bool enabled;
  final BorderRadius borderRadius;
  final ValueChanged<Tuple<DateTime, bool>> onDateStateChanged;

  const CalendarTile({
    Key key,
    this.dateTime,
    this.selected = false,
    this.borderRadius,
    this.enabled = true,
    this.onDateStateChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!enabled) return;
        onDateStateChanged(Tuple(dateTime, !selected));
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1.0),
          color: selected ? AppColors.lightOrange : Colors.grey.shade200,
          borderRadius: borderRadius,
        ),
        child: Text(
          '${dateTime.day}',
          style: TextStyle(
              color: enabled
                  ? selected ? Colors.white : Colors.black87
                  : Colors.grey.shade300),
        ),
      ),
    );
  }
}
