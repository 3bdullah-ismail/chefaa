import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:chefaa/core/widget/custom_outline_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/values_manager.dart';
import '../../data/models/Data.dart';

class DoctorCard extends StatelessWidget {
  final bool isAppointments;
  final Function()? onViewPrescription;
  final AppointmentModel? appointment;
  final VoidCallback? onReschedule;
  final VoidCallback? onCancel;

  const DoctorCard({
    super.key,
    this.isAppointments = false,
    this.appointment,
    this.onReschedule,
    this.onCancel,
    this.onViewPrescription,
  });

  String get _clinicName {
    final name = appointment?.clinic?.name;
    return (name != null && name.isNotEmpty) ? name : 'Doctor';
  }

  String get _specialization {
    final spec = appointment?.doctor?.specialization;
    return (spec != null && spec.isNotEmpty) ? spec : '';
  }

  String get _dateTimeLabel {
    final date = appointment?.date;
    final time = appointment?.timeChosed;

    if (date == null) return '—';

    try {
      final parsed = DateTime.parse(date);
      final formatted = DateFormat('dd MMM yyyy').format(parsed);
      return (time != null && time.isNotEmpty)
          ? '$formatted – $time'
          : formatted;
    } catch (_) {
      return date;
    }
  }

  Color get _statusColor {
    switch ((appointment?.status ?? '').toLowerCase()) {
      case 'upcoming':
        return ColorManager.primary;
      case 'completed':
        return ColorManager.lightGreen;
      case 'cancelled':
        return ColorManager.error;
      default:
        return ColorManager.gray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 200.h),
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p16,
      ),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(80),
            blurRadius: isAppointments ? 1 : 10,
            offset: isAppointments ? const Offset(0, 3) : const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: const Icon(Icons.person, color: ColorManager.white),
              ),
              15.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _clinicName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: getMediumStyle(
                        color: ColorManager.black,
                        fontSize: 20,
                      ),
                    ),
                    7.verticalSpace,
                    if (_specialization.isNotEmpty)
                      Text(
                        _specialization,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getSemiBoldStyle(
                          color: ColorManager.gray,
                          fontSize: 16,
                        ),
                      ),
                  ],
                ),
              ),
              if (appointment?.status != null)
                Column(
                  children: [
                    if (appointment?.prescription != null)
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: TextButton(
                          onPressed: onViewPrescription,
                          child: Text(
                            'View Prescription',
                            style:
                                getMediumStyle(
                                  color: ColorManager.primary,
                                  fontSize: 14.sp,
                                ).copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: ColorManager.primary,
                                ),
                          ),
                        ),
                      ),

                    if (appointment?.status != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p8,
                          vertical: AppPadding.p4,
                        ),
                        decoration: BoxDecoration(
                          color: _statusColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          appointment!.status!,
                          style: getSemiBoldStyle(
                            color: _statusColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),

          10.verticalSpace,

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: ColorManager.gray,
                  size: 20.sp,
                ),
                12.horizontalSpace,
                Expanded(
                  child: Text(
                    _dateTimeLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getSemiBoldStyle(
                      color: ColorManager.gray,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (appointment?.clinic?.address != null &&
              appointment!.clinic!.address!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p8,
                vertical: AppPadding.p4,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: ColorManager.gray,
                    size: 18.sp,
                  ),
                  8.horizontalSpace,
                  Expanded(
                    child: Text(
                      appointment!.clinic!.address!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: getRegularStyle(
                        color: ColorManager.gray,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          if (appointment == null ||
              (appointment!.status ?? '').toLowerCase() == 'upcoming') ...[
            10.verticalSpace,
            Row(
              spacing: 3.w,
              children: [
                CustomOutlineBtn(
                  title: 'Cancel',
                  color: ColorManager.error,
                  onPressed: onCancel,
                ),
                CustomOutlineBtn(
                  title: 'Reschedule',
                  color: ColorManager.primary,
                  onPressed: onReschedule,
                ),
                CustomBtn(
                  text: 'Join Now',
                  onPressed: () {},
                  isSmall: true,
                  isDisabled: true,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
