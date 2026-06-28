import 'package:chefaa/core/config/get_config.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/widgets/inside_app_bar.dart';
import 'package:chefaa/core/widgets/loading.dart';
import 'package:chefaa/features/patient/order/presentation/manager/track_order_cubit.dart';
import 'package:chefaa/features/patient/order/presentation/widgets/confirm_order_button.dart';
import 'package:chefaa/features/patient/order/presentation/widgets/delivered_done_bottom_sheet.dart';
import 'package:chefaa/features/patient/order/presentation/widgets/driver_info_card.dart';
import 'package:chefaa/features/patient/order/presentation/widgets/live_status_card.dart';
import 'package:chefaa/features/patient/order/presentation/widgets/order_content_card.dart';
import 'package:chefaa/features/patient/order/presentation/widgets/order_info_card.dart';
import 'package:chefaa/features/patient/order/presentation/widgets/order_timeline_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackOrderPage extends StatefulWidget {
  final String? orderId;

  const TrackOrderPage({super.key, this.orderId});

  @override
  State<TrackOrderPage> createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  String? _orderId;
  List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    _orderId = widget.orderId;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_orderId == null) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is String) {
        _orderId = args;
      } else if (args is Map<String, dynamic>) {
        _orderId = args['orderId'] as String?;
      }
    }
    _orderId ??= "6a3eed29ad07c9d4a1a05d38";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TrackOrderCubit>(
      create: (context) => getIt<TrackOrderCubit>()..getOrderTracking(_orderId!),
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: InsideAppBar(
            title: "Track Order",
            subtitle: "Live updates & delivery progress",
          ),
        ),
        body: BlocConsumer<TrackOrderCubit, TrackOrderState>(
          listener: (context, state) {
            if (state is ConfirmReceiptLoading) {
              Loading.show(context);
            } else if (state is ConfirmReceiptFailure) {
              Loading.hide(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: ColorManager.error,
                ),
              );
            } else if (state is ConfirmReceiptSuccess) {
              Loading.hide(context);
              // Refresh order tracking data to reflect updated status
              context.read<TrackOrderCubit>().getOrderTracking(_orderId!);
              showModalBottomSheet(
                context: context,
                backgroundColor: ColorManager.white,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                ),
                builder: (_) => DeliveredDoneBottomSheet(items: _items),
              );
            }
          },
          buildWhen: (previous, current) {
            return current is TrackOrderLoading ||
                current is TrackOrderSuccess ||
                current is TrackOrderFailure;
          },
          builder: (context, state) {
            if (state is TrackOrderLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorManager.primary,
                ),
              );
            } else if (state is TrackOrderFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: TextStyle(
                        color: ColorManager.error,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    16.verticalSpace,
                    ElevatedButton(
                      onPressed: () {
                        context.read<TrackOrderCubit>().getOrderTracking(_orderId!);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primary,
                        foregroundColor: ColorManager.white,
                      ),
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            } else if (state is TrackOrderSuccess) {
              final orderData = state.response.data;
              if (orderData == null) {
                return Center(
                  child: Text(
                    "No order details found",
                    style: TextStyle(
                      color: ColorManager.gray,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }

              // Update the items cache for DeliveredDoneBottomSheet
              _items = (orderData.orderContents?.items ?? []).map((item) => {
                'name': item.medicineName,
                'quantity': item.quantity,
              }).toList();

              // Determine details for live status card — show the latest completed step
              String liveStatusTitle = orderData.orderStatus;
              String liveStatusDesc = "Your order status is updated.";
              String? liveStatusTime;

              final timeline = orderData.statusTimeline;
              if (timeline != null) {
                if (timeline.onTheWay?.isCompleted == true) {
                  liveStatusTitle = timeline.onTheWay?.title ?? "On The Way";
                  liveStatusDesc = timeline.onTheWay?.description ?? "";
                  liveStatusTime = timeline.onTheWay?.time;
                } else if (timeline.riderPickedUp?.isCompleted == true) {
                  liveStatusTitle = timeline.riderPickedUp?.title ?? "Picked Up";
                  liveStatusDesc = timeline.riderPickedUp?.description ?? "";
                  liveStatusTime = timeline.riderPickedUp?.time;
                } else if (timeline.pharmacyPreparing?.isCompleted == true) {
                  liveStatusTitle = timeline.pharmacyPreparing?.title ?? "Preparing";
                  liveStatusDesc = timeline.pharmacyPreparing?.description ?? "";
                  liveStatusTime = timeline.pharmacyPreparing?.time;
                } else if (timeline.orderConfirmed?.isCompleted == true) {
                  liveStatusTitle = timeline.orderConfirmed?.title ?? "Order Confirmed";
                  liveStatusDesc = timeline.orderConfirmed?.description ?? "";
                  liveStatusTime = timeline.orderConfirmed?.time;
                }
              }

              final confirmedTime = timeline?.orderConfirmed?.time ?? "Today";

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(top: AppPadding.p20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            LiveStatusCard(
                              status: liveStatusTitle,
                              description: liveStatusDesc,
                              time: liveStatusTime,
                            ),
                            const SizedBox(height: 16),
                            OrderInfoCard(
                              orderNumber: orderData.orderNumber,
                              itemsCount: orderData.orderContents?.items.length ?? 0,
                              placedTime: confirmedTime,
                              paymentMethod: orderData.orderContents?.summary?.paymentMethod ?? "Cash",
                            ),
                            const SizedBox(height: 16),
                            if (orderData.riderInfo != null) ...[
                              DriverInfoCard(rider: orderData.riderInfo!),
                              const SizedBox(height: 16),
                            ],
                            if (timeline != null) ...[
                              OrderTimelineStepper(timeline: timeline),
                              const SizedBox(height: 16),
                            ],
                            if (orderData.orderContents != null)
                              OrderContentCard(contents: orderData.orderContents!),
                            const SizedBox(height: 24),
                            ConfirmOrderButton(
                              onPressed: () {
                                context.read<TrackOrderCubit>().confirmOrderReceipt(_orderId!);
                              },
                            ),
                            30.verticalSpace,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
