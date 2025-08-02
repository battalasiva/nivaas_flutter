
// class UserRole {
//   final String name;
//   final int id;

//   UserRole({required this.name, required this.id});

//   factory UserRole.fromJson(Map<String, dynamic> json) {
//     return UserRole(
//       name: json['name'],
//       id: json['id'],
//     );
//   }
// }

// class UserData {
//   final int id;
//   final String fullName;
//   final List<UserRole> roles;
//   final String primaryContact;
//   final String creationTime;
//   final int version;
//   final String fcmToken;
//   final String nivaasId;
//   final String? email;

//   UserData({
//     required this.id,
//     required this.fullName,
//     required this.roles,
//     required this.primaryContact,
//     required this.creationTime,
//     required this.version,
//     required this.fcmToken,
//     required this.nivaasId,
//     this.email,
//   });

//   factory UserData.fromJson(Map<String, dynamic> json) {
//     var roleList = json['roles'] as List;
//     List<UserRole> roles = roleList.map((roleJson) => UserRole.fromJson(roleJson)).toList();

//     return UserData(
//       id: json['id'],
//       fullName: json['fullName'],
//       roles: roles,
//       primaryContact: json['primaryContact'] != null 
//           ? json['primaryContact'].toString()
//           : 'N/A',
//       creationTime: json['creationTime'],
//       version: json['version'],
//       fcmToken: json['fcmToken'] ?? 'NA',
//       nivaasId: json['nivaasId'],
//       email: json['email'],
//     );
//   }
// }

// class OwnersListModel {
//   final int totalItems;
//   final List<UserData>? data;
//   final int pageNo;
//   final int totalPages;
//   final int pageSize;
//    int? currentPage;

//   OwnersListModel({
//     required this.totalItems,
//     required this.data,
//     required this.pageNo,
//     required this.totalPages,
//     required this.pageSize,
//      this.currentPage,
//   });

//   factory OwnersListModel.fromJson(Map<String, dynamic> json) {
//     var dataList = json['data'] as List;
//     List<UserData> data = dataList.map((dataJson) => UserData.fromJson(dataJson)).toList();

//     return OwnersListModel(
//       totalItems: json['totalItems'],
//       data: data,
//       pageNo: json['pageNo'],
//       totalPages: json['totalPages'],
//       pageSize: json['pageSize'],
//       currentPage: json['currentPage'],
//     );
//   }
// }

class FlatOwner {
  final int id;
  final String name;
  final bool newUser;
  final String mobileNumber;
  final String nivaasId;
  final List<String> roles;

  FlatOwner({
    required this.id,
    required this.name,
    required this.newUser,
    required this.mobileNumber,
    required this.nivaasId,
    required this.roles,
  });

  factory FlatOwner.fromMap(Map<String, dynamic> map) {
    return FlatOwner(
      id: map['id'],
      name: map['name'],
      newUser: map['newUser'],
      mobileNumber: map['mobileNumber'],
      nivaasId: map['nivaasId'],
      roles: List<String>.from(map['roles']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'newUser': newUser,
      'mobileNumber': mobileNumber,
      'nivaasId': nivaasId,
      'roles': roles,
    };
  }
}

class Flat {
  final int flatId;
  final String flatNumber;
  final FlatOwner owner;

  Flat({
    required this.flatId,
    required this.flatNumber,
    required this.owner,
  });

  factory Flat.fromMap(Map<String, dynamic> map) {
    return Flat(
      flatId: map['flatId'],
      flatNumber: map['flatNumber'],
      owner: FlatOwner.fromMap(map['owner']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'flatId': flatId,
      'flatNumber': flatNumber,
      'owner': owner.toMap(),
    };
  }
}

class Pageable {
  final int offset;
  final int pageNumber;
  final int pageSize;
  final bool unpaged;
  final bool paged;
  final List<dynamic> sort; 

  Pageable({
    required this.offset,
    required this.pageNumber,
    required this.pageSize,
    required this.unpaged,
    required this.paged,
    required this.sort,
  });

  factory Pageable.fromMap(Map<String, dynamic> map) {
    return Pageable(
      offset: map['offset'],
      pageNumber: map['pageNumber'],
      pageSize: map['pageSize'],
      unpaged: map['unpaged'],
      paged: map['paged'],
      sort: List<dynamic>.from(map['sort']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'offset': offset,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'unpaged': unpaged,
      'paged': paged,
      'sort': sort,
    };
  }
}

class OwnersListModel {
  final List<Flat> content;
  final Pageable pageable;
  final int totalElements;
  final int totalPages;
  final bool last;
  final int size;
  final int number;
  final int numberOfElements;
  final bool first;
  final bool empty;

  OwnersListModel({
    required this.content,
    required this.pageable,
    required this.totalElements,
    required this.totalPages,
    required this.last,
    required this.size,
    required this.number,
    required this.numberOfElements,
    required this.first,
    required this.empty,
  });

  factory OwnersListModel.fromJson(Map<String, dynamic> map) {
    return OwnersListModel(
      content: List<Flat>.from(map['content']?.map((dataJson) => Flat.fromMap(dataJson))),
      pageable: Pageable.fromMap(map['pageable']),
      totalElements: map['totalElements'],
      totalPages: map['totalPages'],
      last: map['last'],
      size: map['size'],
      number: map['number'],
      numberOfElements: map['numberOfElements'],
      first: map['first'],
      empty: map['empty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content.map((dataJson) => dataJson.toMap()).toList(),
      'pageable': pageable.toMap(),
      'totalElements': totalElements,
      'totalPages': totalPages,
      'last': last,
      'size': size,
      'number': number,
      'numberOfElements': numberOfElements,
      'first': first,
      'empty': empty,
    };
  }
}
