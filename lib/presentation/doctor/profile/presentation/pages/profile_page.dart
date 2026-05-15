import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/font_manager.dart';
import '../../../../patient/profile/presentation/pages/profile_page.dart';
import '../../../../patient/profile/presentation/widgets/item_column.dart';
import '../../../../patient/profile/presentation/widgets/item_container.dart';
import '../../../../patient/profile/presentation/widgets/item_content.dart';
import '../widgets/lower_stats_grid.dart';
import '../widgets/upper_profile_section.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              sliver: const SliverToBoxAdapter(child: UpperProfileSection()),
            ),
            const SliverToBoxAdapter(child: LowerStatsGrid()),
            SliverToBoxAdapter(child: SizedBox(height: 24.h)),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Personal info.",
                        style: getBoldStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s20.sp,
                        ),
                      ),
                    ),
                    16.verticalSpace,
                    ItemContainer(
                      child: Column(
                        children: [
                          ItemContent(
                            image: "assets/svg_images/person.svg",
                            widget: const ItemColumn(
                              text: "Basic Details",
                              subText: "Name, Gender, Specialization, license",
                            ),
                            onTap: () {},
                          ),
                          const Divider(
                            color: ColorManager.input,
                            thickness: 1,
                          ),
                          ItemContent(
                            image: "assets/svg_images/love.svg",
                            widget: const ItemColumn(
                              text: "Password & Security",
                              subText: "last changed 3 months ago",
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    24.verticalSpace,
                    const VersionContainer(),
                    16.verticalSpace,
                    const LogOutBtn(),
                    16.verticalSpace,
                    const DeleteAccount(),
                    24.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
