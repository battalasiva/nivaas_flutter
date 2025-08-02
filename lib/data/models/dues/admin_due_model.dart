class AdminDuesModal {
  int? id;
  int? flatId;
  double? cost;
  String? status;
  String? flatNo;

  AdminDuesModal({this.id, this.flatId, this.cost, this.status, this.flatNo});

  AdminDuesModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    flatId = json['flatId'];
    cost = json['cost'];
    status = json['status'];
    flatNo = json['flatNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['flatId'] = this.flatId;
    data['cost'] = this.cost;
    data['status'] = this.status;
    data['flatNo'] = this.flatNo;
    return data;
  }
}
