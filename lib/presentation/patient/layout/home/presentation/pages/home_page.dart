import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/routes/app_routes_names.dart';
import 'package:chefaa/core/widget/custom_text_field.dart';
import 'package:chefaa/presentation/patient/layout/home/presentation/widgets/ai_suggestion.dart';
import 'package:chefaa/presentation/patient/layout/home/presentation/widgets/search_filters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chefaa/presentation/patient/layout/home/presentation/widgets/quick_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../../../../../../core/widget/custom_app_bar.dart';
import '../../../search/presentation/manager/search_cubit.dart';
import '../../../search/presentation/pages/search_page.dart';
import '../manager/users_cubit.dart';
import '../manager/users_state.dart';
import '../widgets/appointment_card.dart';
import '../widgets/medicine_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

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

            if (state is UserLoaded) {
              userName = state.user.name;
            } else if (state is UsersLoading) {
              userName = "...";
            }

            return CustomAppBar(
              isLayout: true,
              title1: "Good Morning !",
              title2: userName,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p32,
                horizontal: AppPadding.p28,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    isSearch: true,
                    rec: true,
                    controller: _searchController,
                    text: "Search Doctor or specialty ",
                    prefixIcon: "assets/icons/search-normal.svg",
                    onPressSearch: () {
                      final cubit = context.read<SearchCubit>();

                      cubit.setSearchTextAndSearch(_searchController.text);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<SearchCubit>(),
                            child: const SearchPage(),
                          ),
                        ),
                      );
                    },
                  ),
                  22.verticalSpace,
                  const SearchFilters(),
                  30.verticalSpace,
                  const AiSuggestion(),
                  40.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Today’s Medication",
                          style: getBoldStyle(
                            color: ColorManager.black,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutesNames.medicationPage,
                          );
                        },

                        child: Row(
                          children: [
                            Text(
                              "Manage",
                              style:
                              getMediumStyle(
                                color: ColorManager.primary,
                                fontSize: 18,
                              ).copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: ColorManager.primary,
                                decorationThickness: 2,
                              ),
                            ),
                            SvgPicture.asset("assets/icons/drug.svg"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  15.verticalSpace,
                  const MedicineCard(),
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
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutesNames.appointmentPage,
                          );
                        },
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
                                decorationThickness: 2,
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
    );
  }
}