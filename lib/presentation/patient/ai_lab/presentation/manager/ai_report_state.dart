import '../../data/models/Report_analysis.dart';

sealed class AiReportState {}

final class InitialState extends AiReportState {}

final class LoadingState extends AiReportState {}

final class SuccessState extends AiReportState {
  final ReportAnalysis report;

  SuccessState(this.report);
}

final class ErrorState extends AiReportState {
  final String error;

  ErrorState(this.error);
}

class HistoryReportItem {
  final dynamic key;
  final ReportAnalysis report;

  const HistoryReportItem({required this.key, required this.report});
}

final class HistoryLoadingState extends AiReportState {}

final class HistoryLoadedState extends AiReportState {
  final List<HistoryReportItem> reports;

  HistoryLoadedState(this.reports);
}

final class HistoryRefreshState extends AiReportState {}
