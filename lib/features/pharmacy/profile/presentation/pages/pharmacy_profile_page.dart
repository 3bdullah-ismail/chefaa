import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/config/get_config.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/services/storage_service.dart';
import 'package:chefaa/features/patient/profile/presentation/pages/profile_page.dart';
import 'package:chefaa/features/pharmacy/profile/data/models/pharmacy_profile_response.dart';
import 'package:chefaa/features/pharmacy/profile/presentation/manager/pharmacy_profile_cubit.dart';
import 'package:chefaa/features/pharmacy/profile/presentation/pages/edit_pharmacy_profile_page.dart';
import 'package:chefaa/features/pharmacy/settings/presentation/pages/pharmacy_settings_page.dart';

import 'package:chefaa/features/pharmacy/profile/presentation/widgets/profile_header.dart';
import 'package:chefaa/features/pharmacy/profile/presentation/widgets/profile_quick_info_cards.dart';
import 'package:chefaa/features/pharmacy/profile/presentation/widgets/about_pharmacy_section.dart';
import 'package:chefaa/features/pharmacy/profile/presentation/widgets/operating_settings_section.dart';
import 'package:chefaa/features/pharmacy/profile/presentation/widgets/working_hours_section.dart';
import 'package:chefaa/features/pharmacy/profile/presentation/widgets/addresses_section.dart';
import 'package:chefaa/features/pharmacy/profile/presentation/widgets/delivery_section.dart';
import 'package:chefaa/features/pharmacy/profile/presentation/widgets/verification_license_section.dart';
import 'package:chefaa/features/pharmacy/profile/presentation/widgets/payment_methods_section.dart';
import 'package:chefaa/features/pharmacy/profile/presentation/widgets/profile_action_buttons.dart';

class PharmacyProfilePage extends StatefulWidget {
  const PharmacyProfilePage({super.key});

  @override
  State<PharmacyProfilePage> createState() => _PharmacyProfilePageState();
}

class _PharmacyProfilePageState extends State<PharmacyProfilePage> {
  late final PharmacyProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<PharmacyProfileCubit>()..getPharmacyProfile();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: BlocBuilder<PharmacyProfileCubit, PharmacyProfileState>(
          builder: (context, state) {
            if (state is PharmacyProfileLoading) {
              return _buildLoadingState();
            } else if (state is PharmacyProfileError) {
              return _buildErrorState(state.errorMessage);
            } else if (state is PharmacyProfileSuccess ||
                state is PharmacyProfileUpdateSuccess) {
              final profileResponse = state is PharmacyProfileSuccess
                  ? state.profileResponse
                  : (state as PharmacyProfileUpdateSuccess).profileResponse;
              return _buildProfileContent(profileResponse.data);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(color: ColorManager.primary),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded,
                color: Colors.red.shade300, size: 60.sp),
            SizedBox(height: 16.h),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () => _cubit.getPharmacyProfile(),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text("Retry"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileContent(PharmacyProfileData? profileData) {
    final user = StorageService.user;
    final String pharmacyName =
        profileData?.pharmacyName ?? user?.name ?? "Pharmacy";

    final firstAddress = profileData?.addresses?.isNotEmpty == true
        ? profileData!.addresses!.first
        : null;
    final String location =
        (firstAddress is Map ? firstAddress["addressText"] : null)?.toString() ??
            'Not specified';

    final bool isOpen = profileData?.openNow ?? false;
    final bool isDeliveryAvailable = profileData?.deliveryAvailable ?? false;

    final about = profileData?.about;
    final addresses = profileData?.addresses;
    final workingHours = profileData?.workingHours;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileHeader(
            title: pharmacyName,
            location: location,
            openNow: isOpen,
            deliveryAvailable: isDeliveryAvailable,
            onEditTap: profileData != null
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: _cubit,
                          child: EditPharmacyProfilePage(
                              profileData: profileData),
                        ),
                      ),
                    ).then((updated) {
                      if (updated == true) {
                        _cubit.getPharmacyProfile();
                      }
                    });
                  }
                : null,
          ),
          SizedBox(height: 24.h),

          // Quick Info Cards
          if (profileData?.stats != null) ...[
            ProfileQuickInfoCards(
              rating: profileData!.stats!.rating,
              totalOrders: profileData.stats!.totalOrders,
              totalMedicines: profileData.stats!.totalMedicines,
              deliveryTime: profileData.deliveryTime,
            ),
            SizedBox(height: 16.h),
          ],

          // About Section
          if (about != null && about.isNotEmpty) ...[
            AboutPharmacySection(about: about),
          ],

          // Addresses
          if (addresses != null && addresses.isNotEmpty) ...[
            AddressesSection(addresses: addresses),
          ],

          // Working Hours
          if (workingHours != null && workingHours.isNotEmpty) ...[
            WorkingHoursSection(workingHours: workingHours),
          ],

          // Settings & Policies
          OperatingSettingsSection(profileData: profileData),

          // Delivery Section
          DeliverySection(profileData: profileData),

          // Payment Methods
          PaymentMethodsSection(profileData: profileData),

          // Verification License
          VerificationLicenseSection(profileData: profileData),

          SizedBox(height: 24.h),

          // Action Buttons
          ProfileActionButton(
            icon: Icons.person_rounded,
            title: "Edit Profile",
            baseColor: Colors.blue.shade600,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: _cubit,
                    child: EditPharmacyProfilePage(profileData: profileData),
                  ),
                ),
              ).then((updated) {
                if (updated == true) {
                  _cubit.getPharmacyProfile();
                }
              });
            },
          ),
          ProfileActionButton(
            icon: Icons.settings_rounded,
            title: "Pharmacy Settings",
            baseColor: Colors.indigo.shade600,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PharmacySettingsPage(),
                ),
              ).then((_) {
                _cubit.getPharmacyProfile();
              });
            },
          ),

          SizedBox(height: 32.h),

          // Logout Button
          const Center(child: LogOutBtn()),
          SizedBox(height: 60.h),
        ],
      ),
    );
  }
}
