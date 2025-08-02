class FlatsWithoutDetailsModel {
  final int totalItems;
  final List<Data> data;
  final int pageNo;
  final int totalPages;
  final int pageSize;
  final int currentPage;

  FlatsWithoutDetailsModel({
    required this.totalItems,
    required this.data,
    required this.pageNo,
    required this.totalPages,
    required this.pageSize,
    required this.currentPage,
  });

  factory FlatsWithoutDetailsModel.fromJson(Map<String, dynamic> json) {
    return FlatsWithoutDetailsModel(
      totalItems: json['totalItems'] ?? 0,
      data: (json['data'] as List?)?.map((item) => Data.fromJson(item)).toList() ?? [],
      pageNo: json['pageNo'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      currentPage: json['currentPage'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalItems': totalItems,
      'data': data.map((item) => item.toJson()).toList(),
      'pageNo': pageNo,
      'totalPages': totalPages,
      'pageSize': pageSize,
      'currentPage': currentPage,
    };
  }
}

class Data {
  final int id;
  final String flatNo;

  Data({required this.id, required this.flatNo});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      flatNo: json['flatNo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'flatNo': flatNo
    };
  }
}