import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/search_cubit.dart';
import 'search_card.dart';

class ResultsList extends StatelessWidget {
  const ResultsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) =>
          current is SearchLoading ||
          current is SearchSuccess ||
          current is SearchError,
      builder: (context, state) {
        final cubit = context.read<SearchCubit>();

        if (state is SearchLoading && cubit.lastClinics.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SearchError && cubit.lastClinics.isEmpty) {
          return Center(child: Text(state.message));
        }

        final clinics = state is SearchSuccess
            ? state.clinics
            : cubit.lastClinics;

        final isRefreshing = (state is SearchLoading && clinics.isNotEmpty) ||
            (state is SearchSuccess && state.isRefreshing);

        if (clinics.isEmpty) {
          return const Center(child: Text('No doctors found'));
        }

        return Column(
          children: [
            if (isRefreshing)
              const LinearProgressIndicator(minHeight: 2),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: clinics.length,
                separatorBuilder: (_, _) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return SearchCard(doctorModel: clinics[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
