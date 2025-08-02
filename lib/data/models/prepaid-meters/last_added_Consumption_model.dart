class LastAddedConsumptionModal {
  double? unitsConsumed;
  String? flatNumber;
  int? flatId;

  LastAddedConsumptionModal({this.unitsConsumed, this.flatNumber, this.flatId});

  LastAddedConsumptionModal.fromJson(Map<String, dynamic> json) {
    unitsConsumed = json['unitsConsumed'];
    flatNumber = json['flatNumber'];
    flatId = json['flatId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unitsConsumed'] = this.unitsConsumed;
    data['flatNumber'] = this.flatNumber;
    data['flatId'] = this.flatId;
    return data;
  }
}
