import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/values_manager.dart';
import '../../patient_medication/data/models/Confirm_medication.dart';
import '../../patient_medication/data/models/Medications.dart';
import 'elevate_button.dart';

class MedicineCard extends StatefulWidget {
  final List<Medications> medications;
  final Function(Medications medication) onPressed;

  const MedicineCard({
    super.key,
    required this.medications,
    required this.onPressed,
  });

  @override
  State<MedicineCard> createState() => MedicineCardState();
}

class MedicineCardState extends State<MedicineCard> {
  final Map<String, ConfirmMedication> _confirmed = {};

  void updateConfirmed(ConfirmMedication result) {
    final id = result.medication?.id;
    if (id == null) return;
    setState(() => _confirmed[id] = result);
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 80.h, maxHeight: 200.h),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
          color: ColorManager.lightGray,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(color: ColorManager.black.withAlpha(80), blurRadius: 10),
          ],
        ),
        child: RawScrollbar(
          controller: scrollController,
          thumbVisibility: true,
          thickness: 5,
          radius: const Radius.circular(10),
          trackVisibility: false,
          thumbColor: ColorManager.gray.withAlpha(80),
          minThumbLength: 30,
          child: ListView.separated(
            controller: scrollController,
            shrinkWrap: true,
            itemCount: widget.medications.length,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(right: AppPadding.p8),
            separatorBuilder: (_, _) => const Divider(),
            itemBuilder: (_, index) {
              final med = widget.medications[index];
              final confirmed = _confirmed[med.id ?? ''];

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          med.name?.isNotEmpty == true
                              ? med.name![0].toUpperCase() +
                                    med.name!.substring(1).toLowerCase()
                              : 'Medication Name',
                          style: getBoldStyle(
                            color: ColorManager.black,
                          ).copyWith(fontSize: 18),
                        ),
                        5.verticalSpace,
                        Text(
                          '${med.dosage} - ${med.schedule?.join(', ')}',
                          style: getMediumStyle(
                            color: ColorManager.gray,
                          ).copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  12.horizontalSpace,
                  confirmed != null
                      ? _ConfirmedStatus(confirmed: confirmed)
                      : _ConfirmActions(onConfirm: () => widget.onPressed(med)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ConfirmActions extends StatelessWidget {
  final VoidCallback onConfirm;

  const _ConfirmActions({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(AppPadding.p4),
          decoration: BoxDecoration(
            color: ColorManager.gray,
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: const Icon(
            Icons.access_time_rounded,
            color: ColorManager.white,
            size: 20,
          ),
        ),
        20.horizontalSpace,
        ElevateButton(text: 'Confirm', onPressed: onConfirm),
      ],
    );
  }
}

class _ConfirmedStatus extends StatelessWidget {
  final ConfirmMedication confirmed;

  const _ConfirmedStatus({required this.confirmed});

  @override
  Widget build(BuildContext context) {
    final status = confirmed.medication?.adherenceHistory?.isNotEmpty == true
        ? confirmed.medication!.adherenceHistory!.last.status ?? 'Taken'
        : 'Taken';

    final displayStatus = status.isNotEmpty
        ? status[0].toUpperCase() + status.substring(1).toLowerCase()
        : 'Taken';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_outlined, color: Colors.green, size: 22),
        8.horizontalSpace,
        Text(
          displayStatus,
          style: getMediumStyle(
            color: Colors.green.shade800,
          ).copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
