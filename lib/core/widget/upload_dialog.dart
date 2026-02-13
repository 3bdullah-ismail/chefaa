import 'package:chefaa/core/manager/file_handler_cubit.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UploadDialog extends StatefulWidget {
  const UploadDialog({super.key, this.text, this.fileName});
  final String? text;
  final String? fileName;
  @override
  State<UploadDialog> createState() => _UploadDialogState();
}

class _UploadDialogState extends State<UploadDialog> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FileHandlerCubit, FileHandlerState>(
      builder: (context, state) {
        final file = FileHandlerCubit.get(context).pickedFile;
        return Dialog(
          backgroundColor: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: 300.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/backup.svg"),
                      const SizedBox(width: 8),
                      Text(
                        widget.text ?? 'Upload your Membership Card',
                        style: getRegularStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s16,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: ColorManager.gray, thickness: 1.2),
                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DottedBorder(
                    options: const RoundedRectDottedBorderOptions(
                      color: ColorManager.primary,
                      strokeWidth: 2,
                      dashPattern: [6, 4],
                      radius: Radius.circular(12),
                    ),

                    child: Container(
                      width: 250.w,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Image.asset("assets/images/backup.png"),
                          const SizedBox(height: 8),
                          Text(
                            'Choose a file',
                            style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'JPEG, PNG, PDF, and MP4 formats, up to 50 MB.',
                            textAlign: TextAlign.center,
                            style: getRegularStyle(
                              color: ColorManager.gray,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 12),
                          InkWell(
                            onTap: () {
                              final cubit = FileHandlerCubit.get(context);
                              cubit.pickSingleFile();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorManager.primary,
                                  width: 1.75,
                                ),
                                color: ColorManager.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Browse Files',
                                style: getRegularStyle(
                                  color: ColorManager.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorManager.primary,
                        width: 1.5,
                      ),
                      color: ColorManager.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.picture_as_pdf, color: Colors.red),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                file != null
                                    ? file.name
                                    : widget.fileName ??
                                          'your_Membership_Card.pdf',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                file != null
                                    ? '${(file.size / 1024).toStringAsFixed(2)} KB'
                                    : '54 KB of 94 KB',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.check_circle, color: Colors.green),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
