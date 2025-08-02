class ApproveDeclineGuestModel {
  List<Content>? content;
  Pageable? pageable;
  int? totalElements;
  int? totalPages;
  bool? last;
  int? size;
  int? number;
  List<Null>? sort;
  int? numberOfElements;
  bool? first;
  bool? empty;

  ApproveDeclineGuestModel(
      {this.content,
      this.pageable,
      this.totalElements,
      this.totalPages,
      this.last,
      this.size,
      this.number,
      this.sort,
      this.numberOfElements,
      this.first,
      this.empty});

  ApproveDeclineGuestModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(new Content.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    last = json['last'];
    size = json['size'];
    number = json['number'];
    if (json['sort'] != null) {
      sort = <Null>[];
      json['sort'].forEach((v) {
        // sort!.add(new Null.fromJson(v));
      });
    }
    numberOfElements = json['numberOfElements'];
    first = json['first'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    data['totalElements'] = this.totalElements;
    data['totalPages'] = this.totalPages;
    data['last'] = this.last;
    data['size'] = this.size;
    data['number'] = this.number;
    if (this.sort != null) {
      // data['sort'] = this.sort!.map((v) => v.toJson()).toList();
    }
    data['numberOfElements'] = this.numberOfElements;
    data['first'] = this.first;
    data['empty'] = this.empty;
    return data;
  }
}

class Content {
  int? visitorRequestId;
  String? visitorStatus;
  String? visitorType;
  String? visitorAccessType;
  String? fromDate;
  Null? toDate;
  String? startTime;
  int? hours;
  Null? approvedBy;
  CreatedBy? createdBy;
  String? flatNo;
  List<Visitors>? visitors;

  Content(
      {this.visitorRequestId,
      this.visitorStatus,
      this.visitorType,
      this.visitorAccessType,
      this.fromDate,
      this.toDate,
      this.startTime,
      this.hours,
      this.approvedBy,
      this.createdBy,
      this.flatNo,
      this.visitors});

  Content.fromJson(Map<String, dynamic> json) {
    visitorRequestId = json['visitorRequestId'];
    visitorStatus = json['visitorStatus'];
    visitorType = json['visitorType'];
    visitorAccessType = json['visitorAccessType'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    startTime = json['startTime'];
    hours = json['hours'];
    approvedBy = json['approvedBy'];
    createdBy = json['createdBy'] != null
        ? new CreatedBy.fromJson(json['createdBy'])
        : null;
    flatNo = json['flatNo'];
    if (json['visitors'] != null) {
      visitors = <Visitors>[];
      json['visitors'].forEach((v) {
        visitors!.add(new Visitors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['visitorRequestId'] = this.visitorRequestId;
    data['visitorStatus'] = this.visitorStatus;
    data['visitorType'] = this.visitorType;
    data['visitorAccessType'] = this.visitorAccessType;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['startTime'] = this.startTime;
    data['hours'] = this.hours;
    data['approvedBy'] = this.approvedBy;
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy!.toJson();
    }
    data['flatNo'] = this.flatNo;
    if (this.visitors != null) {
      data['visitors'] = this.visitors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreatedBy {
  int? id;
  String? name;
  bool? newUser;

  CreatedBy({this.id, this.name, this.newUser});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    newUser = json['newUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['newUser'] = this.newUser;
    return data;
  }
}

class Visitors {
  int? id;
  String? contactNumber;
  String? name;

  Visitors({this.id, this.contactNumber, this.name});

  Visitors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contactNumber = json['contactNumber'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contactNumber'] = this.contactNumber;
    data['name'] = this.name;
    return data;
  }
}

class Pageable {
  List<Null>? sort;
  int? offset;
  int? pageNumber;
  int? pageSize;
  bool? paged;
  bool? unpaged;

  Pageable(
      {this.sort,
      this.offset,
      this.pageNumber,
      this.pageSize,
      this.paged,
      this.unpaged});

  Pageable.fromJson(Map<String, dynamic> json) {
    if (json['sort'] != null) {
      sort = <Null>[];
      json['sort'].forEach((v) {
        // sort!.add(new Null.fromJson(v));
      });
    }
    offset = json['offset'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    paged = json['paged'];
    unpaged = json['unpaged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sort != null) {
      // data['sort'] = this.sort!.map((v) => v.toJson()).toList();
    }
    data['offset'] = this.offset;
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['paged'] = this.paged;
    data['unpaged'] = this.unpaged;
    return data;
  }
}
