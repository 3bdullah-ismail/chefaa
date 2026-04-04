import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/resources/color_manager.dart';
import '../widgets/appointment_card.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/edit_medical_information.dart';
import '../widgets/edit_user_details.dart';
import '../widgets/item_column.dart';
import '../widgets/item_container.dart';
import '../widgets/item_content.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(210),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorManager.primary,
          shadowColor: ColorManager.black.withValues(alpha: .25),
          elevation: 15,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.asset(
                  "assets/images/patient.png",
                  width: 100.w,
                  height: 100.h,
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "user name",
                style: getSemiBoldStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s20.sp,
                ),
              ),
            ],
          ),

          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: REdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              16.verticalSpace,
              _buildSectionTitle("Personal info."),
              16.verticalSpace,
              ItemContainer(
                child: Column(
                  children: [
                    ItemContent(
                      image: "assets/svg_images/person.svg",
                      widget: const ItemColumn(
                        text: "Basic Details",
                        subText: "Name, Gender, DOB,\n Weight, Height",
                      ),
                      onTap: () => ProfileBottomSheet.show(
                        context,
                        const EditUserDetails(),
                      ),
                    ),
                    const Divider(color: ColorManager.input, thickness: 1),
                    ItemContent(
                      image: "assets/svg_images/love.svg",
                      widget: const ItemColumn(
                        text: "Medical Info.",
                        subText: "Blood type, Allergies,\n chronic conditions",
                      ),
                      onTap: () => ProfileBottomSheet.show(
                        context,
                        const EditMedicalInformation(),
                      ),
                    ),
                  ],
                ),
              ),
              32.verticalSpace,
              _buildSectionTitle("Payments"),
              16.verticalSpace,
              ItemContainer(
                child: ItemContent(
                  image: "assets/svg_images/wallet.svg",
                  text: "Payments History",
                  onTap: () => ProfileBottomSheet.show(
                    context,
                    const AppointmentCard(),
                    // const Column(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     Text(
                    //       "No payments yet",
                    //       style: TextStyle(
                    //         color: ColorManager.gray,
                    //         fontSize: 16,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                ),
              ),
              32.verticalSpace,
              _buildSectionTitle("Language"),
              16.verticalSpace,
              ItemContainer(
                child: ItemContent(
                  image: "assets/svg_images/earth.svg",
                  text: "English",
                  onTap: () {},
                ),
              ),
              32.verticalSpace,
              ItemContainer(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: REdgeInsets.symmetric(
                        horizontal: 23,
                        vertical: 17,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Version',
                            style: getSemiBoldStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s16.sp,
                            ),
                          ),
                          Text(
                            '1.0.0',
                            style: getMediumStyle(
                              color: ColorManager.gray,
                              fontSize: FontSize.s12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: ColorManager.input,
                      height: 1.h,
                      thickness: 1,
                    ),
                    Padding(
                      padding: REdgeInsets.symmetric(
                        horizontal: 23,
                        vertical: 17,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Terms and Privacy',
                            style: getSemiBoldStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s16.sp,
                            ),
                          ),
                          Text(
                            'View',
                            style:
                                getMediumStyle(
                                  color: ColorManager.primary,
                                  fontSize: FontSize.s12.sp,
                                ).copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: ColorManager.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              32.verticalSpace,
              ItemContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/svg_images/Logout.svg",
                      colorFilter: const ColorFilter.mode(
                        ColorManager.error,
                        BlendMode.srcIn,
                      ),
                    ),
                    24.horizontalSpace,
                    Text(
                      "Logout",
                      style: getSemiBoldStyle(
                        color: ColorManager.error,
                        fontSize: FontSize.s20.sp,
                      ),
                    ),
                  ],
                ),
              ),
              24.verticalSpace,
              Text(
                "Delete account",
                style: getSemiBoldStyle(
                  color: ColorManager.error,
                  fontSize: FontSize.s16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: getBoldStyle(
          color: ColorManager.black,
          fontSize: FontSize.s20.sp,
        ),
      ),
    );
  }
}
