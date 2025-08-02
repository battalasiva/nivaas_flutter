class AddCoAdminModel {
  final int apartmentId;
  final int userId;
  final String userRole;

  AddCoAdminModel({
    required this.apartmentId,
    required this.userId,
    this.userRole = 'ROLE_APARTMENT_ADMIN',
  });

  factory AddCoAdminModel.fromMap(Map<String, dynamic> map) {
    return AddCoAdminModel(
      apartmentId: map['apartmentId'],
      userId: map['userId'],
      userRole: map['userRole'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'apartmentId': apartmentId,
      'userId': userId,
      'userRole': userRole,
    };
  }

  @override
  String toString() {
    return 'AddCoAdminModel(apartmentId: $apartmentId, userId: $userId, userRole: $userRole)';
  }
}