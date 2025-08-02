class GetNotificationsModal {
  int? totalItems;
  List<Data>? data;
  int? pageNo;
  int? totalPages;
  int? pageSize;
  int? currentPage;

  GetNotificationsModal(
      {this.totalItems,
      this.data,
      this.pageNo,
      this.totalPages,
      this.pageSize,
      this.currentPage});

  GetNotificationsModal.fromJson(Map<String, dynamic> json) {
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
  String? creationTime;
  String? message;
  String? type;
  int? userId;

  Data({this.id, this.creationTime, this.message, this.type, this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creationTime = json['creationTime'];
    message = json['message'];
    type = json['type'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['creationTime'] = this.creationTime;
    data['message'] = this.message;
    data['type'] = this.type;
    data['userId'] = this.userId;
    return data;
  }
}
