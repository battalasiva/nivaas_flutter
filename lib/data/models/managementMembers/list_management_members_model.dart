class ListManagementMembersModel {
  final int apartmentId;
  final String apartmentName;
  final List<ApartmentHelper> apartmentHelpers;

  ListManagementMembersModel({
    required this.apartmentId,
    required this.apartmentName,
    required this.apartmentHelpers,
  });

  factory ListManagementMembersModel.fromJson(Map<String, dynamic> json) {
    return ListManagementMembersModel(
      apartmentId: json['apartmentId'],
      apartmentName: json['apartmentName'],
      apartmentHelpers: (json['apartmentHelpers'] as List)
          .map((e) => ApartmentHelper.fromJson(e))
          .toList(),
    );
  }
}

class ApartmentHelper {
  final int apartmentUserRelatedId;
  final UserDetails userDetails;
  final String role;

  ApartmentHelper({
    required this.apartmentUserRelatedId,
    required this.userDetails,
    required this.role,
  });

  factory ApartmentHelper.fromJson(Map<String, dynamic> json) {
    return ApartmentHelper(
      apartmentUserRelatedId: json['apartmentUserRelatedId'],
      userDetails: UserDetails.fromJson(json['userDetails']),
      role: json['role'],
    );
  }
}

class UserDetails {
  final int id;
  final String name;
  final bool newUser;
  final String mobileNumber;

  UserDetails({
    required this.id,
    required this.name,
    required this.newUser,
    required this.mobileNumber,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      name: json['name'],
      newUser: json['newUser'],
      mobileNumber: json['mobileNumber'].toString(),
    );
  }
}
