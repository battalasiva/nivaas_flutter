class GetServicePartnersListModel {
  int? id;
  PartnerResponse? partnerResponse;
  bool? isDefaultPartner;
  int? categoryId;

  GetServicePartnersListModel(
      {this.id, this.partnerResponse, this.isDefaultPartner, this.categoryId});

  GetServicePartnersListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partnerResponse = json['partnerResponse'] != null
        ? PartnerResponse.fromJson(json['partnerResponse'])
        : null;
    isDefaultPartner = json['isDefaultPartner'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (partnerResponse != null) {
      data['partnerResponse'] = partnerResponse!.toJson();
    }
    data['isDefaultPartner'] = isDefaultPartner;
    data['categoryId'] = categoryId;
    return data;
  }
}

class PartnerResponse {
  int? id;
  String? primaryContact;
  String? status;
  bool? newPartner;
  String? name;

  PartnerResponse({this.id, this.primaryContact, this.status, this.newPartner});

  PartnerResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    primaryContact = json['primaryContact'];
    status = json['status'];
    newPartner = json['newPartner'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['primaryContact'] = primaryContact;
    data['status'] = status;
    data['newPartner'] = newPartner;
    data['name'] = name;
    return data;
  }
}
