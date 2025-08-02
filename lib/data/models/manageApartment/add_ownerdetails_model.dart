class AddOwnerdetailsModel {
  final int flatId;
  final String ownerPhoneNo;
  final String ownerName;

  AddOwnerdetailsModel({required this.flatId, required this.ownerPhoneNo, required this.ownerName});

  factory AddOwnerdetailsModel.fromJson(Map<String, dynamic> json) {
    return AddOwnerdetailsModel(
      flatId: json['flatId'],
      ownerPhoneNo: json['ownerPhoneNo'],
      ownerName: json['ownerName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flatId': flatId,
      'ownerPhoneNo': ownerPhoneNo,
      'ownerName': ownerName,
    };
  }
}