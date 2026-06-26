import 'package:chefaa/core/widget/inside_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../manager/patient_notification_cubit.dart';
import '../manager/patient_notification_state.dart';
import '../widgets/empty_notification.dart';
import '../widgets/notification_card.dart';

class PatientNotificationPage extends StatelessWidget {
  const PatientNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: InsideAppBar(title: "Notifications"),
      ),
      body: BlocBuilder<PatientNotificationCubit, PatientNotificationState>(
        builder: (context, state) {
          if (state is PatientNotificationLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PatientNotificationErrorState) {
            return Center(child: Text(state.errorMessage));
          }

          if (state is PatientNotificationSuccessState) {
            if (state.notification.isEmpty) {
              return const EmptyNotificationState();
            }

            return ListView.separated(
              padding: EdgeInsets.all(20.w),
              itemCount: state.notification.length,
              separatorBuilder: (_, _) => 12.verticalSpace,
              itemBuilder: (_, index) {
                final notification = state.notification[index];

                return NotificationCard(
                  icon: Icons.notifications_outlined,
                  title: notification.title ?? "",
                  body: notification.message ?? "",
                  isRead: notification.isRead ?? false,
                  type: notification.type ?? "",
                  onTap: () {
                    context.read<PatientNotificationCubit>().markAsRead(notification);
                  },
                  dateTime: DateTime.parse(notification.createdAt ?? ""),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
