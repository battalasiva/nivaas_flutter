class GetSingleFlatLastAddedConsumptionUnitsModal {
  double? unitsConsumed;
  String? flatNumber;
  int? flatId;
  String? date;

  GetSingleFlatLastAddedConsumptionUnitsModal(
      {this.unitsConsumed, this.flatNumber, this.flatId, this.date});

  GetSingleFlatLastAddedConsumptionUnitsModal.fromJson(
      Map<String, dynamic> json) {
    unitsConsumed = json['unitsConsumed'];
    flatNumber = json['flatNumber'];
    flatId = json['flatId'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unitsConsumed'] = this.unitsConsumed;
    data['flatNumber'] = this.flatNumber;
    data['flatId'] = this.flatId;
    data['date'] = this.date;
    return data;
  }
}
