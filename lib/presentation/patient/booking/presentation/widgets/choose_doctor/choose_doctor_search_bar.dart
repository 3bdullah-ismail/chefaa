import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/choose_doctor_cubit.dart';

class ChooseDoctorSearchBar extends StatelessWidget {
  const ChooseDoctorSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChooseDoctorCubit>();

    return CustomTextField(
      prefixIcon: IconsAssets.searchIcon,
      isSearch: true,
      controller: cubit.searchController,
      text: 'Search Doctor or specialty',
      textInputAction: TextInputAction.search,
      onChanged: cubit.setSearchText,
      onPressSearch: () => cubit.setSearchText(cubit.searchController.text),
    );
  }
}

