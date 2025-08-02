class GetMeterReadingsModal {
  int? flatId;
  String? flatNumber;
  double? readingValue;
  double? previousReading;

  GetMeterReadingsModal(
      {this.flatId, this.flatNumber, this.readingValue, this.previousReading});

  GetMeterReadingsModal.fromJson(Map<String, dynamic> json) {
    flatId = json['flatId'];
    flatNumber = json['flatNumber'];
    readingValue = json['readingValue'];
    previousReading = json['previousReading'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flatId'] = this.flatId;
    data['flatNumber'] = this.flatNumber;
    data['readingValue'] = this.readingValue;
    data['previousReading'] = this.previousReading;
    return data;
  }
}
