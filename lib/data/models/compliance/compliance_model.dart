class ComplianceModel {
  List<String> dos;
  List<String> donts;

  ComplianceModel({required this.dos, required this.donts});

  factory ComplianceModel.fromJson(Map<String, dynamic> json) {
    return ComplianceModel(
      dos: List<String>.from(json['dos'] ?? []),
      donts: List<String>.from(json['donts'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dos': dos,
      'donts': donts,
    };
  }
}
