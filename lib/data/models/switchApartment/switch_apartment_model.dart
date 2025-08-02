class ApartmentModel {
  final int apartmentId;
  final String apartmentName;
  final Map<int, String> flatmap;

  ApartmentModel({
    required this.apartmentId,
    required this.apartmentName,
    required this.flatmap,
  });

  factory ApartmentModel.fromJson(Map<String, dynamic> json) {
    return ApartmentModel(
      apartmentId: json['apartmentId'],
      apartmentName: json['apartmentName'],
      flatmap: (json['flatmap'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(int.parse(key), value as String)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'apartmentId': apartmentId,
      'apartmentName': apartmentName,
      'flatmap': flatmap.map((key, value) => MapEntry(key.toString(), value)),
    };
  }
  List<Flat> get flats {
    return flatmap.entries
        .map((entry) => Flat(flatId: entry.key, flatNo: entry.value))
        .toList();
  }
}

class Flat {
  final int flatId;
  final String flatNo;

  Flat({
    required this.flatId,
    required this.flatNo,
  });
}