class WalletTransactionModal {
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

  WalletTransactionModal(
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

  WalletTransactionModal.fromJson(Map<String, dynamic> json) {
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
  int? apartmentId;
  double? amount;
  String? transactionType;
  String? transactionDate;
  String? notes;
  double? balanceAfterTransaction;

  Content(
      {this.id,
      this.apartmentId,
      this.amount,
      this.transactionType,
      this.transactionDate,
      this.notes,
      this.balanceAfterTransaction});

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    apartmentId = json['apartmentId'];
    amount = json['amount'];
    transactionType = json['transactionType'];
    transactionDate = json['transactionDate'];
    notes = json['notes'];
    balanceAfterTransaction = json['balanceAfterTransaction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['apartmentId'] = this.apartmentId;
    data['amount'] = this.amount;
    data['transactionType'] = this.transactionType;
    data['transactionDate'] = this.transactionDate;
    data['notes'] = this.notes;
    data['balanceAfterTransaction'] = this.balanceAfterTransaction;
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
