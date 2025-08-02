class CurrentBalanceModal {
  double? currentBalance;
  String? lastUpdated;

  CurrentBalanceModal({this.currentBalance, this.lastUpdated});

  CurrentBalanceModal.fromJson(Map<String, dynamic> json) {
    currentBalance = json['currentBalance'];
    lastUpdated = json['lastUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentBalance'] = this.currentBalance;
    data['lastUpdated'] = this.lastUpdated;
    return data;
  }
}
