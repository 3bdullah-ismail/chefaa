import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/presentation/pharmacy/presentation/widgets/upload_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/pharmacy_cubit.dart';
import '../manager/pharmacy_state.dart';

class UploadMedicalLicenseCard extends StatelessWidget {
  final String text;
  const UploadMedicalLicenseCard({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PharmacyCubit, PharmacyState>(
      builder: (context, state) {
        final cubit = PharmacyCubit.get(context);
        final file = cubit.medicalLicenceFile;
        return InkWell(
          onTap: () {
            final cubit = context.read<PharmacyCubit>();
            showDialog(
              context: context,
              builder: (context) => BlocProvider.value(
                value: cubit,
                child: const UploadMedicalLicenseDialog(),
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
                    height: 45,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xffF7F7F7),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child:  Text(
                      text,
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
                        Text(file.name),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
