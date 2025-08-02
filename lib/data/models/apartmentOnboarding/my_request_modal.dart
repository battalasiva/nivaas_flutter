class MyRequestModal {
  int? id;
  String? flatNo;
  String? accessType;
  bool? approved;
  String? appliedOn;
  String? approvedOn;
  String? apartmentName;
  String? adminContact;
  String? adminName;
  int? onboardingId;
  int? apartmentId;

  MyRequestModal(
      {this.id,
      this.flatNo,
      this.accessType,
      this.approved,
      this.appliedOn,
      this.approvedOn,
      this.apartmentName,
      this.adminContact,
      this.adminName,
      this.onboardingId,
      this.apartmentId});

  MyRequestModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    flatNo = json['flatNo'];
    accessType = json['accessType'];
    approved = json['approved'];
    appliedOn = json['appliedOn'];
    approvedOn = json['approvedOn'];
    apartmentName = json['apartmentName'];
    adminContact = json['adminContact'];
    adminName = json['adminName'];
    onboardingId = json['onboardingId'];
    apartmentId = json['apartmentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['flatNo'] = this.flatNo;
    data['accessType'] = this.accessType;
    data['approved'] = this.approved;
    data['appliedOn'] = this.appliedOn;
    data['approvedOn'] = this.approvedOn;
    data['apartmentName'] = this.apartmentName;
    data['adminContact'] = this.adminContact;
    data['adminName'] = this.adminName;
    data['onboardingId'] = this.onboardingId;
    data['apartmentId'] = this.apartmentId;
    return data;
  }
}
