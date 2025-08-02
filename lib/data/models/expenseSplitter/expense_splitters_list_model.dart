
class SplitDetail {
  final int id;
  final int flatId;
  final double splitRatio;
  final String flatNo;

  SplitDetail({
    required this.id,
    required this.flatId,
    required this.splitRatio,
    required this.flatNo
  });

  factory SplitDetail.fromJson(Map<String, dynamic> json) {
    return SplitDetail(
      id: json['id'],
      flatId: json['flatId'],
      splitRatio: json['splitRatio'].toDouble(),
      flatNo: json['flatNo']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'flatId': flatId,
      'splitRatio': splitRatio,
      'flatNo': flatNo
    };
  }
}

class ExpenseSplittersListModel {
  final int id;
  final int apartmentId;
  final String name;
  final double amount;
  final bool enabled;
  final String splitSchedule;
  final String splitMethod;
  final String createdDate;
  final String updateDate;
  final List<SplitDetail> splitDetails;

  ExpenseSplittersListModel({
    required this.id,
    required this.apartmentId,
    required this.name,
    required this.amount,
    required this.enabled,
    required this.splitSchedule,
    required this.splitMethod,
    required this.createdDate,
    required this.updateDate,
    required this.splitDetails,
  });

  factory ExpenseSplittersListModel.fromJson(Map<String, dynamic> json) {
    var splitDetailsJson = json['splitDetails'] as List;
    List<SplitDetail> splitDetailsList = splitDetailsJson
        .map((splitDetailJson) => SplitDetail.fromJson(splitDetailJson))
        .toList();

    return ExpenseSplittersListModel(
      id: json['id'],
      apartmentId: json['apartmentId'],
      name: json['name'],
      amount: json['amount'].toDouble(),
      enabled: json['enabled'],
      splitSchedule: json['splitSchedule'],
      splitMethod: json['splitMethod'],
      createdDate: json['createdDate'],
      updateDate: json['updateDate'],
      splitDetails: splitDetailsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'apartmentId': apartmentId,
      'name': name,
      'amount': amount,
      'enabled': enabled,
      'splitSchedule': splitSchedule,
      'splitMethod': splitMethod,
      'createdDate': createdDate,
      'updateDate': updateDate,
      'splitDetails': splitDetails.map((splitDetail) => splitDetail.toJson()).toList(),
    };
  }

  static List<ExpenseSplittersListModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => ExpenseSplittersListModel.fromJson(json)).toList();
  }
  ExpenseSplittersListModel copyWith({
    int? id,
    int? apartmentId,
    String? name,
    double? amount,
    bool? enabled,
    String? splitSchedule,
    String? splitMethod,
    String? createdDate,
    String? updateDate,
    List<SplitDetail>? splitDetails,
  }) {
    return ExpenseSplittersListModel(
      id: id ?? this.id,
      apartmentId: apartmentId ?? this.apartmentId,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      enabled: enabled ?? this.enabled,
      splitSchedule: splitSchedule ?? this.splitSchedule,
      splitMethod: splitMethod ?? this.splitMethod,
      createdDate: createdDate ?? this.createdDate,
      updateDate: updateDate ?? this.updateDate,
      splitDetails: splitDetails ?? this.splitDetails,
    );
  }
}