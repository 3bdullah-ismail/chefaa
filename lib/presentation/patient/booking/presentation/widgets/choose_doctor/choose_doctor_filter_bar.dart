import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/routes/app_routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/resources/values_manager.dart';
import '../../manager/choose_doctor_cubit.dart';
import '../../manager/choose_doctor_state.dart';

class ChooseDoctorFilterBar extends StatelessWidget {
  const ChooseDoctorFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChooseDoctorCubit>();

    return BlocBuilder<ChooseDoctorCubit, ChooseDoctorState>(
      builder: (context, state) {
        return SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
            itemCount: cubit.filterTabs.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final item = cubit.filterTabs[index];
              final isSelected = cubit.isSelected(item, state);
              final label = cubit.labelFor(item, state);

              return Builder(
                builder: (chipContext) {
                  return GestureDetector(
                    onTap: () => _handleTap(
                      context: context,
                      chipContext: chipContext,
                      item: item,
                      state: state,
                    ),
                    child: Container(
                      width: 100,
                      height: 25,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ColorManager.primary
                            : ColorManager.lightGray,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isSelected
                              ? ColorManager.primary
                              : ColorManager.input,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (index == 0)
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.p8,
                                    vertical: AppPadding.p2,
                                  ),
                                  child: SvgPicture.asset(
                                    SvgAssets.filter,
                                    width: 17,
                                    height: 18,
                                  ),
                                ),
                              ],
                            ),
                          Expanded(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(AppPadding.p4),
                                child: Text(
                                  label,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: isSelected
                                        ? ColorManager.white
                                        : ColorManager.gray,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _handleTap({
    required BuildContext context,
    required BuildContext chipContext,
    required DoctorFilterItem item,
    required ChooseDoctorState state,
  }) async {
    final cubit = context.read<ChooseDoctorCubit>();

    switch (item.title) {
      case 'Filters':
        if (cubit.hasActiveSelections(state)) {
          cubit.clearFilters();
        }
        break;
      case 'Gender':
        await _showGenderMenu(
          context: context,
          chipContext: chipContext,
          cubit: cubit,
        );
        break;
      case 'Specialty':
        final result = await Navigator.pushNamed(
          context,
          AppRoutesNames.specialityPage,
        );

        if (result is String && result.isNotEmpty) {
          cubit.setSpecialty(result);
        }
        break;
      case 'Location':
        final result = await Navigator.pushNamed(
          context,
          AppRoutesNames.locationFilter,
        );

        if (result is String && result.isNotEmpty) {
          cubit.setLocation(result);
        }
        break;
    }
  }

  Future<void> _showGenderMenu({
    required BuildContext context,
    required BuildContext chipContext,
    required ChooseDoctorCubit cubit,
  }) async {
    final renderObject = chipContext.findRenderObject();
    if (renderObject is! RenderBox) return;

    final position = renderObject.localToGlobal(Offset.zero);

    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + 45,
        position.dx,
        position.dy,
      ),
      color: ColorManager.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      items: ['Male', 'Female', 'Any'].map((value) {
        final isSelected = cubit.state.selectedGender == value;

        return PopupMenuItem<String>(
          value: value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value),
              if (isSelected) const Icon(Icons.check, color: Colors.blue),
            ],
          ),
        );
      }).toList(),
    );

    if (selected != null) {
      cubit.setGender(selected);
    }
  }
}
