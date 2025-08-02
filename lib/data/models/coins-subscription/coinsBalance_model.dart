class CoinsBalance {
  final double balance;

  CoinsBalance({required this.balance});

  factory CoinsBalance.fromJson(Map<String, dynamic> json) {
    return CoinsBalance(
      balance: json['balance']?.toDouble() ?? 0.0,
    );
  }
}
