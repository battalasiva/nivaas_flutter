class FlatsModel {
    int id;
    int flatId;
    String flatNo;
    String residentType;
    int userId;
    String name;
    String contactNumber;
    bool approved;
    int? relatedUserId;

    FlatsModel({
        required this.id,
        required this.flatId,
        required this.flatNo,
        required this.residentType,
        required this.userId,
        required this.name,
        required this.contactNumber,
        required this.approved,
        this.relatedUserId,
    });

    factory FlatsModel.fromJson(Map<String, dynamic> json) {
    return FlatsModel(
      id: json['id'] ,
    flatId: json['flatId'] ,
    flatNo: json['flatNo'] ,
    residentType: json['residentType'] ,
    userId: json['userId'] ,
    name: json['name'] ?? '', 
    contactNumber: json['contactNumber'], 
    approved: json['approved'],
    relatedUserId: json['relatedUserId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'flatId': flatId,
      'flatNo': flatNo,
      'residentType': residentType,
      'userId': userId,
      'name': name,
      'contactNumber': contactNumber,
      'approved': approved,
      'relatedUserId': relatedUserId,
    };
  }
}