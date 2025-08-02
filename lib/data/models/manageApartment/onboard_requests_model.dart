class OwnerOnboardRequestModel{
  final int id;
  final String type;

  OwnerOnboardRequestModel({required this.id, required this.type});

  factory OwnerOnboardRequestModel.fromJson(Map<String, dynamic> json){
    return OwnerOnboardRequestModel(
      id: json['id'], 
      type: json['type']
    );
  }
  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'type': type
    };
  }
}

class TenantOnboardRequestModel {
  final int id;
  final String relatedType;
  final int relatedRequestId;

  TenantOnboardRequestModel({required this.id, required this.relatedType, required this.relatedRequestId});

  factory TenantOnboardRequestModel.fromJson(Map<String, dynamic> json){
    return TenantOnboardRequestModel(
      id: json['id'], 
      relatedType: json['relatedType'],
      relatedRequestId: json['relatedRequestId']
    );
  }
  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'relatedType': relatedType,
      'relatedRequestId': relatedRequestId
    };
  }
}

class RejectOnboardRequestModel {
  
}