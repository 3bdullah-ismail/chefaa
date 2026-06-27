import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/extensions/build_ex.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/constants_manager.dart';
import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/widget/custom_dropdown_btn.dart';
import 'package:chefaa/core/widget/upload_container.dart';
import 'package:chefaa/core/widget/validators.dart';
import 'package:chefaa/core/widget/license_formatter.dart';
import 'package:chefaa/presentation/facility/auth/presentation/manager/facility_auth_cubit.dart';
import 'labeled_text_field.dart';

class FacilityInfoCard extends StatefulWidget {
  final FacilityAuthCubit cubit;

  const FacilityInfoCard({super.key, required this.cubit});

  @override
  State<FacilityInfoCard> createState() => _FacilityInfoCardState();
}

class _FacilityInfoCardState extends State<FacilityInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        width: context.width * 0.9,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppConstants.facilityType,
              style: getMediumStyle(color: ColorManager.black, fontSize: 16),
            ),
            const SizedBox(height: 16),
            CustomDropDownBtn(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select The Type';
                }
                return null;
              },
              value: widget.cubit.facilityType,
              onChanged: (value) {
                setState(() {
                  widget.cubit.facilityType = value;
                });
              },
              items: const ["Lab", "Radiology center"],
              hintText: 'choose lab or radiology',
            ),
            const SizedBox(height: 16),
            LabeledTextField(
              validator: Validators.businessNameValidator,
              label: AppConstants.facilityName,
              controller: widget.cubit.name,
              hint: "e.g. Alpa Labs/Scan",
            ),
            LabeledTextField(
              keyboardType: TextInputType.phone,
              validator: Validators.validatePhone,
              label: AppConstants.phoneNumber,
              controller: widget.cubit.phoneNumber,
              hint: AppConstants.phoneHint,
              prefixIcon: IconsAssets.phoneIcon,
              textInputAction: TextInputAction.next,
            ),
            LabeledTextField(
              keyboardType: TextInputType.emailAddress,
              validator: Validators.validateEmail,
              label: AppConstants.workEmail,
              controller: widget.cubit.email,
              hint: AppConstants.emailFacilityHint,
              prefixIcon: IconsAssets.emailIcon,
              textInputAction: TextInputAction.next,
            ),
            LabeledTextField(
              keyboardType: TextInputType.visiblePassword,
              validator: Validators.validatePassword,
              label: AppConstants.password,
              controller: widget.cubit.password,
              hint: AppConstants.enterPassword,
              isPassword: true,
              prefixIcon: IconsAssets.passwordIcon,
              textInputAction: TextInputAction.next,
            ),
            LabeledTextField(
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              validator: (value) => Validators.validateConfirmPassword(
                value,
                widget.cubit.password.text,
              ),
              label: AppConstants.confirmPassword,
              controller: widget.cubit.confirmPasswordController,
              hint: AppConstants.reEnterPassword,
              isPassword: true,
              prefixIcon: IconsAssets.passwordIcon,
            ),
            LabeledTextField(
              textInputAction: TextInputAction.done,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                LicenseFormatter(),
              ],
              validator: Validators.validateLicense,
              label: AppConstants.commercialLicenseNumber,
              controller: widget.cubit.commercialRegisterNumber,
              hint: AppConstants.licenseHint,
            ),
            const SizedBox(height: 22),
            Text(
              AppConstants.medicalLicenseUpload,
              style: getMediumStyle(color: ColorManager.black, fontSize: 16),
            ),
            const SizedBox(height: 16),
            const UploadCard(
              text: AppConstants.uploadYourLicence,
              dialogText: AppConstants.uploadYourMedicalLicence,
              fileName: AppConstants.licensePdf,
            ),
            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }
}

