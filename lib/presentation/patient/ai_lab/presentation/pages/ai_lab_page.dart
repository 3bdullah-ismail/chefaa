import 'package:chefaa/presentation/patient/ai_lab/presentation/pages/ai_lab_analysis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/manager/file_handler_cubit.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/widget/custom_app_bar.dart';
import '../../../../../core/widget/upload_dialog.dart';

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
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomAppBar(
          isSingleTitle: true,
          isLayout: true,
          title1: "AI Lab Report ",
        ),
      ),
      body: BlocListener<FileHandlerCubit, FileHandlerState>(
        listener: (context, state) async {
          if (state is FilePickedSuccess) {
            await Future.delayed(const Duration(milliseconds: 1500));

            if (context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AILabAnalysis(),
                ),
              );
            }
          }
        },
        child: const Padding(
          padding: EdgeInsets.only(top: AppPadding.p28),
          child: Column(
            children: [
              UploadDialog(
                isReport: true,
                text: "Upload Lab Report",
              ),
            ],
          ),
        ),
      ),
    );
  }
}