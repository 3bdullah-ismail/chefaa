import 'appointment.dart';

class Booking {
  Booking({
      this.message, 
      this.appointment,});

  Booking.fromJson(dynamic json) {
    message = json['message'];
    appointment = json['appointment'] != null ? Appointment.fromJson(json['appointment']) : null;
  }
  String? message;
  Appointment? appointment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (appointment != null) {
      map['appointment'] = appointment?.toJson();
    }
    return map;
  }

}