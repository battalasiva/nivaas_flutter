class NoticeBoardModal {
  int? totalItems;
  List<Data>? data;
  int? pageNo;
  int? totalPages;
  int? pageSize;
  int? currentPage;

  NoticeBoardModal(
      {this.totalItems,
      this.data,
      this.pageNo,
      this.totalPages,
      this.pageSize,
      this.currentPage});

  NoticeBoardModal.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    pageNo = json['pageNo'];
    totalPages = json['totalPages'];
    pageSize = json['pageSize'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['pageNo'] = this.pageNo;
    data['totalPages'] = this.totalPages;
    data['pageSize'] = this.pageSize;
    data['currentPage'] = this.currentPage;
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? body;
  String? publishTime;
  int? apartmentId;
  String? postedBy;
  String? apartmentName;

  Data(
      {this.id,
      this.title,
      this.body,
      this.publishTime,
      this.apartmentId,
      this.postedBy,
      this.apartmentName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    publishTime = json['publishTime'];
    apartmentId = json['apartmentId'];
    postedBy = json['postedBy'];
    apartmentName = json['apartmentName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['publishTime'] = this.publishTime;
    data['apartmentId'] = this.apartmentId;
    data['postedBy'] = this.postedBy;
    data['apartmentName'] = this.apartmentName;
    return data;
  }
}
