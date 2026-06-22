import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/presentation/facility/layout/services/presentation/widgets/lab_test_card_widget.dart';
import 'package:chefaa/presentation/facility/layout/services/presentation/widgets/radiology_card_widget.dart';
import 'package:chefaa/presentation/facility/layout/services/presentation/widgets/services_ai_insight_widget.dart';
import 'package:chefaa/presentation/facility/layout/services/presentation/widgets/services_search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final TextEditingController _searchController = TextEditingController();
  bool isLab = true;
  bool _cbcActive = true;
  bool _hba1cActive = true;
  bool _urineActive = false;

  bool _mriActive = true;
  bool _ctActive = true;
  bool _xrayActive = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p24.w,
              vertical: AppPadding.p12.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ServicesSearchBarWidget(controller: _searchController),
                SizedBox(height: AppSize.s16.h),
                const ServicesAiInsightWidget(),
                SizedBox(height: AppSize.s24.h),
                isLab
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Lab Tests",
                                style: getBoldStyle(
                                  color: ColorManager.black,
                                  fontSize: 15.sp,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "View all",
                                  style: getBoldStyle(
                                    color: ColorManager.primary,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14.h),

                          LabTestCardWidget(
                            icon: Icons.opacity_rounded,
                            title: "CBC",
                            subtitle: "Complete Blood Count",
                            price: "\$45.00",
                            duration: "15 mins.",
                            isSwitchedOn: _cbcActive,
                            onSwitchChanged: (val) {
                              setState(() {
                                _cbcActive = val;
                              });
                            },
                          ),
                          SizedBox(height: 12.h),

                          LabTestCardWidget(
                            icon: Icons.assignment_outlined,
                            title: "HbA1c",
                            subtitle: "Glycated Hemoglobin",
                            price: "\$85.00",
                            duration: "20 mins.",
                            isSwitchedOn: _hba1cActive,
                            badgeText: "TRENDING",
                            onSwitchChanged: (val) {
                              setState(() {
                                _hba1cActive = val;
                              });
                            },
                          ),
                          SizedBox(height: 12.h),

                          LabTestCardWidget(
                            icon: Icons.science_outlined,
                            title: "Urine Analysis",
                            subtitle: "Standard urinalysis panel",
                            price: "\$30.00",
                            duration: "10 mins.",
                            isSwitchedOn: _urineActive,
                            onSwitchChanged: (val) {
                              setState(() {
                                _urineActive = val;
                              });
                            },
                          ),
                          SizedBox(height: 24.h),
                        ],
                      )
                    : Column(
                        children: [
                          Align(
                            alignment: AlignmentGeometry.centerLeft,
                            child: Text(
                              "Radiology",
                              style: getBoldStyle(
                                color: ColorManager.black,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 14.h),

                          RadiologyCardWidget(
                            imageUrl: ImageAssets.mri,
                            title: "MRI Brain",
                            subtitle: "Comprehensive neuro-imaging panel",
                            price: "\$450.00",
                            duration: "45 mins.",
                            isSwitchedOn: _mriActive,
                            imageOverlayBadge: "Abnormalities",
                            onSwitchChanged: (val) {
                              setState(() {
                                _mriActive = val;
                              });
                            },
                          ),
                          SizedBox(height: AppSize.s16.h),

                          RadiologyCardWidget(
                            imageUrl: ImageAssets.ct,
                            title: "CT Scan",
                            subtitle: "Multi-slice helical scanning",
                            price: "\$320.00",
                            duration: "30 mins.",
                            isSwitchedOn: _ctActive,
                            onSwitchChanged: (val) {
                              setState(() {
                                _ctActive = val;
                              });
                            },
                          ),
                          SizedBox(height: AppSize.s16.h),

                          RadiologyCardWidget(
                            imageUrl: ImageAssets.xRay,
                            title: "X-Ray",
                            subtitle: "Digital radiograph - Chest/Lungs",
                            price: "\$120.00",
                            duration: "15 mins.",
                            isSwitchedOn: _xrayActive,
                            onSwitchChanged: (val) {
                              setState(() {
                                _xrayActive = val;
                              });
                            },
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: ColorManager.primary,
        icon: Icon(Icons.add_rounded, color: ColorManager.white, size: 18.sp),
        label: Text(
          "Add new service",
          style: getBoldStyle(color: ColorManager.white, fontSize: 13.sp),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        elevation: 4,
      ),
    );
  }
}
