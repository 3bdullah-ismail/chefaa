import 'package:chefaa/presentation/doctor/layout/home/presentation/widgets/empty_clinic_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/config/get_config.dart';
import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/values_manager.dart';
import '../../../../../../core/routes/app_routes_names.dart';
import '../../../../../../core/widget/inside_app_bar.dart';
import '../../../../../patient/layout/home/presentation/manager/users_cubit.dart';
import '../manager/clinic_cubit.dart';
import '../manager/clinic_state.dart';
import '../widgets/clinic_bottom_sheet.dart';
import '../widgets/clinic_card.dart';
import '../widgets/custom_outline_button.dart';

class ClinicsPage extends StatelessWidget {
  const ClinicsPage({super.key});

  void _openAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.lightGray,
      isScrollControlled: true,
      builder: (_) => const FractionallySizedBox(
        heightFactor: 0.92,
        child: ClinicBottomSheet(
          title: "Add Clinic",
          content: "Enter your clinic details for tracking.",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userState = context.read<UsersCubit>().state;
    final doctorID = userState is UserLoaded ? userState.user.id : "";

    return BlocProvider(
      create: (_) => getIt<ClinicCubit>()..getClinics(doctorID: doctorID),
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: InsideAppBar(title: "My Clinics"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p28,
            vertical: AppPadding.p20,
          ),
          child: BlocBuilder<ClinicCubit, ClinicState>(
            builder: (context, state) {
              final bool isLoadedWithClinics =
                  state is ClinicsSuccessState && state.clinics.isNotEmpty;

              return Column(
                children: [
                  if (isLoadedWithClinics)
                    CustomOutlineButton(
                      text: "Add Clinic",
                      onPressed: () => _openAddSheet(context),
                    ),

                  if (isLoadedWithClinics) 20.verticalSpace,

                  Expanded(child: _buildContent(context, state)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ClinicState state) {
    if (state is ClinicLoadingState) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ClinicErrorState) {
      return Center(child: Text(state.message));
    }

    if (state is ClinicsSuccessState) {
      if (state.clinics.isEmpty) {
        return const EmptyClinicsState();
      }

      return ListView.separated(
        itemCount: state.clinics.length,
        separatorBuilder: (_, _) => const SizedBox(height: 15),
        itemBuilder: (_, index) {
          final clinic = state.clinics[index];
          return ClinicCard(
            clinic: clinic,
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutesNames.clinicsDetailsPage,
                arguments: clinic,
              );
            },
          );
        },
      );
    }

    return const Center(child: CircularProgressIndicator());
  }
}
