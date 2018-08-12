class SubscriptionData {
  final int boxCount;
  final List<DateTime> subscriptionDate;
  int get pricePerBox {
    var subscriptionLength = subscriptionDate?.length ?? 0;
    if (subscriptionLength < 10) return 25000;
    if (subscriptionLength < 20) return 24250;
    return 22500;
  }

  SubscriptionData({this.boxCount, this.subscriptionDate});

  SubscriptionData copyWith({int boxCount, List<DateTime> subscriptionDate}) {
    return SubscriptionData(
      boxCount: boxCount ?? this.boxCount,
      subscriptionDate: subscriptionDate ?? this.subscriptionDate,
    );
  }
}
