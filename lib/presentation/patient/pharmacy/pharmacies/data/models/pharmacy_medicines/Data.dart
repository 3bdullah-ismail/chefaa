import 'medicines.dart';
import 'most_ordered.dart';
import 'pagination.dart';

class Data {
  Data({
      this.medicines, 
      this.mostOrdered, 
      this.pagination,});

  Data.fromJson(dynamic json) {
    if (json['medicines'] != null) {
      medicines = [];
      json['medicines'].forEach((v) {
        medicines?.add(Medicines.fromJson(v));
      });
    }
    if (json['mostOrdered'] != null) {
      mostOrdered = [];
      json['mostOrdered'].forEach((v) {
        mostOrdered?.add(MostOrdered.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  List<Medicines>? medicines;
  List<MostOrdered>? mostOrdered;
  Pagination? pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (medicines != null) {
      map['medicines'] = medicines?.map((v) => v.toJson()).toList();
    }
    if (mostOrdered != null) {
      map['mostOrdered'] = mostOrdered?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }

}
