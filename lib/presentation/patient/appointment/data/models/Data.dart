import 'package:chefaa/presentation/patient/appointment/data/models/prescription_model.dart';

import 'Patient.dart';
import 'Doctor.dart';
import 'Clinic.dart';

class AppointmentModel {
  AppointmentModel({
    this.id,
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
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  AppointmentModel.fromJson(dynamic json) {
    id = json['_id'];

    patient = json['patient'] is Map
        ? Patient.fromJson(Map<String, dynamic>.from(json['patient']))
        : null;

    doctor = json['doctor'] is Map
        ? Doctor.fromJson(Map<String, dynamic>.from(json['doctor']))
        : null;

    clinic = json['clinic'] is Map
        ? Clinic.fromJson(Map<String, dynamic>.from(json['clinic']))
        : null;

    prescription = json['prescription'] is Map
        ? PrescriptionModel.fromJson(
            Map<String, dynamic>.from(json['prescription']),
          )
        : null;

    date = json['date'];
    timeChosed = json['timeChosed'];
    slotStart = json['slotStart'];
    slotEnd = json['slotEnd'];
    isFollowUp = json['isFollowUp'];
    paymentStatus = json['paymentStatus'];
    paymentOption = json['paymentOption'];
    status = json['status'];
    paidAt = json['paidAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  String? id;
  Patient? patient;
  Doctor? doctor;
  Clinic? clinic;
  PrescriptionModel? prescription;
  String? date;
  String? timeChosed;
  String? slotStart;
  String? slotEnd;
  bool? isFollowUp;
  String? paymentStatus;
  String? paymentOption;
  String? status;
  dynamic paidAt;
  String? createdAt;
  String? updatedAt;
  num? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (patient != null) {
      map['patient'] = patient?.toJson();
    }
    if (doctor != null) {
      map['doctor'] = doctor?.toJson();
    }
    if (clinic != null) {
      map['clinic'] = clinic?.toJson();
    }
    if (prescription != null) {
      map['prescription'] = prescription!.toJson();
    }
    map['date'] = date;
    map['timeChosed'] = timeChosed;
    map['slotStart'] = slotStart;
    map['slotEnd'] = slotEnd;
    map['isFollowUp'] = isFollowUp;
    map['paymentStatus'] = paymentStatus;
    map['paymentOption'] = paymentOption;
    map['status'] = status;
    map['paidAt'] = paidAt;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}
