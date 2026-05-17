import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/resources/assets_manager.dart';
import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../../../../../../core/resources/values_manager.dart';
import '../../../../../../core/routes/app_routes_names.dart';
import '../../../../../../core/widget/custom_app_bar.dart';
import '../../../../../../core/widget/custom_text_field.dart';
import '../../../../search/presentation/manager/search_cubit.dart';
import '../../../../search/presentation/pages/search_page.dart';
import '../../patient_medication/presentation/manager/medication_cubit.dart';
import '../../patient_medication/presentation/manager/medication_state.dart';
import '../manager/users_cubit.dart';
import '../widgets/ai_suggestion.dart';
import '../widgets/appointment_card.dart';
import '../widgets/empty_medication_state.dart';
import '../widgets/medicine_card.dart';
import '../widgets/quick_actions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<MedicineCardState> _medicineCardKey =
  GlobalKey<MedicineCardState>();

  void _openSearchPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            BlocProvider.value(
              value: context.read<SearchCubit>(),
              child: const SearchPage(),
            ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(175),
        child: BlocBuilder<UsersCubit, UsersState>(
          builder: (context, state) {
            String userName = "Patient";
            if (state is UserLoaded) userName = state.user.name;
            if (state is UsersLoading) userName = "...";

            return  CustomAppBar(
              child: Text(""),
            );
          },
        ),
      ),
      body: BlocListener<MedicationCubit, MedicationState>(
        listener: (context, state) {
          if (state is MedicationConfirmSuccessState) {
            _medicineCardKey.currentState?.updateConfirmed(
              state.confirmMedication,
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p32,
                  horizontal: AppPadding.p20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: _openSearchPage,
                        child: IgnorePointer(
                          child: CustomTextField(
                            isSearch: true,
                            rec: true,
                            controller: _searchController,
                            text: "Search Doctor or specialty ",
                            prefixIcon: "assets/icons/search-normal.svg",
                          ),
                        ),
                      ),
                    ),

                    50.verticalSpace,
                    const AiSuggestion(),
                    40.verticalSpace,

                    BlocBuilder<MedicationCubit, MedicationState>(
                      buildWhen: (previous, current) =>
                      current is MedicationListLoadingState ||
                          current is MedicationListSuccessState ||
                          current is MedicationListErrorState,
                      builder: (context, state) {
                        if (state is MedicationListLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: ColorManager.primary,
                            ),
                          );
                        }

                        if (state is MedicationListErrorState) {
                          return Center(
                            child: Text(
                              state.errorMessage,
                              style: getMediumStyle(color: ColorManager.error),
                            ),
                          );
                        }

                        if (state is MedicationListSuccessState) {
                          final medications =
                              state.medications.medications ?? [];

                          return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Today's Medication",
                                      style: getBoldStyle(
                                        color: ColorManager.black,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                  if (medications.isNotEmpty)
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pushNamed(
                                            context,
                                            AppRoutesNames.medicationPage,
                                          ),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Manage",
                                            style:
                                            getMediumStyle(
                                              color: ColorManager.primary,
                                              fontSize: 18,
                                            ).copyWith(
                                              decoration:
                                              TextDecoration.underline,
                                              decorationColor:
                                              ColorManager.primary,
                                              decorationThickness: 2,
                                            ),
                                          ),
                                          SvgPicture.asset(
                                            "assets/icons/drug.svg",
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              15.verticalSpace,
                              if (medications.isEmpty)
                                const EmptyMedicationState()
                              else
                                MedicineCard(
                                  key: _medicineCardKey,
                                  medications: medications,
                                  onPressed: (med) {
                                    context
                                        .read<MedicationCubit>()
                                        .confirmMedication(med.id ?? '');
                                  },
                                ),
                            ],
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),

                    45.verticalSpace,
                    const AiSuggestion(),
                    40.verticalSpace,

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Upcoming Appointment",
                            style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(
                                context,
                                AppRoutesNames.appointmentPage,
                              ),
                          child: Row(
                            children: [
                              Text(
                                "ViewAll",
                                style:
                                getMediumStyle(
                                  color: ColorManager.primary,
                                  fontSize: 18,
                                ).copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: ColorManager.primary,
                                ),
                              ),
                              SvgPicture.asset("assets/icons/drug.svg"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    const DoctorCard(),
                    50.verticalSpace,
                    Text(
                      "Quick Actions ",
                      style: getSemiBoldStyle(
                        color: ColorManager.black,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: QuickActions(
                        title: "Emergency",
                        image: SvgAssets.phone,
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: QuickActions(
                        title: "Order Pharmacy",
                        image: SvgAssets.orderPharmacy,
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: QuickActions(
                        title: "Appointments",
                        image: SvgAssets.appointment,
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: QuickActions(
                        title: "Find Lab",
                        image: SvgAssets.findLab,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
