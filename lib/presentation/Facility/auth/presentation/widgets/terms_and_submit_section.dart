import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/constants_manager.dart';
import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:chefaa/core/widget/terms_of_service.dart';
import 'package:chefaa/core/widget/already_have_account.dart';
import 'package:chefaa/core/manager/file_handler_cubit.dart';
import 'package:chefaa/presentation/facility/auth/presentation/manager/facility_auth_cubit.dart';

class TermsAndSubmitSection extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final FacilityAuthCubit cubit;
  final FacilityAuthState state;

  const TermsAndSubmitSection({
    super.key,
    required this.formKey,
    required this.cubit,
    required this.state,
  });

  @override
  State<TermsAndSubmitSection> createState() => _TermsAndSubmitSectionState();
}

class _TermsAndSubmitSectionState extends State<TermsAndSubmitSection> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
                child: isChecked
                    ? SvgPicture.asset(IconsAssets.checkIconActive)
                    : SvgPicture.asset(IconsAssets.checkIconInactive),
              ),
              const SizedBox(width: 12),
              const Expanded(child: TermsOfService()),
            ],
          ),
        ),
        const SizedBox(height: 16),
        CustomBtn(
          isDisabled: !isChecked || widget.state is SignUpLoading,
          text: AppConstants.submitForVerification,
          onPressed: () {
            if (widget.formKey.currentState!.validate()) {
              final file = context.read<FileHandlerCubit>().pickedFile;
              widget.cubit.signUp(medicalLicence: file);
            }
          },
        ),
        const SizedBox(height: 15),
        const AlreadyHaveAccount(),
        const SizedBox(height: 25),
      ],
    );
  }
}

