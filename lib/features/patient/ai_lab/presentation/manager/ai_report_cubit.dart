import 'package:chefaa/core/services/hive_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import 'package:chefaa/features/patient/ai_lab/domain/repositories/ai_report_repo.dart';
import 'ai_report_state.dart';

@injectable
class AiReportCubit extends Cubit<AiReportState> {
  final AIReportRepo aiReportRepo;

  AiReportCubit(this.aiReportRepo) : super(InitialState());

  static AiReportCubit get(BuildContext context) => BlocProvider.of(context);
  final Box<dynamic> box = Hive.box(HiveBoxes.reportsBox);

  Future<void> reportAnalysis(PlatformFile? file) async {
    if (file == null) {
      if (!isClosed) emit(ErrorState("Please upload your report file"));
      return;
    }
    if (!isClosed) emit(LoadingState());
    try {
      final report = await aiReportRepo.reportAnalysis(file);
      final isDuplicate = box.values.any((item) {
        final data = (item as Map)['data'];
        return data['patientName'] == report.data?.patientName &&
            data['dangerScore'] == report.data?.dangerScore;
      });

      if (!isDuplicate) {
        await box.add({
          ...report.toJson(),
          "createdAt": DateTime.now().toIso8601String(),
        });
      }
      if (!isClosed) emit(SuccessState(report));
    } catch (e) {
      if (!isClosed) emit(ErrorState(e.toString()));
    }
  }

  Future<void> deleteReport(dynamic key) async => box.delete(key);
}
