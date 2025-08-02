class ApartmentOnboard {
  String name;
  String? code;
  String? description;
  int totalFlats;
  String? apartmentType;
  String? builderName;
  String line1;
  String? line2;
  String? line3;
  String postalCode;
  int cityId;

  ApartmentOnboard({
      required this.name,
       this.code,
       this.description,
      required this.totalFlats,
       this.apartmentType,
       this.builderName,
      required this.line1,
       this.line2,
       this.line3,
      required this.postalCode,
      required this.cityId,
  });

  factory ApartmentOnboard.fromJson(Map<String, dynamic> json) {
    return ApartmentOnboard(
      name: json['name'] , 
      code: json['code'],
      description: json['description'],
      totalFlats: json['totalFlats'],
      apartmentType: json['apartmentType'],
      builderName: json['builderName'],
      line1: json['line1'],
      line2: json['line2'],
      line3: json['line3'],
      postalCode: json['postalCode'],
      cityId: json['cityId'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'description': description,
      'totalFlats': totalFlats,
      'apartmentType': apartmentType,
      'builderName': builderName,
      'line1': line1,
      'line2': line2,
      'line3': line3,
      'postalCode': postalCode,
      'cityId': cityId,
    };
  }
}