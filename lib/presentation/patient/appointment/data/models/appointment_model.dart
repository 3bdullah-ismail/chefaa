import 'package:chefaa/presentation/patient/appointment/data/models/appointment_nested_models.dart';

class AppointmentModel {
  final String? id;
  final AppointmentPatientModel? patient;
  final AppointmentDoctorModel? doctor;
  final AppointmentClinicModel? clinic;
  final dynamic prescription;
  final String? date;
  final String? timeChosed;
  final String? slotStart;
  final String? slotEnd;
  final bool? isFollowUp;
  final String? paymentStatus;
  final String? paymentOption;
  final String? status;
  final dynamic paidAt;
  final String? createdAt;
  final String? updatedAt;
  final num? v;

  const AppointmentModel({
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

  factory AppointmentModel.fromJson(dynamic json) {
    final patientJson = json['patient'];
    AppointmentPatientModel? patient;
    if (patientJson is Map<String, dynamic>) {
      patient = AppointmentPatientModel.fromJson(patientJson);
    }

    final doctorJson = json['doctor'];
    AppointmentDoctorModel? doctor;
    if (doctorJson is Map<String, dynamic>) {
      doctor = AppointmentDoctorModel.fromJson(doctorJson);
    }

    final clinicJson = json['clinic'];
    AppointmentClinicModel? clinic;
    if (clinicJson is Map<String, dynamic>) {
      clinic = AppointmentClinicModel.fromJson(clinicJson);
    }

    return AppointmentModel(
      id: json['_id'],
      patient: patient,
      doctor: doctor,
      clinic: clinic,
      prescription: json['prescription'],
      date: json['date'],
      timeChosed: json['timeChosed'],
      slotStart: json['slotStart'],
      slotEnd: json['slotEnd'],
      isFollowUp: json['isFollowUp'],
      paymentStatus: json['paymentStatus'],
      paymentOption: json['paymentOption'],
      status: json['status'],
      paidAt: json['paidAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'patient': patient?.toJson(),
      'doctor': doctor?.toJson(),
      'clinic': clinic?.toJson(),
      'prescription': prescription,
      'date': date,
      'timeChosed': timeChosed,
      'slotStart': slotStart,
      'slotEnd': slotEnd,
      'isFollowUp': isFollowUp,
      'paymentStatus': paymentStatus,
      'paymentOption': paymentOption,
      'status': status,
      'paidAt': paidAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}
