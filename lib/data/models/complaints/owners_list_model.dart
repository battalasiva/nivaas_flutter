class OwnersListModal {
  int? totalItems;
  List<Data>? data;
  int? pageNo;
  int? totalPages;
  int? pageSize;
  int? currentPage;

  OwnersListModal(
      {this.totalItems,
      this.data,
      this.pageNo,
      this.totalPages,
      this.pageSize,
      this.currentPage});

  OwnersListModal.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    pageNo = json['pageNo'];
    totalPages = json['totalPages'];
    pageSize = json['pageSize'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['pageNo'] = this.pageNo;
    data['totalPages'] = this.totalPages;
    data['pageSize'] = this.pageSize;
    data['currentPage'] = this.currentPage;
    return data;
  }
}

class Data {
  int? id;
  String? fullName;
  List<Roles>? roles;
  String? primaryContact;
  String? creationTime;
  int? version;
  String? fcmToken;
  String? email;

  Data(
      {this.id,
      this.fullName,
      this.roles,
      this.primaryContact,
      this.creationTime,
      this.version,
      this.fcmToken,
      this.email});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
    primaryContact = json['primaryContact'];
    creationTime = json['creationTime'];
    version = json['version'];
    fcmToken = json['fcmToken'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    data['primaryContact'] = this.primaryContact;
    data['creationTime'] = this.creationTime;
    data['version'] = this.version;
    data['fcmToken'] = this.fcmToken;
    data['email'] = this.email;
    return data;
  }
}

class Roles {
  String? name;
  int? id;

  Roles({this.name, this.id});

  Roles.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
