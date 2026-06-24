import 'package:chefaa/presentation/facility/dashboard/data/models/get_dashboard_response.dart';
import 'package:chefaa/presentation/facility/dashboard/data/models/upload_result_response.dart';
import 'package:chefaa/presentation/facility/dashboard/data/models/create_patient_request_response.dart';
import 'package:chefaa/presentation/facility/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'dashboard_state.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository _dashboardRepository;

  GetDashboardResponse? dashboardResponse;

  DashboardCubit(this._dashboardRepository) : super(DashboardInitial());

  static DashboardCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> getDashboard() async {
    emit(GetDashboardLoading());
    try {
      final response = await _dashboardRepository.getDashboard();
      dashboardResponse = response;
      emit(GetDashboardSuccess(response));
    } catch (e) {
      emit(GetDashboardFailure(e.toString()));
    }
  }

  Future<void> uploadResult({
    required String requestId,
    required String filePath,
  }) async {
    emit(UploadResultLoading(requestId: requestId));
    try {
      final response = await _dashboardRepository.uploadResult(
        requestId: requestId,
        filePath: filePath,
      );
      emit(UploadResultSuccess(response));
    } catch (e) {
      emit(UploadResultFailure(e.toString()));
    }
  }

  Future<void> createPatientRequest({
    required String patientPhone,
    required List<String> serviceIds,
    required bool viaAI,
  }) async {
    emit(CreatePatientRequestLoading());
    try {
      final response = await _dashboardRepository.createPatientRequest(
        patientPhone: patientPhone,
        serviceIds: serviceIds,
        viaAI: viaAI,
      );
      emit(CreatePatientRequestSuccess(response));
    } catch (e) {
      emit(CreatePatientRequestFailure(e.toString()));
    }
  }
}
