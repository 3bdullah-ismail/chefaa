import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/features/patient/search/presentation/manager/search_cubit.dart';
import 'package:chefaa/features/patient/search/presentation/widgets/filter_bar.dart';
import 'package:chefaa/features/patient/search/presentation/widgets/results_list.dart';
import 'package:chefaa/features/patient/search/presentation/widgets/search_bar.dart';
import 'package:chefaa/features/patient/booking/presentation/widgets/sub_text.dart';
import 'package:chefaa/features/patient/booking/presentation/widgets/title_text.dart';

class ChooseDoctor extends StatefulWidget {
  const ChooseDoctor({super.key});

  @override
  State<ChooseDoctor> createState() => _ChooseDoctorState();
}

class _ChooseDoctorState extends State<ChooseDoctor> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final cubit = context.read<SearchCubit>();
      cubit.clearFilters();
      cubit.applySearch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleText(text: 'Choose Doctor'),
              4.verticalSpace,
              const SubText(text: 'Select your healthcare provider.'),
              16.verticalSpace,
              const CustomSearchBar(text: "Search Doctor or Specialty"),
              16.verticalSpace,
              const FilterBar(),
              16.verticalSpace,
              const Expanded(child: ResultsList()),
            ],
          ),
        ),
      ),
    );
  }
}
