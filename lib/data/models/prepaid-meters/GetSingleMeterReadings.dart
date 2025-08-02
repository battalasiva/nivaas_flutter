class GetSingleFlatReadingsModal {
  int? flatId;
  String? flatNumber;
  double? readingValue;
  String? date;

  GetSingleFlatReadingsModal(
      {this.flatId, this.flatNumber, this.readingValue, this.date});

  GetSingleFlatReadingsModal.fromJson(Map<String, dynamic> json) {
    flatId = json['flatId'];
    flatNumber = json['flatNumber'];
    readingValue = json['readingValue'];
    date = json['date'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flatId'] = this.flatId;
    data['flatNumber'] = this.flatNumber;
    data['readingValue'] = this.readingValue;
    data['date'] = this.date;
    return data;
  }
}
