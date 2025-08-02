class MyComplaintsModel {
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

  MyComplaintsModel(
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

  MyComplaintsModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? title;
  String? description;
  String? createdDt;
  int? createdBy;
  String? status;
  Null? complaintType;
  int? assignedTo;
  String? assignedOn;

  Content(
      {this.id,
      this.title,
      this.description,
      this.createdDt,
      this.createdBy,
      this.status,
      this.complaintType,
      this.assignedTo,
      this.assignedOn});

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    createdDt = json['createdDt'];
    createdBy = json['createdBy'];
    status = json['status'];
    complaintType = json['complaintType'];
    assignedTo = json['assignedTo'];
    assignedOn = json['assignedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['createdDt'] = this.createdDt;
    data['createdBy'] = this.createdBy;
    data['status'] = this.status;
    data['complaintType'] = this.complaintType;
    data['assignedTo'] = this.assignedTo;
    data['assignedOn'] = this.assignedOn;
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
