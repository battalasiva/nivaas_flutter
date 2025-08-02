class OnboardingFlatWithoutdetailsModel {
  final int apartmentId;
  final List<OnboardFlat> flats;

  OnboardingFlatWithoutdetailsModel({required this.apartmentId, required this.flats});
  factory OnboardingFlatWithoutdetailsModel.fromJson(Map<String, dynamic> json) {
    return OnboardingFlatWithoutdetailsModel(
      apartmentId: json['apartmentId'],
      flats: (json['flats'] as List)
          .map((flat) => OnboardFlat.fromJson(flat))
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

class OnboardFlat {
  final String flatNo;

  OnboardFlat({required this.flatNo});
  factory OnboardFlat.fromJson(Map<String, dynamic> json) {
    return OnboardFlat(
      flatNo: json['flatNo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flatNo': flatNo
    };
  }
}