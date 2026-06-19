import 'package:chefaa/core/resources/constants_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/widget/inside_app_bar.dart';
import 'package:chefaa/presentation/patient/search/presentation/widgets/speciality_card.dart';
import 'package:flutter/material.dart';

class SpecialityPage extends StatelessWidget {
  const SpecialityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(AppSize.s100),
        child: InsideAppBar(title: "Doctor Speciality", isSpeciality: true),
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(AppPadding.p24),
          itemCount: AppConstants.specialityItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: AppSize.s8,
            mainAxisSpacing: AppSize.s3,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (BuildContext context, int index) {
            final item = AppConstants.specialityItems[index];

            return SpecialityCard(item: item);
          },
        ),
      ),
    );
  }
}
