class FlatDetailsModel {
  final int? id;
  final String? flatNo;
  final String facing;
  final int totalRooms;
  final double squareFeet;
  final int floorNo;
  final int? ownerId;
  final int? tenantId;
  final bool? approved;
  final double? rentAmount;
  final double? depositAmount;
  final String? availableFrom;
  final bool? furniture;
  final bool? availableForRent;
  final bool? availableForSale;
  final bool? parkingAvailable;

  FlatDetailsModel({
     this.id,
     this.flatNo,
    required this.facing,
    required this.totalRooms,
    required this.squareFeet,
    required this.floorNo,
     this.ownerId,
    this.tenantId,
     this.approved,
     this.rentAmount,
     this.depositAmount,
     this.availableFrom,
     this.furniture,
     this.availableForRent,
     this.availableForSale,
     this.parkingAvailable,
  });

  factory FlatDetailsModel.fromJson(Map<String, dynamic> json) {
    return FlatDetailsModel(
      id: json['id'],
      flatNo: json['flatNo'],
      facing: json['facing'] ?? '',
      totalRooms: json['totalRooms'] ?? 0,
      squareFeet: json['squareFeet'] ?? 0.0,
      floorNo: json['floorNo'] ?? 0,
      ownerId: json['ownerId'],
      tenantId: json['tenantId'],
      approved: json['approved'],
      rentAmount: json['rentAmount'],
      depositAmount: json['depositAmount'],
      availableFrom: json['availableFrom'],
      furniture: json['furniture'],
      availableForRent: json['availableForRent'],
      availableForSale: json['availableForSale'],
      parkingAvailable: json['parkingAvailable'],
    );
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'facing': facing,
      'floorNo': floorNo,
      'noOfRooms': totalRooms.toString(),
      'parkingAvailable': parkingAvailable != null
        ? (parkingAvailable! ? 'true' : 'false')
        : 'false',
      'sqFeet': squareFeet.toString(),
      'availableForRent': availableForRent,
      'availableForSale': availableForSale,
      'rentAmount': rentAmount,
      'depositAmount': depositAmount,
      'availableFrom': availableFrom,
      'furniture': furniture
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'flatNo': flatNo,
      'facing': facing,
      'totalRooms': totalRooms,
      'squareFeet': squareFeet,
      'floorNo': floorNo,
      'ownerId': ownerId,
      'tenantId': tenantId,
      'approved': approved,
      'rentAmount': rentAmount,
      'depositAmount': depositAmount,
      'availableForRent': availableForRent,
      'availableForSale': availableForSale,
      'parkingAvailable': parkingAvailable,
      'availableFrom': availableFrom,
      'furniture' : furniture
    };
  }
}
