import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/widgets/custom_text_field.dart';

import 'package:chefaa/features/patient/search/presentation/manager/search_cubit.dart';

class CustomSearchBar extends StatelessWidget {
  final String text;
  const CustomSearchBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return CustomTextField(
      prefixIcon: IconsAssets.searchIcon,
      isSearch: true,
      controller: cubit.searchController,
      text: text,
      textInputAction: TextInputAction.search,
      onChanged: (value) {
        cubit.setSearchText(value);
      },
      onPressSearch: () => cubit.applySearch(),
    );
  }
}
