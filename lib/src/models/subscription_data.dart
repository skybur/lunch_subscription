class SubscriptionData {
  final int boxCount;
  final List<DateTime> subscriptionDates;

  SubscriptionData({this.boxCount, this.subscriptionDates});

  SubscriptionData copyWith({int boxCount, List<DateTime> subscriptionDate}) {
    return SubscriptionData(
      boxCount: boxCount ?? this.boxCount,
      subscriptionDates: subscriptionDate ?? this.subscriptionDates,
    );
  }
}
