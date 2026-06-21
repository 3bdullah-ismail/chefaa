import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/Clinic.dart';
import '../../data/repositories/clinic_repo.dart';
import 'clinic_state.dart';

@injectable
class ClinicCubit extends Cubit<ClinicState> {
  final ClinicRepo clinicRepo;

  ClinicCubit(this.clinicRepo) : super(ClinicInitialState());

  static ClinicCubit get(context) => BlocProvider.of(context);

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final priceController = TextEditingController();
  final operatingLicenseController = TextEditingController();

  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  final slotDurationController = TextEditingController();
  final dailyCapacityController = TextEditingController();
  final patientsPerSlotController = TextEditingController();

  String? doctorID;
  Clinic? currentClinic;

  String? activeDay;

  final Map<String, bool> selectedDays = {
    "Monday": false,
    "Tuesday": false,
    "Wednesday": false,
    "Thursday": false,
    "Friday": false,
    "Saturday": false,
    "Sunday": false,
  };

  final Map<String, TimeOfDay?> openTimes = {};
  final Map<String, TimeOfDay?> closeTimes = {};


  int _toMinutes(TimeOfDay t) => t.hour * 60 + t.minute;

  Map<String, dynamic> _buildLocation() {
    return {
      "type": "Point",
      "coordinates": [
        double.tryParse(longitudeController.text) ?? 0.0,
        double.tryParse(latitudeController.text) ?? 0.0,
      ],
    };
  }

  List<Map<String, dynamic>> _buildDays() {
    return selectedDays.entries
        .where((e) => e.value)
        .map((e) {
      final open = openTimes[e.key];
      final close = closeTimes[e.key];

      return {
        "day": e.key,
        "isActive": true,
        "open": open != null ? _toMinutes(open) : 0,
        "close": close != null ? _toMinutes(close) : 0,
      };
    })
        .toList();
  }

  Map<String, dynamic> _buildSchedule() {
    return {
      "days": _buildDays(),
      "slotDuration": int.tryParse(slotDurationController.text) ?? 30,
      "dailyCapacity": int.tryParse(dailyCapacityController.text) ?? 10,
      "patientsPerSlot": int.tryParse(patientsPerSlotController.text) ?? 1,
    };
  }


  void onDayTap(String day) {
    selectedDays[day] = !(selectedDays[day] ?? false);
    activeDay = selectedDays[day] == true ? day : null;
    emit(ClinicInitialState());
  }

  Future<void> pickTime({
    required BuildContext context,
    required String day,
    required bool isOpen,
  }) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      if (isOpen) {
        openTimes[day] = picked;
      } else {
        closeTimes[day] = picked;
      }
      emit(ClinicInitialState());
    }
  }

  Future<void> addClinic() async {
    emit(ClinicAddedLoadingState());

    try {
      await clinicRepo.addClinics(
        name: nameController.text.trim(),
        city: cityController.text.trim(),
        address: addressController.text.trim(),
        price: num.tryParse(priceController.text),
        operatingLicense: operatingLicenseController.text.trim(),
        location: _buildLocation(),
        schedule: _buildSchedule(),
      );

      emit(ClinicAddedSuccessState());
    } catch (e) {
      emit(ClinicAddedErrorState(message: e.toString()));
    }
  }


  Future<void> getClinicByID({required String clinicID}) async {
    emit(ClinicLoadingState());
    try {
      final response = await clinicRepo.getClinicByID(clinicID: clinicID);

      if (response.clinic == null) {
        emit(ClinicErrorState(message: "Clinic not found"));
        return;
      }

      emit(ClinicSuccessState(clinic: response.clinic!));
    } catch (e) {
      emit(ClinicErrorState(message: e.toString()));
    }
  }
  Future<void> updateClinic({required String clinicID}) async {
    emit(ClinicEditLoadingState());

    try {
      final response = await clinicRepo.updateClinics(
        clinicID: clinicID,
        name: nameController.text.trim(),
        city: cityController.text.trim(),
        address: addressController.text.trim(),
        price: num.tryParse(priceController.text),
        operatingLicense: operatingLicenseController.text.trim(),
        location: _buildLocation(),
        schedule: _buildSchedule(),
      );

      if (response.clinic == null) {
        emit(ClinicEditErrorState(message: "Update failed"));
        return;
      }

      emit(ClinicEditSuccessState(clinic: response.clinic!));
      emit(ClinicSuccessState(clinic: response.clinic!));
    } catch (e) {
      emit(ClinicEditErrorState(message: e.toString()));
    }
  }

  Future<void> deleteClinic({required String clinicID}) async {
    emit(ClinicDeleteLoadingState());

    try {
      await clinicRepo.deleteClinics(clinicID: clinicID);
      emit(ClinicDeleteSuccessState(clinicID: clinicID));
    } catch (e) {
      emit(ClinicDeleteErrorState(message: e.toString()));
    }
  }

  Future<void> getClinics({required String doctorID}) async {
    emit(ClinicsLoadingState());

    try {
      final clinics = await clinicRepo.getClinics(doctorID: doctorID);

      emit(ClinicsSuccessState(
        clinics: clinics.clinics ?? [],
      ));
    } catch (e) {
      emit(ClinicsErrorState(message: e.toString()));
    }
  }


  void fillFromClinic(Clinic clinic) {
    currentClinic = clinic;

    nameController.text = clinic.name ?? '';
    addressController.text = clinic.address ?? '';
    cityController.text = clinic.city ?? '';
    priceController.text = clinic.price?.toString() ?? '';
    operatingLicenseController.text = clinic.operatingLicense ?? '';

    final coords = clinic.location?.coordinates;
    if (coords != null && coords.length >= 2) {
      longitudeController.text = coords[0].toString();
      latitudeController.text = coords[1].toString();
    }

    final schedule = clinic.defaultSchedule;
    if (schedule != null) {
      slotDurationController.text = schedule.slotDuration?.toString() ?? '';
      dailyCapacityController.text = schedule.dailyCapacity?.toString() ?? '';
      patientsPerSlotController.text =
          schedule.patientsPerSlot?.toString() ?? '';

      resetDays();

      for (final d in schedule.days ?? []) {
        if (d.day == null) continue;

        selectedDays[d.day!] = true;

        if (d.open != null) {
          openTimes[d.day!] = TimeOfDay(
            hour: (d.open as int) ~/ 60,
            minute: (d.open as int) % 60,
          );
        }

        if (d.close != null) {
          closeTimes[d.day!] = TimeOfDay(
            hour: (d.close as int) ~/ 60,
            minute: (d.close as int) % 60,
          );
        }
      }
    }

    emit(ClinicInitialState());
  }

  void resetDays() {
    for (final k in selectedDays.keys) {
      selectedDays[k] = false;
    }
    openTimes.clear();
    closeTimes.clear();
  }

  void resetForm() {
    nameController.clear();
    addressController.clear();
    cityController.clear();
    priceController.clear();
    operatingLicenseController.clear();
    latitudeController.clear();
    longitudeController.clear();
    slotDurationController.clear();
    dailyCapacityController.clear();
    patientsPerSlotController.clear();

    resetDays();
  }

  @override
  Future<void> close() {
    nameController.dispose();
    addressController.dispose();
    cityController.dispose();
    priceController.dispose();
    operatingLicenseController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    return super.close();
  }
}