class CurrentCustomerModel {
  final User user;
  final CurrentFlat? currentFlat;
  final CurrentApartment? currentApartment;

  CurrentCustomerModel({
    required this.user,
    this.currentFlat,
    required this.currentApartment,
  });

  factory CurrentCustomerModel.fromJson(Map<String, dynamic> json) {
    return CurrentCustomerModel(
      user: User.fromJson(json['user']),
      currentFlat: json['currentFlat'] != null
          ? CurrentFlat.fromJson(json['currentFlat'])
          : null,
      currentApartment: json['currentApartment'] != null
          ? CurrentApartment.fromJson(json['currentApartment'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'currentFlat': currentFlat?.toJson(),
      'currentApartment': currentApartment?.toJson(),
    };
  }
}

class User {
  final int id;
  final String name;
  final bool? newUser;
  final String mobileNumber;
  final String? profilePicture;
  final String? email;
  final String nivaasId;
  final String? gender;
  final List<String> roles;

  User({
    required this.id,
    required this.name,
    this.newUser,
    required this.mobileNumber,
    this.profilePicture,
    this.email,
    required this.nivaasId,
    this.gender,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      newUser: json['newUser'],
      mobileNumber: json['mobileNumber'] ?? '',
      profilePicture: json['profilePicture'],
      email: json['email'],
      nivaasId: json['nivaasId'] ?? '',
      gender:json['gender'],
      roles: List<String>.from(json['roles'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'newUser': newUser,
      'mobileNumber': mobileNumber,
      'profilePicture': profilePicture,
      'email': email,
      'nivaasId' : nivaasId,
      'gender':gender,
      'roles': roles,
    };
  }
}

class CurrentFlat {
  final int id;
  final String flatNo;
  final String apartmentName;

  CurrentFlat({required this.id, required this.flatNo, required this.apartmentName});

  factory CurrentFlat.fromJson(Map<String, dynamic> json) {
    return CurrentFlat(
      id: json['id'],
      flatNo: json['flatNo'],
      apartmentName: json['apartmentName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'flatNo': flatNo,
      'apartmentName': apartmentName,
    };
  }
}

class CurrentApartment {
  final int id;
  final String apartmentName;
  final bool apartmentAdmin;
  final String subscriptionType;
  final String startDate;
  final String endDate;

  CurrentApartment({required this.id, required this.apartmentName, required this.apartmentAdmin,required this.subscriptionType,required this.startDate,required this.endDate});

  factory CurrentApartment.fromJson(Map<String, dynamic> json) {
    return CurrentApartment(
      id: json['id'],
      apartmentName: json['apartmentName'],
      apartmentAdmin: json['apartmentAdmin'],
      subscriptionType:json['subscriptionType'],
      startDate:json['startDate'],
      endDate:json['endDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'apartmentName': apartmentName,
      'apartmentAdmin': apartmentAdmin,
      'subscriptionType':subscriptionType,
      'startDate':startDate,
      'endDate':endDate,
    };
  }
}
