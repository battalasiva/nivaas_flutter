class SplitDetail {
  final int flatId;
  final double splitRatio;

  SplitDetail({
    required this.flatId,
    required this.splitRatio,
  });

  factory SplitDetail.fromJson(Map<String, dynamic> json) {
    return SplitDetail(
      flatId: json['flatId'],
      splitRatio: json['splitRatio'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flatId': flatId,
      'splitRatio': splitRatio,
    };
  }
  @override
  String toString() {
    return 'SplitDetail(flatId: $flatId, splitRatio: $splitRatio)';
  }
}

class AddExpenseSplitterModel {
  final int apartmentId;
  final double amount;
  final String splitSchedule;
  final bool enabled;
  final String splitterName;
  final String splitMethod;
  final List<SplitDetail> splitDetails;

  AddExpenseSplitterModel({
    required this.apartmentId,
    required this.amount,
    required this.splitSchedule,
    required this.enabled,
    required this.splitterName,
    required this.splitMethod,
    required this.splitDetails,
  });

  factory AddExpenseSplitterModel.fromJson(Map<String, dynamic> json) {
    var list = json['splitDetails'] as List;
    List<SplitDetail> splitDetailsList = list.map((i) => SplitDetail.fromJson(i)).toList();

    return AddExpenseSplitterModel(
      apartmentId: json['apartmentId'],
      amount: json['amount'].toDouble(),
      splitSchedule: json['splitSchedule'],
      enabled: json['enabled'],
      splitterName: json['splitterName'],
      splitMethod: json['splitMethod'],
      splitDetails: splitDetailsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'apartmentId': apartmentId,
      'amount': amount,
      'splitSchedule': splitSchedule,
      'enabled': enabled,
      'splitterName': splitterName,
      'splitMethod': splitMethod,
      'splitDetails': splitDetails.map((e) => e.toJson()).toList(),
    };
  }
  @override
  String toString() {
    return 'AddExpenseSplitterModel(apartmentId: $apartmentId, amount: $amount, splitSchedule: $splitSchedule, enabled: $enabled, splitterName: $splitterName, splitDetails: $splitDetails)';
  }
}
