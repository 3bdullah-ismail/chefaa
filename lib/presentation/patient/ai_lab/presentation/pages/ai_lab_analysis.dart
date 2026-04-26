import 'package:chefaa/presentation/patient/ai_lab/presentation/widgets/analysis_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../manager/ai_report_cubit.dart';
import '../manager/ai_report_state.dart';
import '../widgets/ai_summary.dart';
import '../widgets/ai_tips.dart';
import '../widgets/health_indicator.dart';
import '../widgets/report_finding_items.dart';
import '../widgets/risk_level_ai.dart';

class AILabAnalysis extends StatefulWidget {
  const AILabAnalysis({super.key});

  @override
  State<AILabAnalysis> createState() => _AILabAnalysisState();
}

class _AILabAnalysisState extends State<AILabAnalysis> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AnalysisAppBar(
          title1: "AI Lab Report Analysis",
        ),),

      body: BlocBuilder<AiReportCubit, AiReportState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ErrorState) {
            return Center(child: Text(state.error));
          }

          if (state is SuccessState) {
            final report = state.report;
            final findings = report.data?.findings ?? [];

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p32,
                  vertical: AppPadding.p28,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Report Findings",
                      style: getSemiBoldStyle(
                        color: ColorManager.black,
                        fontSize: 20.sp,
                      ),
                    ),

                    15.verticalSpace,
                    Container(
                      height: 250.h,
                      padding: const EdgeInsets.all(AppPadding.p20),
                      decoration: BoxDecoration(
                        color: ColorManager.lightGray,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: ColorManager.input),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.black.withAlpha(40),
                            blurRadius: 8,
                          ),
                        ],
                      ),

                      child: RawScrollbar(
                        controller: _scrollController,
                        thumbVisibility: true,
                        trackColor: ColorManager.input.withAlpha(85),
                        thickness: 5,
                        radius: const Radius.circular(25),
                        interactive: true,

                        child: ListView.separated(
                          controller: _scrollController,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(
                            right: AppPadding.p16,
                          ),
                          itemCount: findings.length,

                          separatorBuilder: (_, __) => const Divider(
                            color: ColorManager.input,
                            thickness: 1,
                          ),

                          itemBuilder: (context, index) {
                            final item = findings[index];

                            return ReportFindingItems(
                              testName: item.testName ?? "",
                              value: item.result ?? 0,
                              status: item.status ?? "",
                              unit: item.unit ?? "",
                            );
                          },
                        ),
                      ),
                    ),

                    20.verticalSpace,

                    Text(
                      "Your health Indicator",
                      style: getSemiBoldStyle(
                        color: ColorManager.black,
                        fontSize: 20.sp,
                      ),
                    ),

                    20.verticalSpace,

                    HealthIndicator(
                      value: (report.data?.dangerScore ?? 0).toDouble(),
                    ),

                    20.verticalSpace,

                    RiskLevelAi(
                      dangerScore:
                      (report.data?.dangerScore ?? 0).toDouble(),
                    ),

                    20.verticalSpace,

                    AiSummary(summary: report.data?.summary ?? ""),

                    20.verticalSpace,

                    AiTips(tips: report.data?.tips ?? []),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}