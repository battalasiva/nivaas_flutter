class LastAddedGenerateBillModal {
  MaintenanceData? maintenanceData;

  LastAddedGenerateBillModal({this.maintenanceData});

  LastAddedGenerateBillModal.fromJson(Map<String, dynamic> json) {
    maintenanceData = json['maintenanceData'] != null
        ? new MaintenanceData.fromJson(json['maintenanceData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.maintenanceData != null) {
      data['maintenanceData'] = this.maintenanceData!.toJson();
    }
    return data;
  }
}

class MaintenanceData {
  int? id;
  String? creationTime;
  int? notifyOn;
  double? cost;
  int? apartmentId;
  List<JtPrePaidMeterDTOs>? jtPrePaidMeterDTOs;

  MaintenanceData(
      {this.id,
      this.creationTime,
      this.notifyOn,
      this.cost,
      this.apartmentId,
      this.jtPrePaidMeterDTOs});

  MaintenanceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creationTime = json['creationTime'];
    notifyOn = json['notifyOn'];
    cost = json['cost'];
    apartmentId = json['apartmentId'];
    if (json['jtPrePaidMeterDTOs'] != null) {
      jtPrePaidMeterDTOs = <JtPrePaidMeterDTOs>[];
      json['jtPrePaidMeterDTOs'].forEach((v) {
        jtPrePaidMeterDTOs!.add(new JtPrePaidMeterDTOs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['creationTime'] = this.creationTime;
    data['notifyOn'] = this.notifyOn;
    data['cost'] = this.cost;
    data['apartmentId'] = this.apartmentId;
    if (this.jtPrePaidMeterDTOs != null) {
      data['jtPrePaidMeterDTOs'] =
          this.jtPrePaidMeterDTOs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JtPrePaidMeterDTOs {
  int? id;
  String? name;
  bool? isPrepaidMaintenance;

  JtPrePaidMeterDTOs({this.id, this.name, this.isPrepaidMaintenance});

  JtPrePaidMeterDTOs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isPrepaidMaintenance = json['isPrepaidMaintenance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isPrepaidMaintenance'] = this.isPrepaidMaintenance;
    return data;
  }
}
