class OnboardingFlatWithdetailsModel {
  final int apartmentId;
  final List<OnboardFlatDetails> flats;

  OnboardingFlatWithdetailsModel({required this.apartmentId, required this.flats});
  factory OnboardingFlatWithdetailsModel.fromJson(Map<String, dynamic> json) {
    return OnboardingFlatWithdetailsModel(
      apartmentId: json['apartmentId'],
      flats: (json['flats'] as List)
          .map((flat) => OnboardFlatDetails.fromJson(flat))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'apartmentId': apartmentId,
      'flats': flats.map((flat) => flat.toJson()).toList(),
    };
  }
}

class OnboardFlatDetails {
  final String flatNo;
  final String ownerPhoneNo;
  final String ownerName;

  OnboardFlatDetails({required this.flatNo, required this.ownerPhoneNo, required this.ownerName});

  factory OnboardFlatDetails.fromJson(Map<String, dynamic> json) {
    return OnboardFlatDetails(
      flatNo: json['flatNo'],
      ownerPhoneNo: json['ownerPhoneNo'],
      ownerName: json['ownerName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flatNo': flatNo,
      'ownerPhoneNo': ownerPhoneNo,
      'ownerName': ownerName,
    };
  }
}