import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/constants_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/routes/app_routes_names.dart';
import 'package:chefaa/core/widgets/app_bar_content.dart';
import 'package:chefaa/core/widgets/back_arrow.dart';
import 'package:chefaa/core/widgets/custom_app_bar.dart';
import 'package:chefaa/features/onboarding/presentation/widgets/next_button.dart';
import 'package:chefaa/features/onboarding/presentation/widgets/option_card.dart';

class FacilityOptionScreen extends StatefulWidget {
  const FacilityOptionScreen({super.key});

  @override
  State<FacilityOptionScreen> createState() => _FacilityOptionScreenState();
}

class _FacilityOptionScreenState extends State<FacilityOptionScreen> {
  String? selectedRole;

  void onSelect(String role) {
    setState(() {
      selectedRole = role;
    });
  }

  void _handleNext() {
    if (selectedRole == AppConstants.lab) {
      context.pushReplacement(
        AppRoutesNames.facilitySignUp,
        extra: AppConstants.lab.toLowerCase(),
      );
    } else if (selectedRole == AppConstants.pharmacy) {
      context.pushReplacement(
        AppRoutesNames.pharmacySignUp,
        extra: AppConstants.pharmacy.toLowerCase(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredHeight: 130.h,
        padding: REdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Row(
          children: [
            BackArrow(onTap: () => context.pop()),
            SizedBox(width: 16.w),
            const Expanded(child: AppBarContent()),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24.h),
              Text(
                "Choose Facility",
                style: getBoldStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s24,
                ),
              ),
              SizedBox(height: 32.h),
              OptionCard(
                width: double.infinity,
                title: AppConstants.pharmacy,
                image: ImageAssets.drugs,
                isSelected: selectedRole == AppConstants.pharmacy,
                onTap: () => onSelect(AppConstants.pharmacy),
              ),
              SizedBox(height: 20.h),
              OptionCard(
                width: double.infinity,
                title: "Medical Lab /\nRadiology Center",
                image: ImageAssets.lab,
                isSelected: selectedRole == AppConstants.lab,
                onTap: () => onSelect(AppConstants.lab),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: NextButton(
                  isEnabled: selectedRole != null,
                  onTap: _handleNext,
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
