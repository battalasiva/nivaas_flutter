class Apartment {
  List<ApartmentContent> content;
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

  Apartment({
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

  factory Apartment.fromJson(Map<String, dynamic> json) {
    return Apartment(
      content: (json['content'] as List)
          .map((item) => ApartmentContent.fromJson(item))
          .toList(),
      pageable: Pageable.fromJson(json['pageable']),
      totalElements: json['totalElements'],
      totalPages: json['totalPages'],
      last: json['last'],
      size: json['size'],
      number: json['number'],
      sort: json['sort'] ?? [],
      numberOfElements: json['numberOfElements'],
      first: json['first'],
      empty: json['empty'],
    );
  }
}

class ApartmentContent {
  int id;
  String name;
  int cityId;

  ApartmentContent({
    required this.id,
    required this.name,
    required this.cityId,
  });

  factory ApartmentContent.fromJson(Map<String, dynamic> json) {
    return ApartmentContent(
      id: json['id'],
      name: json['name'],
      cityId: json['cityId'],
    );
  }

  @override
  String toString() {
    return 'ApartmentContent(name: $name, id: $id, cityId: $cityId)';
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
      sort: json['sort'] ?? [],
      offset: json['offset'],
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      paged: json['paged'],
      unpaged: json['unpaged'],
    );
  }
}
