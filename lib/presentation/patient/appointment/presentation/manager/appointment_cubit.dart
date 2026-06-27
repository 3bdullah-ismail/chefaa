import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/presentation/patient/appointment/data/repositories/appointment_repo.dart';
import 'package:chefaa/presentation/patient/appointment/presentation/manager/appointment_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/Data.dart';

@injectable
class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentRepo appointmentRepo;

  AppointmentCubit(this.appointmentRepo) : super(AppointmentInitialState());

  static AppointmentCubit get(BuildContext context) =>
      BlocProvider.of<AppointmentCubit>(context);

  List<AppointmentModel> appointments = [];

  Future<void> getMyAppointments({bool forceRefresh = false}) async {
    if (state is GetAppointmentsLoadingState) return;
    if (appointments.isNotEmpty && !forceRefresh) return;
    emit(GetAppointmentsLoadingState());

    try {
      appointments = await appointmentRepo.getMyAppointments();
      emit(GetAppointmentsSuccessState(appointments: appointments));
    } catch (e) {
      if (e is ServerFailure) {
        emit(GetAppointmentsErrorState(error: e.message));
      } else {
        emit(GetAppointmentsErrorState(error: ServerFailure.unexpectedError));
      }
    }
  }

  Future<void> rescheduleAppointment({
    required String appointmentId,
    required String date,
    required String slotStart,
    required String slotEnd,
    required String timeChosed,
  }) async {
    emit(RescheduleLoadingState());

    try {
      final updated = await appointmentRepo.rescheduleAppointment(
        appointmentId: appointmentId,
        date: date,
        slotStart: slotStart,
        slotEnd: slotEnd,
        timeChosed: timeChosed,
      );

      appointments = appointments.map((a) {
        if (a.id != appointmentId) return a;
        return AppointmentModel(
          id: a.id,
          patient: a.patient,
          doctor: a.doctor,
          clinic: a.clinic,
          prescription: updated.prescription,
          date: updated.date,
          timeChosed: updated.timeChosed,
          slotStart: updated.slotStart,
          slotEnd: updated.slotEnd,
          isFollowUp: updated.isFollowUp,
          paymentStatus: updated.paymentStatus,
          paymentOption: updated.paymentOption,
          status: updated.status,
          paidAt: updated.paidAt,
          createdAt: a.createdAt,
          updatedAt: updated.updatedAt,
          v: a.v,
        );
      }).toList();

      emit(RescheduleSuccessState(appointment: updated));
    } catch (e) {
      if (e is ServerFailure) {
        emit(RescheduleErrorState(error: e.message));
      } else {
        emit(RescheduleErrorState(error: ServerFailure.unexpectedError));
      }
    }
  }

  Future<void> cancelAppointment({required String appointmentId}) async {
    emit(CancelAppointmentLoadingState());

    try {
      final updated = await appointmentRepo.cancelAppointment(
        appointmentId: appointmentId,
      );

      appointments = appointments.map((a) {
        if (a.id != appointmentId) return a;
        return AppointmentModel(
          id: a.id,
          patient: a.patient,
          doctor: a.doctor,
          clinic: a.clinic,
          prescription: a.prescription,
          date: a.date,
          timeChosed: a.timeChosed,
          slotStart: a.slotStart,
          slotEnd: a.slotEnd,
          isFollowUp: a.isFollowUp,
          paymentStatus: updated.paymentStatus,
          paymentOption: a.paymentOption,
          status: updated.status,
          paidAt: a.paidAt,
          createdAt: a.createdAt,
          updatedAt: updated.updatedAt,
          v: a.v,
        );
      }).toList();

      emit(CancelAppointmentSuccessState(appointment: updated));
    } catch (e) {
      if (e is ServerFailure) {
        emit(CancelAppointmentErrorState(error: e.message));
      } else {
        emit(CancelAppointmentErrorState(error: ServerFailure.unexpectedError));
      }
    }
  }
}
