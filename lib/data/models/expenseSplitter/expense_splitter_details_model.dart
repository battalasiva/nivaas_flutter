
class SplitDetail {
  final int id;
  final int flatId;
  final String flatNo;
  final double splitRatio;
  final String splitMethod;

  SplitDetail({
    required this.id,
    required this.flatId,
    required this.flatNo,
    required this.splitRatio,
    required this.splitMethod,
  });

  factory SplitDetail.fromJson(Map<String, dynamic> json) {
    return SplitDetail(
      id: json['id'],
      flatId: json['flatId'],
      flatNo: json['flatNo'],
      splitRatio: json['splitRatio'].toDouble(),
      splitMethod: json['splitMethod'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'flatId': flatId,
      'flatNo' : flatNo,
      'splitRatio': splitRatio,
      'splitMethod': splitMethod,
    };
  }
}

class ExpenseSplitterDetailsModel {
  final int id;
  final int apartmentId;
  final String name;
  final double amount;
  final bool enabled;
  final String splitType;
  final DateTime createdDate;
  final DateTime updateDate;
  final List<SplitDetail> splitDetails;

  ExpenseSplitterDetailsModel({
    required this.id,
    required this.apartmentId,
    required this.name,
    required this.amount,
    required this.enabled,
    required this.splitType,
    required this.createdDate,
    required this.updateDate,
    required this.splitDetails,
  });

  factory ExpenseSplitterDetailsModel.fromJson(Map<String, dynamic> json) {
    return ExpenseSplitterDetailsModel(
      id: json['id'],
      apartmentId: json['apartmentId'],
      name: json['name'],
      amount: json['amount'].toDouble(),
      enabled: json['enabled'],
      splitType: json['splitType'],
      createdDate: DateTime.parse(json['createdDate']),
      updateDate: DateTime.parse(json['updateDate']),
      splitDetails: (json['splitDetails'] as List)
          .map((splitDetail) => SplitDetail.fromJson(splitDetail))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'apartmentId': apartmentId,
      'name': name,
      'amount': amount,
      'enabled': enabled,
      'splitType': splitType,
      'createdDate': createdDate.toIso8601String(),
      'updateDate': updateDate.toIso8601String(),
      'splitDetails': splitDetails.map((splitDetail) => splitDetail.toJson()).toList(),
    };
  }
}
