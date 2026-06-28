import 'package:chefaa/shared/file_handler/presentation/manager/file_handler_cubit.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:chefaa/core/resources/values_manager.dart';

class UploadDialog extends StatefulWidget {
  const UploadDialog({
    super.key,
    this.isReport = false,
    this.text,
    this.fileName,
  });

  final String? text;
  final String? fileName;
  final bool isReport;

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
          child: Container(
            decoration: BoxDecoration(
              color: ColorManager.lightGray.withValues(alpha: 50),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ColorManager.input, width: 1),
            ),
            child: SizedBox(
              width: 300.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppPadding.p20,
                      bottom: AppPadding.p4,
                    ),
                    child: Row(
                      children: [
                        !widget.isReport
                            ? SvgPicture.asset("assets/icons/backup.svg")
                            : const SizedBox.shrink(),
                        10.horizontalSpace,
                        Expanded(
                          child: Text(
                            widget.text ?? 'Upload your Membership Card',
                            style: getRegularStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  widget.isReport
                      ? const SizedBox()
                      : const Divider(color: ColorManager.gray, thickness: 1),
                  10.verticalSpace,

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: DottedBorder(
                      options: const RoundedRectDottedBorderOptions(
                        color: ColorManager.primary,
                        strokeWidth: 2,
                        dashPattern: [6, 4],
                        radius: Radius.circular(12),
                      ),

                      child: Container(
                        width: 250.w,
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          children: [
                            Image.asset("assets/images/backup.png"),
                            5.verticalSpace,
                            Text(
                              'Choose a file',
                              style: getBoldStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s16,
                              ),
                            ),
                            4.verticalSpace,
                            Text(
                              'JPEG, PNG, PDF, and MP4 formats, up to 50 MB.',
                              textAlign: TextAlign.center,
                              style: getRegularStyle(
                                color: ColorManager.gray,
                                fontSize: 12,
                              ),
                            ),
                            10.verticalSpace,
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

                  file != null
                      ? Padding(
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
                                const Icon(
                                  Icons.picture_as_pdf,
                                  color: Colors.red,
                                ),
                                10.horizontalSpace,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        file.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        '${(file.size / 1024).toStringAsFixed(2)} KB',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
