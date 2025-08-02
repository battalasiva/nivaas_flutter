class FlatListModel {
  List<FlatContent> content;
  Pageable pageable;
  int totalElements;
  int totalPages;
  bool last;
  int size;
  int number;
  List<dynamic> sort;
  int numberOfElements;
  bool first;
  bool empty;

  FlatListModel({
    required this.content,
    required this.pageable,
    required this.totalElements,
    required this.totalPages,
    required this.last,
    required this.size,
    required this.number,
    required this.sort,
    required this.numberOfElements,
    required this.first,
    required this.empty,
  });

  factory FlatListModel.fromJson(Map<String, dynamic> json) {
    return FlatListModel(
      content: (json['content'] as List)
          .map((item) => FlatContent.fromJson(item))
          .toList(),
      pageable: Pageable.fromJson(json['pageable']),
      totalElements: json['totalElements'],
      totalPages: json['totalPages'],
      last: json['last'],
      size: json['size'],
      number: json['number'],
      sort: json['sort'],
      numberOfElements: json['numberOfElements'],
      first: json['first'],
      empty: json['empty'],
    );
  }
}

class FlatContent {
  int id;
  String flatNo;
  String apartmentName;

  FlatContent({
    required this.id,
    required this.flatNo,
    required this.apartmentName,
  });

  factory FlatContent.fromJson(Map<String, dynamic> json) {
    return FlatContent(
      id: json['id'],
      flatNo: json['flatNo'],
      apartmentName: json['apartmentName'],
    );
  }

  @override
  String toString() {
    return 'Content(id: $id, flatNo: $flatNo, apartmentName: $apartmentName)';
  }
}

class Pageable {
  List<dynamic> sort;
  int offset;
  int pageNumber;
  int pageSize;
  bool paged;
  bool unpaged;

  Pageable({
    required this.sort,
    required this.offset,
    required this.pageNumber,
    required this.pageSize,
    required this.paged,
    required this.unpaged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) {
    return Pageable(
      sort: json['sort'],
      offset: json['offset'],
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      paged: json['paged'],
      unpaged: json['unpaged'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sort': sort,
      'offset': offset,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'paged': paged,
      'unpaged': unpaged,
    };
  }
}
