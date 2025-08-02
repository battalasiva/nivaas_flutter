class FlatmembersDetailsModel {
  final String flatNo;
  final String ownerPhoneNo;
  final String ownerName;

  FlatmembersDetailsModel({required this.flatNo, required this.ownerPhoneNo, required this.ownerName});

  factory FlatmembersDetailsModel.fromJson(Map<String, dynamic> json){
    return FlatmembersDetailsModel(
      flatNo: json['flatNo'], 
      ownerPhoneNo: json['ownerPhoneNo'], 
      ownerName: json['ownerName']
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'flatNo' : flatNo,
      'ownerPhoneNo' : ownerPhoneNo,
      'ownerName' : ownerName
    };
  }

  @override
  String toString() {
    return 'FlatmembersDetailsModel(flatNo: $flatNo, ownerPhoneNo: $ownerPhoneNo, ownerName: $ownerName)';
  }
}