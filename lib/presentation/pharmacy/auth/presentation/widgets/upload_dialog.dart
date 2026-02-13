import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../manager/pharmacy_cubit.dart';
import '../manager/pharmacy_state.dart';

class UploadMedicalLicenseDialog extends StatefulWidget {
  const UploadMedicalLicenseDialog({super.key});

  @override
  State<UploadMedicalLicenseDialog> createState() => _UploadMedicalLicenseDialogState();
}

class _UploadMedicalLicenseDialogState extends State<UploadMedicalLicenseDialog> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PharmacyCubit, PharmacyState>(
      builder: (context, state) {
        final file = PharmacyCubit.get(context).medicalLicenceFile;
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
                  padding: const EdgeInsets.only(
                    top: AppPadding.p16,
                    left: AppPadding.p16,
                    right: AppPadding.p16,
                    bottom: AppPadding.p4,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/backup.svg"),
                      const SizedBox(width: 8),
                      Text(
                        'Upload your Medical License',
                        style: getRegularStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s16,
                        ),
                      ),
                    ],
                  ),
                ),
                 Divider(color: ColorManager.gray.withOpacity(0.5), thickness: 1),
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
                      padding: const  EdgeInsets.symmetric(
                        horizontal:AppPadding.p20,
                        vertical: AppPadding.p8,
                      ),
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
                              final cubit = PharmacyCubit.get(context);
                              cubit.pickFile();
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

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p16,
                    vertical: AppPadding.p8,
                  ),
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
                                    : 'your_Medical_License.pdf',
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
