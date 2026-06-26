class Pagination {
  Pagination({
      this.total, 
      this.page, 
      this.pages,});

  Pagination.fromJson(dynamic json) {
    total = json['total'];
    page = json['page'];
    pages = json['pages'];
  }
  num? total;
  num? page;
  num? pages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['page'] = page;
    map['pages'] = pages;
    return map;
  }

}