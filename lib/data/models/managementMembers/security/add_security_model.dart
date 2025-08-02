class AddSecurityModel {
  final int apartmentId;
  final List<Helper> helpers;

  AddSecurityModel({
    required this.apartmentId,
    required this.helpers,
  });

  factory AddSecurityModel.fromJson(Map<String, dynamic> json) {
    return AddSecurityModel(
      apartmentId: json['apartmentId'],
      helpers: (json['helpers'] as List)
          .map((helperJson) => Helper.fromJson(helperJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'apartmentId': apartmentId,
      'helpers': helpers.map((helper) => helper.toJson()).toList(),
    };
  }
}

class Helper {
  final String number;
  final String name;

  Helper({
    required this.number,
    required this.name,
  });

  factory Helper.fromJson(Map<String, dynamic> json) {
    return Helper(
      number: json['number'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
    };
  }
}
