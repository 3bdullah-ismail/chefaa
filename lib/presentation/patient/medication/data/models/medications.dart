import 'adherence_history.dart';

class Medications {
  Medications({
    this.id,
    this.name,
    this.dosage,
    this.form,
    this.timesPerDay,
    this.schedule,
    this.startDate,
    this.endDate,
    this.isActive,
    this.adherencePercentage,
    this.adherenceHistory,
  });

  Medications.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    dosage = json['dosage'];
    form = json['form'];
    timesPerDay = json['timesPerDay'];
    schedule = json['schedule'] != null ? json['schedule'].cast<String>() : [];
    startDate = json['startDate'];
    endDate = json['endDate'];
    isActive = json['isActive'];
    adherencePercentage = json['adherencePercentage'];
    if (json['adherenceHistory'] != null) {
      adherenceHistory = [];
      json['adherenceHistory'].forEach((v) {
        adherenceHistory?.add(AdherenceHistory.fromJson(v));
      });
    }
  }

  String? id;
  String? name;
  String? dosage;
  String? form;
  num? timesPerDay;
  List<String>? schedule;
  String? startDate;
  String? endDate;
  bool? isActive;
  num? adherencePercentage;
  List<AdherenceHistory>? adherenceHistory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['dosage'] = dosage;
    map['form'] = form;
    map['timesPerDay'] = timesPerDay;
    map['schedule'] = schedule;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['isActive'] = isActive;
    map['adherencePercentage'] = adherencePercentage;
    if (adherenceHistory != null) {
      map['adherenceHistory'] = adherenceHistory
          ?.map((v) => v.toJson())
          .toList();
    }
    return map;
  }

  Medications copyWith({
    String? id,
    String? name,
    String? dosage,
    String? form,
    num? timesPerDay,
    List<String>? schedule,
    String? startDate,
    String? endDate,
    bool? isActive,
    num? adherencePercentage,
    List<AdherenceHistory>? adherenceHistory,
  }) {
    return Medications(
      id: id ?? this.id,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      form: form ?? this.form,
      timesPerDay: timesPerDay ?? this.timesPerDay,
      schedule: schedule ?? this.schedule,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      adherencePercentage: adherencePercentage ?? this.adherencePercentage,
      adherenceHistory: adherenceHistory ?? this.adherenceHistory,
    );
  }
}
