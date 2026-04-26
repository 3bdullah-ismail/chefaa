import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/search_cubit.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return CustomTextField(
      prefixIcon: IconsAssets.searchIcon,
      isSearch: true,
      controller: cubit.searchController,
      text: 'Search Doctor or specialty',
      textInputAction: TextInputAction.search,
      onChanged: (value) {
        cubit.setSearchText(value);
      },
      onPressSearch: () => cubit.applySearch(),
    );
  }
}
