import 'package:chefaa/core/manager/file_handler_cubit.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/widget/upload_dialog.dart';
import 'package:chefaa/presentation/patient/ai_lab/presentation/manager/ai_report_cubit.dart';
import 'package:chefaa/presentation/patient/ai_lab/presentation/manager/ai_report_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/routes/app_routes_names.dart';
import '../widgets/ai_app_bar.dart';

class AiLabPage extends StatefulWidget {
  const AiLabPage({super.key});

  @override
  State<AiLabPage> createState() => _AiLabPageState();
}

class _AiLabPageState extends State<AiLabPage> {
  @override
  void initState() {
    super.initState();
    FileHandlerCubit.get(context).clearFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AiAppBar(
          title1: "AI Lab Report",
          onPressed: () {
            Navigator.pushNamed(context, AppRoutesNames.historyReportPage);
          },
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<FileHandlerCubit, FileHandlerState>(
            listener: (context, state) {
              if (state is FilePickedSuccess) {
                AiReportCubit.get(context).reportAnalysis(state.file);
              }
            },
          ),

          BlocListener<AiReportCubit, AiReportState>(
            listener: (context, state) {
              if (state is LoadingState) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.lightGray,
                    ),
                  ),
                );
              }

              if (state is SuccessState) {
                Navigator.pop(context);

                Navigator.pushNamed(
                  context,
                  AppRoutesNames.aiLabAnalysis,
                  arguments: state.report,
                );
              }

              if (state is ErrorState) {
                Navigator.pop(context);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
          ),
        ],
        child: const Padding(
          padding: EdgeInsets.only(top: AppPadding.p28),
          child: Column(
            children: [UploadDialog(isReport: true, text: "Upload Lab Report")],
          ),
        ),
      ),
    );
  }
}
