import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chefaa/core/widgets/loading.dart';
import 'package:chefaa/features/patient/search/presentation/manager/search_cubit.dart';
import 'search_card.dart';

class ResultsList extends StatelessWidget {
  const ResultsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listenWhen: (previous, current) =>
          current is SearchLoading ||
          current is SearchSuccess ||
          current is SearchError,
      listener: (context, state) {
        if (state is SearchLoading &&
            context.read<SearchCubit>().lastClinics.isEmpty) {
          Loading.show(context);
        } else if (state is SearchSuccess || state is SearchError) {
          Loading.hide(context);
        }
      },
      buildWhen: (previous, current) =>
          current is SearchLoading ||
          current is SearchSuccess ||
          current is SearchError,
      builder: (context, state) {
        final cubit = context.read<SearchCubit>();

        if (state is SearchError && cubit.lastClinics.isEmpty) {
          return Center(child: Text(state.message));
        }

        final clinics = state is SearchSuccess
            ? state.clinics
            : cubit.lastClinics;

        final isRefreshing =
            (state is SearchLoading && clinics.isNotEmpty) ||
            (state is SearchSuccess && state.isRefreshing);

        if (clinics.isEmpty) {
          return const Center(child: Text('No doctors found'));
        }

        return Column(
          children: [
            if (isRefreshing)
              const LinearProgressIndicator(minHeight: AppSize.s2),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: clinics.length,
                separatorBuilder: (_, _) => const SizedBox(height: AppSize.s16),
                itemBuilder: (context, index) {
                  return SearchCard(clinicModel: clinics[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
