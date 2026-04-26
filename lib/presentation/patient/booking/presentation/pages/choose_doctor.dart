import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../search/presentation/manager/search_cubit.dart';
import '../../../search/presentation/widgets/filter_bar.dart';
import '../../../search/presentation/widgets/results_list.dart';
import '../../../search/presentation/widgets/search_bar.dart';
import '../widgets/sub_text.dart';
import '../widgets/title_text.dart';

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
              const CustomSearchBar(),
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
