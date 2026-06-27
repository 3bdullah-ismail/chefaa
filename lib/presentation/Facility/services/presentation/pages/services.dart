import 'package:chefaa/core/config/get_config.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/services/storage_service.dart';
import 'package:chefaa/presentation/Facility/services/presentation/manager/services_cubit.dart';
import 'package:chefaa/presentation/Facility/services/presentation/widgets/add_service_bottom_sheet.dart';
import 'package:chefaa/presentation/Facility/services/presentation/widgets/lab_test_card_widget.dart';
import 'package:chefaa/presentation/Facility/services/presentation/widgets/radiology_card_widget.dart';
import 'package:chefaa/presentation/Facility/services/presentation/widgets/services_search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final TextEditingController _searchController = TextEditingController();
  bool isLab = true;

  @override
  void initState() {
    super.initState();
    _checkRoleType();
  }

  void _checkRoleType() {
    final user = StorageService.user;
    if (user != null && user.role != null) {
      final role = user.role!.toLowerCase();
      if (role == 'radiology center' || role == 'radiology' || role == 'scan') {
        setState(() {
          isLab = false;
        });
      } else {
        setState(() {
          isLab = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ServicesCubit>()..getMyServices(),
      child: Builder(
        builder: (context) {
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
                      ServicesSearchBarWidget(
                        controller: _searchController,
                        onChanged: (value) {
                          context.read<ServicesCubit>().searchServicesLocally(
                            value,
                          );
                        },
                        onSubmitted: (value) {
                          context.read<ServicesCubit>().getMyServices(
                            search: value,
                          );
                        },
                        onSearchPressed: () {
                          context.read<ServicesCubit>().getMyServices(
                            search: _searchController.text,
                          );
                        },
                      ),
                      SizedBox(height: AppSize.s16.h),
                      BlocConsumer<ServicesCubit, ServicesState>(
                        listener: (context, state) {
                          if (state is ToggleServiceSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Service status updated successfully!",
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else if (state is ToggleServiceFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Error: ${state.errorMessage}"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          final cubit = ServicesCubit.get(context);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (state is GetServicesLoading)
                                const Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 40),
                                    child: CircularProgressIndicator(
                                      color: ColorManager.primary,
                                    ),
                                  ),
                                )
                              else if (state is GetServicesFailure)
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 40,
                                    ),
                                    child: Text(
                                      state.errorMessage,
                                      style: getRegularStyle(
                                        color: Colors.red,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                )
                              else ...[
                                if (isLab) ...[
                                  Text(
                                    "Lab Tests",
                                    style: getBoldStyle(
                                      color: ColorManager.black,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  SizedBox(height: 14.h),
                                  if (cubit.labTests.isEmpty)
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 24.h,
                                        ),
                                        child: Text(
                                          "No services found",
                                          style: getRegularStyle(
                                            color: ColorManager.gray,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    ...cubit.labTests.map(
                                      (service) => Padding(
                                        padding: EdgeInsets.only(bottom: 12.h),
                                        child: LabTestCardWidget(
                                          icon: Icons.science_outlined,
                                          title: service.name ?? "",
                                          subtitle:
                                              service.instructions ??
                                              "No instructions provided",
                                          price:
                                              "\$${service.price?.toStringAsFixed(2) ?? "0.00"}",
                                          duration:
                                              service.estimatedTime ?? "N/A",
                                          isSwitchedOn:
                                              service.isActive ?? false,
                                          onSwitchChanged: (val) {
                                            context
                                                .read<ServicesCubit>()
                                                .toggleService(
                                                  service.id ?? "",
                                                );
                                          },
                                        ),
                                      ),
                                    ),
                                ] else ...[
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
                                  if (cubit.radiologyScans.isEmpty)
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 24.h,
                                        ),
                                        child: Text(
                                          "No services found",
                                          style: getRegularStyle(
                                            color: ColorManager.gray,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    ...cubit.radiologyScans.map(
                                      (service) => Padding(
                                        padding: EdgeInsets.only(bottom: 16.h),
                                        child: RadiologyCardWidget(
                                          imageUrl: service.imageUrl ?? "",
                                          title: service.name ?? "",
                                          subtitle: service.estimatedTime ?? "",
                                          price:
                                              "\$${service.price?.toStringAsFixed(2) ?? "0.00"}",
                                          duration:
                                              service.sessionDuration ?? "N/A",
                                          isSwitchedOn:
                                              service.isActive ?? false,
                                          onSwitchChanged: (val) {
                                            context
                                                .read<ServicesCubit>()
                                                .toggleService(
                                                  service.id ?? "",
                                                );
                                          },
                                        ),
                                      ),
                                    ),
                                ],
                              ],
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                _showAddServiceBottomSheet(context);
              },
              backgroundColor: ColorManager.primary,
              icon: Icon(
                Icons.add_rounded,
                color: ColorManager.white,
                size: 18.sp,
              ),
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
        },
      ),
    );
  }

  void _showAddServiceBottomSheet(BuildContext parentContext) {
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BlocProvider.value(
          value: BlocProvider.of<ServicesCubit>(parentContext),
          child: AddServiceBottomSheet(isLab: isLab),
        );
      },
    );
  }
}

