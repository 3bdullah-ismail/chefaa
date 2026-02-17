import 'package:chefaa/core/manager/file_handler_cubit.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/widget/upload_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadCard extends StatelessWidget {
  const UploadCard({super.key, this.text, this.dialogText, this.fileName});

  final String? text;
  final String? dialogText;
  final String? fileName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FileHandlerCubit, FileHandlerState>(
      builder: (context, state) {
        final cubit = FileHandlerCubit.get(context);
        final file = cubit.pickedFile;
        return InkWell(
          onTap: () {
            final cubit = context.read<FileHandlerCubit>();
            showDialog(
              context: context,
              builder: (context) => BlocProvider.value(
                value: cubit,
                child: UploadDialog(text: dialogText, fileName: fileName),
              ),
            );
          },
          child: DottedBorder(
            options: const RoundedRectDottedBorderOptions(
              dashPattern: [8, 4],
              strokeWidth: 1,
              radius: Radius.circular(24),
              color: ColorManager.gray,
            ),
            child: file == null
                ? Container(
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xffF7F7F7),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      text ?? "Upload your Membership Card",
                      style: const TextStyle(
                        color: Color(0xff9AA0A6),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Image.asset("assets/images/pdf.png", height: 50),
                        const SizedBox(width: 8),
                        Expanded(child: Text(file.name)),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
