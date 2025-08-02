class AdminsListModal {
  int? id;
  String? fullName;
  List<Roles>? roles;
  String? primaryContact;
  String? creationTime;
  int? version;
  String? fcmToken;

  AdminsListModal(
      {this.id,
      this.fullName,
      this.roles,
      this.primaryContact,
      this.creationTime,
      this.version,
      this.fcmToken});

  AdminsListModal.fromJson(Map<String, dynamic> json) {
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
