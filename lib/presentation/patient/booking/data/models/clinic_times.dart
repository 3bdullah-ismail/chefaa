import 'slots.dart';

class ClinicTimes {
  ClinicTimes({
    this.date,
    this.day,
    this.isPast,
    this.status,
    this.open,
    this.close,
    this.slotDuration,
    this.dailyCapacity,
    this.patientsPerSlot,
    this.totalBookedToday,
    this.totalSlots,
    this.hasAppointments,
    this.breaks,
    this.slots,
  });

  ClinicTimes.fromJson(dynamic json) {
    date = json['date'];
    day = json['day'];
    isPast = json['isPast'];
    status = json['status'];
    open = json['open'];
    close = json['close'];
    slotDuration = json['slotDuration'];
    dailyCapacity = json['dailyCapacity'];
    patientsPerSlot = json['patientsPerSlot'];
    totalBookedToday = json['totalBookedToday'];
    totalSlots = json['totalSlots'];
    hasAppointments = json['hasAppointments'];
    if (json['slots'] != null) {
      slots = [];
      json['slots'].forEach((v) {
        slots?.add(Slots.fromJson(v));
      });
    }
  }
  String? date;
  String? day;
  bool? isPast;
  String? status;
  num? open;
  num? close;
  num? slotDuration;
  num? dailyCapacity;
  num? patientsPerSlot;
  num? totalBookedToday;
  num? totalSlots;
  bool? hasAppointments;
  List<dynamic>? breaks;
  List<Slots>? slots;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['day'] = day;
    map['isPast'] = isPast;
    map['status'] = status;
    map['open'] = open;
    map['close'] = close;
    map['slotDuration'] = slotDuration;
    map['dailyCapacity'] = dailyCapacity;
    map['patientsPerSlot'] = patientsPerSlot;
    map['totalBookedToday'] = totalBookedToday;
    map['totalSlots'] = totalSlots;
    map['hasAppointments'] = hasAppointments;
    if (breaks != null) {
      map['breaks'] = breaks?.map((v) => v.toJson()).toList();
    }
    if (slots != null) {
      map['slots'] = slots?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
