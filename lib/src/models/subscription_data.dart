class SubscriptionData {
  final int boxCount;
  final List<DateTime> subscriptionDate;

  SubscriptionData({this.boxCount, this.subscriptionDate});

  SubscriptionData copyWith({int boxCount, List<DateTime> subscriptionDate}) {
    return SubscriptionData(
      boxCount: boxCount ?? this.boxCount,
      subscriptionDate: subscriptionDate ?? this.subscriptionDate,
    );
  }
}
