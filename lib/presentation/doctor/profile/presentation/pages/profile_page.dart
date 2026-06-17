import 'package:chefaa/presentation/patient/home/presentation/manager/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/config/get_config.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../patient/profile/presentation/pages/profile_page.dart';
import '../../domain/entities/doctor_profile_entity.dart';
import '../manager/doctor_profile_cubit.dart';
import '../widgets/about_card.dart';
import '../widgets/contact_cards.dart';
import '../widgets/degrees_chips.dart';
import '../widgets/hero_section.dart';
import '../widgets/incomplete_profile_state.dart';
import '../widgets/quick_stats_row.dart';
import '../widgets/section_title.dart';
import 'edit_profile_page.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DoctorProfileCubit>()..getDoctorData(),
      child: Scaffold(
        body: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
          builder: (context, state) {
            String userName = 'Doctor';
            try {
              final usersCubitState = context.read<UsersCubit>().state;
              if (usersCubitState is UserLoaded) {
                userName = usersCubitState.user.name;
              }
            } catch (_) {
              userName = 'Doctor';
            }

            if (state is GetDoctorDataErrorState) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(AppPadding.p24.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: AppSize.s56.r,
                        color: ColorManager.error,
                      ),
                      AppSize.s16.verticalSpace,
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                          color: ColorManager.darkGray,
                          fontSize: FontSize.s14.sp,
                        ),
                      ),
                      AppSize.s16.verticalSpace,
                      ElevatedButton(
                        onPressed: () =>
                            context.read<DoctorProfileCubit>().getDoctorData(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          foregroundColor: ColorManager.white,
                        ),
                        child: const Text('Try again'),
                      ),
                    ],
                  ),
                ),
              );
            }
            final doctor =
                resolveDoctor(state, context) ?? _placeholderDoctor(userName);

            final completed = doctor.isProfileCompleted();

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: HeroSection(doctor: doctor)),
                SliverToBoxAdapter(child: QuickStatsRow(doctor: doctor)),

                if (!completed)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        AppPadding.p16.w,
                        AppSize.s0,
                        AppPadding.p16.w,
                        AppPadding.p16.h,
                      ),
                      child: IncompleteProfileState(
                        missingFields: doctor.getMissingRequiredFields(),
                        onCompleteProfile: () =>
                            openEditProfile(context, doctor),
                      ),
                    ),
                  ),
                const SliverToBoxAdapter(
                  child: SectionTitle(title: 'About Doctor'),
                ),
                SliverToBoxAdapter(child: AboutCard(doctor: doctor)),
                const SliverToBoxAdapter(
                  child: SectionTitle(title: 'Degrees & Certifications'),
                ),
                SliverToBoxAdapter(child: DegreesChips(doctor: doctor)),

                const SliverToBoxAdapter(
                  child: SectionTitle(title: 'Direct Contact'),
                ),
                SliverToBoxAdapter(child: ContactCards(doctor: doctor)),

                const SliverToBoxAdapter(
                  child: SectionTitle(title: 'Account Settings'),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
                    child: GestureDetector(
                      onTap: () => openEditProfile(context, doctor),
                      child: Container(
                        padding: EdgeInsets.all(AppPadding.p16.w),
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(AppRadius.r18.r),
                          border: Border.all(color: ColorManager.input),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(AppPadding.p10.r),
                                  decoration: BoxDecoration(
                                    color: ColorManager.primary.withValues(
                                      alpha: 0.10,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.edit_outlined,
                                    color: ColorManager.primary,
                                    size: AppSize.s20.r,
                                  ),
                                ),
                                AppSize.s14.horizontalSpace,
                                Text(
                                  "Edit Profile",
                                  style: getBoldStyle(
                                    color: ColorManager.black,
                                    fontSize: FontSize.s14.sp,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: ColorManager.gray,
                              size: AppSize.s18.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      AppSize.s24.verticalSpace,
                      const VersionContainer(),
                      AppSize.s16.verticalSpace,
                      const LogOutBtn(),
                      AppSize.s16.verticalSpace,
                      const DeleteAccount(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

DoctorProfileEntity? resolveDoctor(
  DoctorProfileState state,
  BuildContext context,
) {
  if (state is GetDoctorDataSuccessState) return state.doctorProfileEntity;
  if (state is UpdateDoctorDataSuccessState) return state.doctorProfileEntity;
  return context.read<DoctorProfileCubit>().currentDoctor;
}

void openEditProfile(BuildContext context, DoctorProfileEntity doctor) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: context.read<DoctorProfileCubit>(),
        child: EditProfilePage(doctorData: doctor),
      ),
    ),
  ).then((_) {
    try {
      if (context.mounted) {
        context.read<DoctorProfileCubit>().getDoctorData();
      }
    } catch (_) {}
  });
}

DoctorProfileEntity _placeholderDoctor(String userName) {
  return DoctorProfileEntity(
    name: userName,
    specialization: 'Specialization',
    location: 'Location',
    imageUrl: '',
    clinics: 0,
    rating: 0,
    reviews: 0,
    yearsOfExperience: 0,
    about: null,
    age: null,
    paymentOption: null,
    gender: null,
    contactNumber: null,
    degrees: null,
    prePaymentNumbers: null,
    clinicConsultationPrice: null,
  );
}
