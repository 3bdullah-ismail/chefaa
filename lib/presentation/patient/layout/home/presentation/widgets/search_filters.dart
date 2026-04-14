import 'package:chefaa/core/routes/app_routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../../../../../../core/resources/assets_manager.dart';
import '../../../search/presentation/manager/search_cubit.dart';

class SearchFilters extends StatelessWidget {
  const SearchFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SearchCubit>();

    final filters = [
      FilterType.filters,
      FilterType.specialization,
      FilterType.gender,
      FilterType.location,
    ];

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];

          final isFilterChip = filter == FilterType.filters;
          final value = isFilterChip ? "" : cubit.getFilterValue(filter);

          final isSelected =
              filter != FilterType.filters && value.isNotEmpty;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              avatar: isFilterChip
                  ? SvgPicture.asset(
                SvgAssets.filter,
                width: 20,
                height: 20,
              )
                  : null,

              labelStyle: getMediumStyle(
                fontSize: 14,
                color: isFilterChip
                    ? ColorManager.gray
                    : (isSelected
                    ? ColorManager.white
                    : ColorManager.gray),
              ).copyWith(fontWeight: FontWeight.w700),

              side: BorderSide(
                color: isFilterChip
                    ? ColorManager.input
                    : (isSelected
                    ? ColorManager.lightBlue
                    : ColorManager.input),
              ),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              backgroundColor: ColorManager.lightGray,
              selectedColor: ColorManager.primary,
              showCheckmark: false,

              label: Text(
                _getFilterTitle(filter, cubit),
              ),

              selected: isSelected,

              onSelected: (selected) async {
                if (!selected) return;

                switch (filter) {
                  case FilterType.filters:
                    cubit.clearFilters();
                    cubit.applySearch();
                    break;
                    
                  case FilterType.specialization:
                    final result = await Navigator.pushNamed(
                      context,
                      AppRoutesNames.specialityPage,
                    );

                    if (result != null && result is String) {
                      cubit.updateAndSearch(specialization: result);
                    }
                    break;

                  case FilterType.gender:
                    _showGender(context);
                    break;

                  case FilterType.location:
                    _showLocation(context);
                    break;
                }
              },
            ),
          );
        },
      ),
    );
  }

  String _getFilterTitle(FilterType type, SearchCubit cubit) {
    switch (type) {
      case FilterType.filters:
        return "Filters";

      case FilterType.specialization:
        return cubit.draftQuery.specialization.isNotEmpty
            ? cubit.draftQuery.specialization
            : "Speciality";

      case FilterType.gender:
        return cubit.draftQuery.gender.isNotEmpty
            ? cubit.draftQuery.gender
            : "Gender";

      case FilterType.location:
        return cubit.draftQuery.location.isNotEmpty
            ? cubit.draftQuery.location
            : "Location";
    }
  }

  void _showGender(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _item("Male", () {
              cubit.updateAndSearch(gender: "male");
              Navigator.pop(context);
            }),
            _item("Female", () {
              cubit.updateAndSearch(gender: "female");
              Navigator.pop(context);
            }),
            _item("Any", () {
              cubit.updateAndSearch(gender: "");
              Navigator.pop(context);
            }),
          ],
        );
      },
    );
  }

  void _showLocation(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _item("Cairo", () {
              cubit.updateAndSearch(location: "Cairo");
              Navigator.pop(context);
            }),
            _item("Alexandria", () {
              cubit.updateAndSearch(location: "Alexandria");
              Navigator.pop(context);
            }),
            _item("Clear", () {
              cubit.updateAndSearch(location: "");
              Navigator.pop(context);
            }),
          ],
        );
      },
    );
  }

  Widget _item(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }
}