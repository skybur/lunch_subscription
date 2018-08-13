import 'package:date_utils/date_utils.dart';

class SubscriptionUtils {
  static int getPricePerBox(int periodLength) {
    if (periodLength < 10) return 25000;
    if (periodLength < 20) return 24250;
    return 22500;
  }

  static List<DateTime> defaultSubscriptionDates(int period) {
    var now = DateTime(2018, 4, 12);
    var additionalDay = now.hour < 19 ? 1 : 2;
    now.weekday == DateTime.friday
        ? additionalDay = 3
        : now.weekday == DateTime.saturday ? additionalDay = 2 : additionalDay;
    var start = now.add(Duration(days: additionalDay));
    var end = start.add(Duration(days: period));
    var initialDates = Utils
        .daysInRange(start, end)
        .where((date) =>
            date.weekday != DateTime.saturday &&
            date.weekday != DateTime.sunday)
        .toList();
    while (initialDates.length < period) {
      var last = initialDates.last;
      additionalDay = last.weekday == DateTime.friday ? 3 : 1;
      initialDates.add(last.add(Duration(days: additionalDay)));
    }
    return initialDates;
  }

  static List<DateTime> generateMonthDates(DateTime month) {
    var first = Utils.firstDayOfMonth(month);
    var firstDay = first.weekday;
    if (firstDay == DateTime.sunday) {
      first = first.add(Duration(days: 1));
    } else if (firstDay != DateTime.monday) {
      first = first.subtract(Duration(days: (firstDay - 1)));
    }

    var last = Utils.lastDayOfMonth(month);
    var lastDay = last.weekday;
    last = last.add(Duration(days: (8 - lastDay)));

    return Utils.daysInRange(first, last).toList();
  }

  static List<String> generateShortDayName() {
    return ['SEN', 'SEL', 'RAB', 'KAM', 'JUM', 'SAB', 'MIN'];
  }
}
