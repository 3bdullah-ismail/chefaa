import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:chefaa/core/services/hive_service.dart';
import '../../data/models/Report_analysis.dart';
import '../manager/ai_report_cubit.dart';
import '../widgets/analysis_app_bar.dart';
import '../widgets/history_report_card.dart';
import 'report_details_page.dart';

class ReportsHistoryPage extends StatelessWidget {
  const ReportsHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box(HiveBoxes.reportsBox);
    final cubit = AiReportCubit.get(context);

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AnalysisAppBar(
          title1: "AI Lab Report History",
        ),
      ),

      body: ValueListenableBuilder(
        valueListenable: box.listenable(),

        builder: (context, Box box, _) {
          final reports = box.toMap().entries.toList().reversed.toList();

          if (reports.isEmpty) {
            return const Center(
              child: Text("No reports yet"),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: reports.length,
            separatorBuilder: (_, _) =>
            const SizedBox(height: 12),

            itemBuilder: (context, index) {
              final item = reports[index];

              final report = ReportAnalysis.fromJson(
                Map<String, dynamic>.from(item.value),
              );

              return ReportCard(
                report: report,

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReportDetailsPage(
                        report: report,
                      ),
                    ),
                  );
                },

                onDelete: () async {
                  await cubit.deleteReport(item.key);

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Deleted successfully"),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}