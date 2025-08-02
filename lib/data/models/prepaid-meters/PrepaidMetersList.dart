class PrepaidMetersListModal {
  int? totalItems;
  List<Data>? data;
  int? pageNo;
  int? totalPages;
  int? pageSize;
  int? currentPage;

  PrepaidMetersListModal(
      {this.totalItems,
      this.data,
      this.pageNo,
      this.totalPages,
      this.pageSize,
      this.currentPage});

  PrepaidMetersListModal.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? meterType;
  double? costPerUnit;
  String? creationTime;
  List<ConfigRangeList>? configRangeList;

  Data(
      {this.id,
      this.name,
      this.meterType,
      this.costPerUnit,
      this.creationTime,
      this.configRangeList});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    meterType = json['meterType'];
    costPerUnit = json['costPerUnit'];
    creationTime = json['creationTime'];
    if (json['configRangeList'] != null) {
      configRangeList = <ConfigRangeList>[];
      json['configRangeList'].forEach((v) {
        configRangeList!.add(new ConfigRangeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['meterType'] = this.meterType;
    data['costPerUnit'] = this.costPerUnit;
    data['creationTime'] = this.creationTime;
    if (this.configRangeList != null) {
      data['configRangeList'] =
          this.configRangeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConfigRangeList {
  int? id;
  double? costPerUnit;
  double? startRange;
  double? endRange;

  ConfigRangeList({this.id, this.costPerUnit, this.startRange, this.endRange});

  ConfigRangeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    costPerUnit = json['costPerUnit'];
    startRange = json['startRange'];
    endRange = json['endRange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['costPerUnit'] = this.costPerUnit;
    data['startRange'] = this.startRange;
    data['endRange'] = this.endRange;
    return data;
  }
}
