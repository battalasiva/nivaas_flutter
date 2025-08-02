class User {
  int id;
  String contactNumber;
  String name;

  User({
    required this.id,
    required this.contactNumber,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      contactNumber: json['contactNumber'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contactNumber': contactNumber,
      'name': name,
    };
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

class VisitorsHistoryModel {
  List<User> content;
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

  VisitorsHistoryModel({
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

  factory VisitorsHistoryModel.fromJson(Map<String, dynamic> json) {
    return VisitorsHistoryModel(
      content: (json['content'] as List)
          .map((e) => User.fromJson(e))
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

  Map<String, dynamic> toJson() {
    return {
      'content': content.map((e) => e.toJson()).toList(),
      'pageable': pageable.toJson(),
      'totalElements': totalElements,
      'totalPages': totalPages,
      'last': last,
      'size': size,
      'number': number,
      'sort': sort,
      'numberOfElements': numberOfElements,
      'first': first,
      'empty': empty,
    };
  }
}
