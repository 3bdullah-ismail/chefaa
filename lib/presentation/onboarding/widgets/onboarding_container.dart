import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/presentation/onboarding/models/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/build_ex.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../core/routes/app_routes_names.dart';
import '../../../core/services/share_service.dart' show SharedServices;
import 'next_button.dart';

class OnboardingContainer extends StatelessWidget {
  final List<OnboardingModel> onboarding;
  final int screenIndex;
  final void Function() next;

  const OnboardingContainer({
    super.key,
    required this.next,
    required this.screenIndex,
    required this.onboarding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height * 0.38,
      padding: REdgeInsets.all(AppPadding.p48),
      decoration: const BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.s32),
          topRight: Radius.circular(AppSize.s32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              onboarding[screenIndex].title,
              style: getBoldStyle(
                color: ColorManager.black,
                fontSize: FontSize.s24,
              ),
            ),
          ),
          const SizedBox(height: AppSize.s32),
          Text(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            onboarding[screenIndex].description,
            style: getSemiBoldStyle(
              color: ColorManager.gray,
              fontSize: FontSize.s16,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(onboarding.length, (index) {
                  bool isActive = screenIndex == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 28 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: isActive
                          ? ColorManager.primary
                          : ColorManager.gray,
                      borderRadius: BorderRadius.circular(36),
                    ),
                  );
                }),
              ),
              const Spacer(),
              NextButton(
                onTap: () async {
                  await SharedServices.saveBool("isFirst", true);
                  if (screenIndex ==
                      OnboardingModel.onboardingData.length - 1) {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutesNames.login,
                    );
                  } else {
                    next();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
