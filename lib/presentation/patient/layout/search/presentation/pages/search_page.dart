import 'package:chefaa/core/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/resources/values_manager.dart';
import '../../../../../../../core/widget/custom_text_field.dart';
import '../../../home/presentation/widgets/appointment_card.dart';
import '../manager/search_cubit.dart';
import '../manager/search_state.dart';
import '../widgets/search_card.dart';
import '../widgets/speciality_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final cubit = context.read<SearchCubit>();
    _searchController.text = cubit.draftQuery.searchText;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomAppBar(isSearch: true, isLayout: true, title1: "Search"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p10,
            vertical: AppPadding.p28,
          ),
          child: Column(
            children: [
              CustomTextField(
                isSearch: true,
                rec: true,
                controller: _searchController,
                text: "Search Doctor or specialty",
                prefixIcon: "assets/icons/search-normal.svg",

                onChanged: (value) {
                  cubit.setSearchText(value);
                },
                onPressSearch: () {
                  cubit.setSearchText(_searchController.text);
                  cubit.applySearch();
                },
              ),

              const SizedBox(height: 10),

              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is SearchError) {
                      return Center(child: Text(state.message));
                    }

                    if (state is SearchSuccess) {
                      if (state.clinics.isEmpty) {
                        return const Center(child: Text("No results found"));
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.all(10),
                        itemCount: state.clinics.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 15),
                        itemBuilder: (_, index) {
                          return SearchCard(clinic: state.clinics[index]);
                        },
                      );
                    }

                    return const Center(child: Text("Start typing to search"));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
