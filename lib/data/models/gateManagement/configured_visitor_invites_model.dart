class ConfiguredVisitorInvitesModel {
  final List<VisitorRequest> content;
  final Pageable pageable;
  final int totalElements;
  final int totalPages;
  final bool last;
  final int size;
  final int number;
  final int numberOfElements;
  final bool first;
  final bool empty;

  ConfiguredVisitorInvitesModel({
    required this.content,
    required this.pageable,
    required this.totalElements,
    required this.totalPages,
    required this.last,
    required this.size,
    required this.number,
    required this.numberOfElements,
    required this.first,
    required this.empty,
  });

  factory ConfiguredVisitorInvitesModel.fromJson(Map<String, dynamic> json) {
    return ConfiguredVisitorInvitesModel(
      content: (json['content'] as List)
          .map((e) => VisitorRequest.fromJson(e))
          .toList(),
      pageable: Pageable.fromJson(json['pageable']),
      totalElements: json['totalElements'],
      totalPages: json['totalPages'],
      last: json['last'],
      size: json['size'],
      number: json['number'],
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
      'numberOfElements': numberOfElements,
      'first': first,
      'empty': empty,
    };
  }
}

class VisitorRequest {
  final int visitorRequestId;
  final String visitorStatus;
  final String visitorType;
  final String visitorAccessType;
  final String fromDate;
  final String? toDate;
  final String? startTime;
  final int hours;
  final ApprovedBy approvedBy;
  final CreatedBy createdBy;
  final String flatNo;
  final String otp;
  final List<Visitor> visitors;

  VisitorRequest({
    required this.visitorRequestId,
    required this.visitorStatus,
    required this.visitorType,
    required this.visitorAccessType,
    required this.fromDate,
    this.toDate,
    this.startTime,
    required this.hours,
    required this.approvedBy,
    required this.createdBy,
    required this.flatNo,
    required this.otp,
    required this.visitors,
  });

  factory VisitorRequest.fromJson(Map<String, dynamic> json) {
    return VisitorRequest(
      visitorRequestId: json['visitorRequestId'],
      visitorStatus: json['visitorStatus'],
      visitorType: json['visitorType'],
      visitorAccessType: json['visitorAccessType'],
      fromDate: json['fromDate'] ?? '',
      toDate: json['toDate'] ?? '',
      startTime: json['startTime'],
      hours: json['hours'],
      approvedBy: json['approvedBy'] != null 
        ? ApprovedBy.fromJson(json['approvedBy']) 
        : ApprovedBy(id: 0, name: "N/A", newUser: false), 
      createdBy: json['createdBy'] != null 
        ? CreatedBy.fromJson(json['createdBy']) 
        : CreatedBy(id: 0, name: "N/A", newUser: false), 
      flatNo: json['flatNo'],
      otp: json['otp'],
      visitors: (json['visitors'] as List)
          .map((e) => Visitor.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visitorRequestId': visitorRequestId,
      'visitorStatus': visitorStatus,
      'visitorType': visitorType,
      'visitorAccessType': visitorAccessType,
      'fromDate': fromDate,
      'toDate': toDate,
      'startTime': startTime,
      'hours': hours,
      'approvedBy': approvedBy.toJson(),
      'flatNo': flatNo,
      'otp': otp,
      'visitors': visitors.map((e) => e.toJson()).toList(),
    };
  }
}

class ApprovedBy {
  final int id;
  final String name;
  final bool newUser;

  ApprovedBy({
    required this.id,
    required this.name,
    required this.newUser,
  });

  factory ApprovedBy.fromJson(Map<String, dynamic> json) {
    return ApprovedBy(
      id: json['id'],
      name: json['name'],
      newUser: json['newUser'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'newUser': newUser,
    };
  }
}

class CreatedBy {
  final int id;
  final String name;
  final bool newUser;

  CreatedBy({
    required this.id,
    required this.name,
    required this.newUser,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['id'],
      name: json['name'],
      newUser: json['newUser'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'newUser': newUser,
    };
  }
}

class Visitor {
  final int id;
  final String contactNumber;
  final String name;

  Visitor({
    required this.id,
    required this.contactNumber,
    required this.name,
  });

  factory Visitor.fromJson(Map<String, dynamic> json) {
    return Visitor(
      id: json['id'],
      contactNumber: json['contactNumber'],
      name: json['name'],
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
  final List<dynamic> sort;
  final int offset;
  final int pageNumber;
  final int pageSize;
  final bool paged;
  final bool unpaged;

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
      sort: List<dynamic>.from(json['sort'] ?? []),
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
