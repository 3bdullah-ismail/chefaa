import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/presentation/doctor/auth/presentation/manager/doctor_auth_cubit.dart';
import 'package:chefaa/presentation/doctor/auth/presentation/widgets/upload_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadMembershipCard extends StatelessWidget {
  const UploadMembershipCard({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorAuthCubit, DoctorAuthState>(
      builder: (context, state) {
        final cubit = DoctorAuthCubit.get(context);
        final file = cubit.membershipFile;
        return InkWell(
          onTap: () {
            final cubit = context.read<DoctorAuthCubit>();
            showDialog(
              context: context,
              builder: (context) => BlocProvider.value(
                value: cubit,
                child: const  UploadMembershipDialog(),
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
                    child: const Text(
                      "Upload your Membership Card",
                      style: TextStyle(
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
