import 'dart:convert';

class UserDuesModal {
  final int id;
  final String dueDate;
  final int apartmentId;
  final int flatId;
  final double cost;
  final double fixedCost;
  final String status;
  final List<MaintenanceDetail> maintenanceDetails;
  final List<ExpenseSplitters> expenseSplitters;

  UserDuesModal({
    required this.id,
    required this.dueDate,
    required this.apartmentId,
    required this.flatId,
    required this.cost,
    required this.fixedCost,
    required this.status,
    required this.maintenanceDetails,
    required this.expenseSplitters,
  });

  factory UserDuesModal.fromJson(Map<String, dynamic> json) {
    return UserDuesModal(
      id: json['id'],
      dueDate: json['dueDate'],
      apartmentId: json['apartmentId'],
      flatId: json['flatId'],
      cost: json['cost'],
      fixedCost: json['fixedCost'],
      status: json['status'],
      maintenanceDetails: (json['maintenanceDetails'] != null &&
              json['maintenanceDetails'].toString().isNotEmpty)
          ? (jsonDecode(json['maintenanceDetails']) as List)
              .map((item) => MaintenanceDetail.fromJson(item))
              .toList()
          : [],
      expenseSplitters: (json['expenseSplitters'] != null &&
              json['expenseSplitters'].toString().isNotEmpty)
          ? (jsonDecode(json['expenseSplitters']) as List)
              .map((item) => ExpenseSplitters.fromJson(item))
              .toList()
          : [],
    );
  }

  static List<UserDuesModal> fromJsonList(dynamic jsonDecode) {
    final parsed = jsonDecode as List<dynamic>;
    return parsed.map((json) => UserDuesModal.fromJson(json)).toList();
  }
}

class ConfigRange {
  final int id;
  final double costPerUnit, startRange;
  final double? endRange;

  ConfigRange({
    required this.id,
    required this.costPerUnit,
    required this.startRange,
    this.endRange,
  });

  factory ConfigRange.fromJson(Map<String, dynamic> json) {
    return ConfigRange(
      id: json['id'],
      costPerUnit: json['costPerUnit'],
      startRange: json['startRange'],
      endRange: json['endRange'],
    );
  }
}

class MaintenanceDetail {
  final int? prepaidMeterId;
  final double? costPerUnit,
      previousReading,
      unitsConsumed,
      currentReading,
      costPerPrepaidMeter;
  final String? name;
  final List<ConfigRange>? configRangeList;

  MaintenanceDetail({
    this.prepaidMeterId,
    this.costPerUnit,
    this.unitsConsumed,
    this.name,
    this.previousReading,
    this.currentReading,
    this.costPerPrepaidMeter,
    this.configRangeList,
  });

  factory MaintenanceDetail.fromJson(Map<String, dynamic> json) {
    return MaintenanceDetail(
      prepaidMeterId: json['prepaidMeterId'],
      costPerUnit: json['costPerUnit'],
      unitsConsumed: json['unitsConsumed'],
      name: json['name'],
      previousReading: json['previousReading'],
      currentReading: json['currentReading'],
      costPerPrepaidMeter: json['costPerPrepaidMeter'],
      configRangeList: json['configRangeList'] != null
          ? (json['configRangeList'] as List)
              .map((e) => ConfigRange.fromJson(e))
              .toList()
          : null,
    );
  }
}

class ExpenseSplitters {
  final int? splitterId, flatId;
  final double? splitRatio, splitCost;
  final String? name, splitMethod, splitSchedule;

  ExpenseSplitters({
    this.splitterId,
    this.flatId,
    this.splitMethod,
    this.splitSchedule,
    this.name,
    this.splitRatio,
    this.splitCost,
  });

  factory ExpenseSplitters.fromJson(Map<String, dynamic> json) {
    return ExpenseSplitters(
      splitterId: json['splitterId'],
      flatId: json['flatId'],
      name: json['name'],
      splitMethod: json['splitMethod'],
      splitSchedule: json['splitSchedule'],
      splitRatio: json['splitRatio'],
      splitCost: json['splitCost'],
    );
  }
}

List<UserDuesModal> parseUserDuesResponse(String responseBody) {
  final parsed = json.decode(responseBody) as List<dynamic>;
  return parsed.map((json) => UserDuesModal.fromJson(json)).toList();
}
