class Appointment {

  Appointment({
      this.patient, 
      this.doctor, 
      this.clinic, 
      this.prescription, 
      this.date, 
      this.timeChosed, 
      this.slotStart, 
      this.slotEnd, 
      this.isFollowUp, 
      this.paymentStatus, 
      this.paymentOption, 
      this.status, 
      this.paidAt, 
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Appointment.fromJson(dynamic json) {
    patient = json['patient'];
    doctor = json['doctor'];
    clinic = json['clinic'];
    prescription = json['prescription'];
    date = json['date'];
    timeChosed = json['timeChosed'];
    slotStart = json['slotStart'];
    slotEnd = json['slotEnd'];
    isFollowUp = json['isFollowUp'];
    paymentStatus = json['paymentStatus'];
    paymentOption = json['paymentOption'];
    status = json['status'];
    paidAt = json['paidAt'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? patient;
  String? doctor;
  String? clinic;
  dynamic prescription;
  String? date;
  String? timeChosed;
  String? slotStart;
  String? slotEnd;
  bool? isFollowUp;
  String? paymentStatus;
  String? paymentOption;
  String? status;
  dynamic paidAt;
  String? id;
  String? createdAt;
  String? updatedAt;
  num? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patient'] = patient;
    map['doctor'] = doctor;
    map['clinic'] = clinic;
    map['prescription'] = prescription;
    map['date'] = date;
    map['timeChosed'] = timeChosed;
    map['slotStart'] = slotStart;
    map['slotEnd'] = slotEnd;
    map['isFollowUp'] = isFollowUp;
    map['paymentStatus'] = paymentStatus;
    map['paymentOption'] = paymentOption;
    map['status'] = status;
    map['paidAt'] = paidAt;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}