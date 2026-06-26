import 'package:chefaa/presentation/patient/search/presentation/widgets/search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/values_manager.dart';
import '../manager/search_cubit.dart';
import '../widgets/filter_bar.dart';
import '../widgets/results_list.dart';
import '../widgets/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: SearchAppBar(title: 'Search'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p10,
            vertical: AppPadding.p28,
          ),
          child: Column(
            children: [
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
