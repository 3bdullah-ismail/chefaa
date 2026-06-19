import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/presentation/patient/order/presentation/widgets/confirm_order_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/widget/inside_app_bar.dart';
import '../widgets/delivered_done_bottom_sheet.dart';
import '../widgets/order_content_card.dart';
import '../widgets/order_timeline_stepper.dart';
import '../widgets/driver_info_card.dart';
import '../widgets/live_status_card.dart';
import '../widgets/order_info_card.dart';

class TrackOrderPage extends StatelessWidget {
  const TrackOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: InsideAppBar(
          title: "Track Order",
          subtitle: "Live updates & delivery progress",
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: AppPadding.p20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const LiveStatusCard(),
                    const SizedBox(height: 16),
                    const OrderInfoCard(),
                    const SizedBox(height: 16),
                    const DriverInfoCard(),
                    const SizedBox(height: 16),
                    const OrderTimelineStepper(),
                    const SizedBox(height: 16),

                    const OrderContentCard(),
                    const SizedBox(height: 24),

                    ConfirmOrderButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: ColorManager.white,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(28),
                            ),
                          ),
                          builder: (_) => const DeliveredDoneBottomSheet(),
                        );
                      },
                    ),
                    30.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
