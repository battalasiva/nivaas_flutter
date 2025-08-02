class CityModel {
  List<Content> content;

  CityModel({required this.content});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    var contentList = json['content'] as List;
    List<Content> content = contentList.map((e) => Content.fromJson(e)).toList();
    return CityModel(content: content);
  }
}

class Content {
  int id;
  String isoCode;
  String name;
  String country;
  String region;
  String district;
  DateTime creationTime;
  List<PostalCode> postalCodes;

  Content({
    required this.id,
    required this.isoCode,
    required this.name,
    required this.country,
    required this.region,
    required this.district,
    required this.creationTime,
    required this.postalCodes,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    var postalCodesList = json['postalCodes'] as List;
    List<PostalCode> postalCodes = postalCodesList
        .map((e) => PostalCode.fromJson(e))
        .toList();
    return Content(
      id: json['id'],
      isoCode: json['isoCode'],
      name: json['name'],
      country: json['country'],
      region: json['region'],
      district: json['district'],
      creationTime: DateTime.parse(json['creationTime']),
      postalCodes: postalCodes,
    );
  }
  @override
  String toString() {
    return 'Content(id: $id,name: $name, district: $district, region: $region)';
  }
}

class PostalCode {
  int id;
  String code;
  DateTime creationTime;
  int nivaasCityId;

  PostalCode({
    required this.id,
    required this.code,
    required this.creationTime,
    required this.nivaasCityId,
  });

  factory PostalCode.fromJson(Map<String, dynamic> json) {
    return PostalCode(
      id: json['id'],
      code: json['code'],
      creationTime: DateTime.parse(json['creationTime']),
      nivaasCityId: json['nivaasCityId'],
    );
  }
}
