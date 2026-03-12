import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/resources/color_manager.dart';
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
                  width: 100,
                  height: 100,
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "user name",
                style: getSemiBoldStyle(
                  color: ColorManager.white,
                  fontSize: 20,
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
          padding: const EdgeInsets.all(24),
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
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Basic DetailsBasic Details",
                                  style: getSemiBoldStyle(
                                    color: ColorManager.black,
                                    fontSize: 20,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: SvgPicture.asset(
                                    "assets/svg_images/edit.svg",
                                  ),
                                ),
                              ],
                            ),
                            ItemContainer(
                              child: Column(children: [Text("data")]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(color: ColorManager.input, thickness: 1),
                    ItemContent(
                      image: "assets/svg_images/love.svg",
                      widget: const ItemColumn(
                        text: "Medical Info.",
                        subText: "Blood type, Allergies,\n chronic conditions",
                      ),
                      onTap: () {},
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
                  onTap: () {},
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
                      padding: const EdgeInsets.symmetric(
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
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '1.0.0',
                            style: getMediumStyle(
                              color: ColorManager.gray,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: ColorManager.input,
                      height: 1,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
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
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'View',
                            style:
                                getMediumStyle(
                                  color: ColorManager.primary,
                                  fontSize: 13,
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
                  mainAxisAlignment: .center,
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
                        fontSize: 20,
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
                  fontSize: 16,
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
        style: getBoldStyle(color: ColorManager.black, fontSize: 20.sp),
      ),
    );
  }
}

class ProfileBottomSheet extends StatelessWidget {
  final Widget content;

  const ProfileBottomSheet({super.key, required this.content});

  static void show(BuildContext context, Widget content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: false,
      backgroundColor: ColorManager.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) => ProfileBottomSheet(content: content),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * .8,
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: Column(
          children: [
            Container(
              width: 134,
              height: 2.30,
              decoration: ShapeDecoration(
                color: const Color(0xFF232B43),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}
