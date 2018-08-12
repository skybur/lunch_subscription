class SubscriptionData {
  final int boxCount;
  final List<DateTime> subscriptionDates;
  int get pricePerBox {
    var subscriptionLength = subscriptionDates?.length ?? 0;
    if (subscriptionLength < 10) return 25000;
    if (subscriptionLength < 20) return 24250;
    return 22500;
  }

  SubscriptionData({this.boxCount, this.subscriptionDates});

  SubscriptionData copyWith({int boxCount, List<DateTime> subscriptionDate}) {
    return SubscriptionData(
      boxCount: boxCount ?? this.boxCount,
      subscriptionDates: subscriptionDate ?? this.subscriptionDates,
    );
  }
}
