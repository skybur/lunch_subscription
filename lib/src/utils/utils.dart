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
    now.weekday == 5
        ? additionalDay = 3
        : now.weekday == 6 ? additionalDay = 2 : additionalDay;
    var start = now.add(Duration(days: additionalDay));
    var end = start.add(Duration(days: period));
    var initialDates = Utils
        .daysInRange(start, end)
        .where((date) => date.weekday != 6 && date.weekday != 7)
        .toList();
    while (initialDates.length < period) {
      var last = initialDates.last;
      additionalDay = last.weekday == 5 ? 3 : 1;
      initialDates.add(last.add(Duration(days: additionalDay)));
    }
    return initialDates;
  }
}
