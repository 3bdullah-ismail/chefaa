import 'package:chefaa/core/widget/custom_text_field.dart';
import 'package:chefaa/presentation/patient/booking/presentation/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../widgets/doctor_data_sard.dart';
import '../widgets/sub_text.dart';

class ChooseDoctor extends StatefulWidget {
  const ChooseDoctor({super.key});

  @override
  State<ChooseDoctor> createState() => _ChooseDoctorState();
}

class _ChooseDoctorState extends State<ChooseDoctor> {
  final List<String> filters = [
    'All',
    'Cardiology',
    'Medicine',
    'Surgery',
    'Pediatrics',
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleText(text: "Choose Doctor"),
              4.verticalSpace,
              const SubText(text: "Select your healthcare provider."),
              16.verticalSpace,
              CustomTextField(
                prefixIcon: IconsAssets.searchIcon,
                isSearch: true,
                rec: true,
                controller: controller,
                onChanged: (value) {},
                text: "Search Doctor or specialty ",
              ),
              16.verticalSpace,
              const SmartFilterScreen(),
              16.verticalSpace,
              const DoctorDataCard(
                doctorName: 'DR. Ahmed Ali',
                spaciality: 'Internal Medicine Specialist',
                rating: '4.8',
                price: '145',
                ratingCount: '150',
              ),
              32.verticalSpace,
              const DoctorDataCard(
                doctorName: 'DR. Abdallah Zalabia',
                spaciality: 'Ophthalmology Specialist',
                rating: '4.9',
                price: '150',
                ratingCount: '1700',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum FilterType { navigation, menu }

class FilterItem {
  final String title;

  final FilterType type;

  const FilterItem({required this.title, required this.type});
}

class SmartFilterScreen extends StatefulWidget {
  const SmartFilterScreen({super.key});

  @override
  State<SmartFilterScreen> createState() => _SmartFilterScreenState();
}

class _SmartFilterScreenState extends State<SmartFilterScreen> {
  final List<FilterItem> filterTabs = const [
    FilterItem(title: 'Filters', type: FilterType.navigation),
    FilterItem(title: 'Specialty', type: FilterType.menu),
    FilterItem(title: 'Gender', type: FilterType.menu),
    FilterItem(title: 'Location', type: FilterType.navigation),
  ];

  Map<String, String> selectedValues = {};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: filterTabs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = filterTabs[index];
          final isSelected = selectedValues.containsKey(item.title);

          return Builder(
            builder: (chipContext) {
              return GestureDetector(
                onTap: () => _handleTap(item, chipContext),
                child: Container(
                  width: 100,
                  height: 25,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorManager.primary
                        : ColorManager.lightGray,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: isSelected ? Colors.blue : ColorManager.input,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      index == 0
                          ? Row(
                              children: [
                                SvgPicture.asset(
                                  SvgAssets.filter,
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 6),
                              ],
                            )
                          : const SizedBox(),

                      Text(
                        selectedValues[item.title] ?? item.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isSelected
                              ? ColorManager.white
                              : ColorManager.black,
                          fontWeight: FontWeight.w500,
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
  }

  void _handleTap(FilterItem item, BuildContext chipContext) {
    switch (item.title) {
      case 'Filters':
        print("Open full filters screen");
        break;

      case 'Gender':
        _showMenu(
          chipContext: chipContext,
          filterKey: item.title,
          options: ["Male", "Female"],
        );
        break;

      case 'Specialty':
        _showMenu(
          chipContext: chipContext,
          filterKey: item.title,
          options: ["Dentist", "Cardio", "Dermatology"],
        );
        break;

      case 'Location':
        print("Go to Location screen");
        break;
    }
  }

  void _showMenu({
    required BuildContext chipContext,
    required String filterKey,
    required List<String> options,
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
      items: options.map((value) {
        final isSelected = selectedValues[filterKey] == value;

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
      setState(() {
        selectedValues[filterKey] = selected;
      });

      print("$filterKey Selected: $selected");
    }
  }
}
