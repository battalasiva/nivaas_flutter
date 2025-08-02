class ConsumptionRequest {
  final int apartmentId;
  final int prepaidId;
  final List<FlatConsumption> flatConsumption;

  ConsumptionRequest({
    required this.apartmentId,
    required this.prepaidId,
    required this.flatConsumption,
  });

  Map<String, dynamic> toJson() {
    return {
      "apartmentId": apartmentId,
      "prepaidId": prepaidId,
      "flatConsumption": flatConsumption.map((f) => f.toJson()).toList(),
    };
  }
}

class FlatConsumption {
  final int flatId;
  final String flatNo;
  final String unitsConsumed;

  FlatConsumption({
    required this.flatId,
    required this.flatNo,
    required this.unitsConsumed,
  });

  Map<String, dynamic> toJson() {
    return {
      "flatId": flatId,
      "flatNo": flatNo,
      "unitsConsumed": unitsConsumed,
    };
  }
}
