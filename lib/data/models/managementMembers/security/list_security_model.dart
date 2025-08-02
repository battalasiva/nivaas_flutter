class ListSecurityModel {
  final int apartmentId;
  final String apartmentName;
  final List<ApartmentHelper> apartmentHelpers;

  ListSecurityModel({
    required this.apartmentId,
    required this.apartmentName,
    required this.apartmentHelpers,
  });

  factory ListSecurityModel.fromJson(Map<String, dynamic> json) {
    var list = json['apartmentHelpers'] as List;
    List<ApartmentHelper> apartmentHelperList = list.map((i) => ApartmentHelper.fromJson(i)).toList();
    return ListSecurityModel(
      apartmentId: json['apartmentId'],
      apartmentName: json['apartmentName'],
      apartmentHelpers: apartmentHelperList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'apartmentId': apartmentId,
      'apartmentName': apartmentName,
      'apartmentHelpers': apartmentHelpers.map((helper) => helper.toJson()).toList(),
    };
  }
}

class ApartmentHelper {
  final int apartmentHelperId;
  final Helper helper;

  ApartmentHelper({required this.apartmentHelperId, required this.helper});

  factory ApartmentHelper.fromJson(Map<String, dynamic> json) {
    return ApartmentHelper(
      apartmentHelperId: json['apartmentHelperId'],
      helper: Helper.fromJson(json['helper']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'apartmentHelperId': apartmentHelperId,
      'helper': helper.toJson(),
    };
  }
}

class Helper {
  final int id;
  final String name, mobileNumber;
  final bool newUser;

  Helper({
    required this.id,
    required this.name,
    required this.mobileNumber,
    required this.newUser
  });

  factory Helper.fromJson(Map<String, dynamic> json) {
    return Helper(
      id: json['id'],
      name: json['name'],
      mobileNumber: json['mobileNumber'],
      newUser: json['newUser']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mobileNumber': mobileNumber,
      'name': name,
      'newUser': newUser
    };
  }
}
