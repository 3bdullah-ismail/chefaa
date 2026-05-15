import 'package:chefaa/presentation/doctor/layout/home/presentation/widgets/empty_clinic_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../../../../../../core/resources/values_manager.dart';
import '../../../../../../core/routes/app_routes_names.dart';
import '../../../../../../core/widget/custom_app_bar.dart';
import '../../../../../patient/layout/home/presentation/manager/users_cubit.dart';
import '../manager/clinic_cubit.dart';
import '../manager/clinic_state.dart';
import '../widgets/clinic_card.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(170),
        child: BlocBuilder<UsersCubit, UsersState>(
          builder: (context, state) {
            if (state is UserLoaded) {
              context.read<ClinicCubit>().getClinics(doctorID: state.user.id);
            }

            return CustomAppBar(
              isLayout: true,
              title1: "Good Morning !",
              title2: state is UserLoaded ? state.user.name : "Doctor",
            );
          },
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20,
            vertical: AppPadding.p32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,

              BlocBuilder<ClinicCubit, ClinicState>(
                builder: (context, state) {
                  final isEmpty =
                      state is ClinicsSuccessState && state.clinics.isEmpty;

                  return Row(
                    children: [
                      Text(
                        "My Clinics",
                        style: getBoldStyle(
                          color: ColorManager.black,
                          fontSize: 22,
                        ),
                      ),
                      const Spacer(),

                      if (state is ClinicsSuccessState && !isEmpty)
                        TextButton(
                          style: TextButton.styleFrom(
                            overlayColor: ColorManager.transparent,
                          ),
                          onPressed: () => Navigator.pushNamed(
                            context,
                            AppRoutesNames.clinicsPage,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "View All",
                                style: getBoldStyle(
                                  color: ColorManager.primary,
                                  fontSize: 18,
                                ),
                              ),
                              7.horizontalSpace,
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: ColorManager.primary,
                                size: 17,
                              ),
                            ],
                          ),
                        ),


                    ],
                  );
                },
              ),

              10.verticalSpace,
              BlocBuilder<ClinicCubit, ClinicState>(
                builder: (context, state) {
                  if (state is ClinicLoadingState) {
                    return const Center(child: CircularProgressIndicator(
                      color: ColorManager.primary,
                    ));
                  }

                  if (state is ClinicErrorState) {
                    return Center(child: Text(state.message));
                  }

                  if (state is ClinicsSuccessState) {
                    final clinics = state.clinics;

                    if (clinics.isEmpty) {
                      return const EmptyClinicsState();
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: clinics.length > 2 ? 2 : clinics.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 15),
                      itemBuilder: (_, index) {
                        final clinic = clinics[index];
                        return ClinicCard(
                          clinic: clinic,
                          onPressed: () => Navigator.pushNamed(
                            context,
                            AppRoutesNames.clinicsDetailsPage,
                            arguments: clinic,
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
