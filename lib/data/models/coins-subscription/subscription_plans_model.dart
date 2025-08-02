class SubscriptionPlansModal {
  final List<Map<String, dynamic>> plans;

  SubscriptionPlansModal({required this.plans});

  factory SubscriptionPlansModal.fromJson(List<dynamic> json) {
    return SubscriptionPlansModal(
      plans: json.map((e) => e as Map<String, dynamic>).toList(),
    );
  }
}
