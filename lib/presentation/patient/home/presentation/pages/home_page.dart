import 'package:chefaa/presentation/patient/appointment/presentation/widgets/appointment_card.dart';
import 'package:chefaa/presentation/patient/medication/presentation/manager/medication_cubit.dart';
import 'package:chefaa/presentation/patient/medication/presentation/manager/medication_state.dart';
import 'package:chefaa/presentation/patient/medication/presentation/widgets/empty_medication_state.dart';
import 'package:chefaa/presentation/patient/medication/presentation/widgets/medicine_card.dart';
import 'package:chefaa/presentation/patient/search/presentation/manager/search_cubit.dart';
import 'package:chefaa/presentation/patient/search/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/resources/assets_manager.dart';
import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../../../../../../core/resources/values_manager.dart';
import '../../../../../../core/routes/app_routes_names.dart';
import '../../../../../../core/widget/custom_text_field.dart';
import '../../../../../../core/widget/layout_app_bar.dart';
import '../../../medication/presentation/widgets/medication_error_widget.dart';
import '../manager/users_cubit.dart';
import '../widgets/ai_suggestion.dart';
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
        builder: (_) => BlocProvider.value(
          value: context.read<SearchCubit>(),
          child: const SearchPage(),
        ),
      ),
    );
  }

  // ميثود مركزية موحدة ومؤمنة للانتقال لصفحة تسجيل الدخول
  void _navigateToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutesNames.login,
      (route) => false,
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

            return CustomAppBarLayout(title1: "Hello", title2: userName);
          },
        ),
      ),
      body: BlocListener<MedicationCubit, MedicationState>(
        // 👇 جعل المستمع يراقب حالتي التأكيد والخطأ معاً لمنع تداخل الشاشات
        listenWhen: (previous, current) =>
            current is MedicationConfirmSuccessState ||
            current is MedicationListErrorState,
        listener: (context, state) {
          if (state is MedicationConfirmSuccessState) {
            _medicineCardKey.currentState?.updateConfirmed(
              state.confirmMedication,
            );
          }

          // 👇 إذا حدث خطأ غير مصرح به أثناء تصفح الصفحة، يتم إخراجه تلقائياً وفوراً
          if (state is MedicationListErrorState) {
            final error = state.errorMessage.toLowerCase();
            if (error.contains('unauthorized') ||
                error.contains('401') ||
                error.contains('token')) {
              _navigateToLogin(context);
            }
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
                          return MedicationErrorWidget(
                            rawError: state.errorMessage,
                            onRetry: () {
                              context
                                  .read<MedicationCubit>()
                                  .getMedicationList();
                            },
                            onSignInRedirect: () => _navigateToLogin(context),
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
                                        fontSize: 22.sp,
                                      ),
                                    ),
                                  ),
                                  if (medications.isNotEmpty)
                                    TextButton(
                                      onPressed: () => Navigator.pushNamed(
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
                                                  fontSize: 18.sp,
                                                ).copyWith(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor:
                                                      ColorManager.primary,
                                                  decorationThickness: 2,
                                                ),
                                          ),
                                          6.horizontalSpace,
                                          SvgPicture.asset(
                                            "assets/icons/drug.svg",
                                            width: 20.w,
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

                    // 💡 تم مسح الجزء المكرر والمغلق (Commented Code) لزيادة نظافة ومقروئية الملف
                    45.verticalSpace,
                    const AiSuggestion(), // ملحوظة: مكررة مرتين في واجهتك، يمكنك مراجعتها لاحقاً إن لم تكن مقصودة
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
                          onPressed: () => Navigator.pushNamed(
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
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutesNames.searchPharmacy,
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: QuickActions(
                        title: "Find Lab",
                        image: SvgAssets.findLab,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutesNames.findLabPage,
                        ),
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
