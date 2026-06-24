class Slots {
  Slots({
      this.index, 
      this.start, 
      this.end, 
      this.startTime, 
      this.endTime, 
      this.available, 
      this.bookedCount, 
      this.patientsPerSlot, 
      this.remainingInSlot, 
      this.remainingInDay,});

  Slots.fromJson(dynamic json) {
    index = json['index'];
    start = json['start'];
    end = json['end'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    available = json['available'];
    bookedCount = json['bookedCount'];
    patientsPerSlot = json['patientsPerSlot'];
    remainingInSlot = json['remainingInSlot'];
    remainingInDay = json['remainingInDay'];
  }
  num? index;
  num? start;
  num? end;
  String? startTime;
  String? endTime;
  bool? available;
  num? bookedCount;
  num? patientsPerSlot;
  num? remainingInSlot;
  num? remainingInDay;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['index'] = index;
    map['start'] = start;
    map['end'] = end;
    map['startTime'] = startTime;
    map['endTime'] = endTime;
    map['available'] = available;
    map['bookedCount'] = bookedCount;
    map['patientsPerSlot'] = patientsPerSlot;
    map['remainingInSlot'] = remainingInSlot;
    map['remainingInDay'] = remainingInDay;
    return map;
  }

}