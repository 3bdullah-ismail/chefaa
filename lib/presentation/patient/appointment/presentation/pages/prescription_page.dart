import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/widget/inside_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../data/models/Data.dart';

class PrescriptionPage extends StatelessWidget {
  final AppointmentModel appointment;

  const PrescriptionPage({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final prescription = appointment.prescription!;

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: InsideAppBar(title: "Prescription"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [ColorManager.primary, Color(0xff6BB8FF)],
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.black.withAlpha(80),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    height: 65.h,
                    width: 65.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 35,
                      color: ColorManager.primary,
                    ),
                  ),

                  SizedBox(width: 15.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment.doctor?.specialization ?? "General",
                          style: getBoldStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),

                        SizedBox(height: 10.h),
                        Text(
                          appointment.clinic?.name ?? "",
                          style: getRegularStyle(
                            color: ColorManager.white,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 25.h),

            _SectionTitle(title: "Diagnosis"),

            SizedBox(height: 12.h),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(18.w),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Text(
                prescription.diagnosis ?? "No Diagnosis",
                style: getMediumStyle(color: Colors.black87, fontSize: 15),
              ),
            ),

            SizedBox(height: 28.h),

            ///======================
            /// Medicines
            ///======================
            _SectionTitle(title: "Medicines"),

            SizedBox(height: 15.h),

            ...prescription.medicines.map(
              (medicine) => Container(
                margin: EdgeInsets.only(bottom: 16.h),
                padding: EdgeInsets.all(18.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.black.withAlpha(80),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      medicine.name ?? "Medicine",
                      style: getBoldStyle(color: Colors.black, fontSize: 17),
                    ),

                    SizedBox(height: 18.h),

                    _InfoRow(title: "Dosage", value: medicine.dosage ?? "-"),

                    SizedBox(height: 10.h),

                    _InfoRow(
                      title: "Frequency",
                      value: medicine.frequency ?? "-",
                    ),

                    SizedBox(height: 10.h),

                    _InfoRow(
                      title: "Duration",
                      value: medicine.duration ?? "-",
                    ),

                    if ((medicine.instructions ?? "").isNotEmpty) ...[
                      SizedBox(height: 10.h),

                      _InfoRow(
                        title: "Instructions",
                        value: medicine.instructions!,
                      ),
                    ],
                  ],
                ),
              ),
            ),

            SizedBox(height: 30.h),
            if (prescription.labTests.isNotEmpty) ...[
              _SectionTitle(title: "Lab Tests"),

              SizedBox(height: 12.h),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: prescription.labTests
                    .map(
                      (e) =>
                          Chip(backgroundColor: Colors.white, label: Text(e)),
                    )
                    .toList(),
              ),

              SizedBox(height: 25.h),
            ],

            if (prescription.imaging.isNotEmpty) ...[
              _SectionTitle(title: "Imaging"),

              SizedBox(height: 12.h),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: prescription.imaging
                    .map(
                      (e) =>
                          Chip(backgroundColor: Colors.white, label: Text(e)),
                    )
                    .toList(),
              ),

              SizedBox(height: 25.h),
            ],


            _SectionTitle(title: "Next Visit"),

            SizedBox(height: 12.h),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(18.w),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Text(
                _formatDate(prescription.nextVisit),
                style: getSemiBoldStyle(color: Colors.black, fontSize: 15),
              ),
            ),

            SizedBox(height: 25.h),

            _SectionTitle(title: "Doctor Notes"),

            SizedBox(height: 12.h),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(18.w),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Text(
                prescription.notes?.isNotEmpty == true
                    ? prescription.notes!
                    : "No Notes",
                style: getRegularStyle(color: Colors.black87, fontSize: 15),
              ),
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: getBoldStyle(color: Colors.black, fontSize: 18));
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.w,
          child: Text(
            title,
            style: getSemiBoldStyle(color: Colors.grey.shade700, fontSize: 14),
          ),
        ),

        Expanded(
          child: Text(
            value,
            style: getRegularStyle(color: Colors.black87, fontSize: 14),
          ),
        ),
      ],
    );
  }
}

String _formatDate(String? date) {
  if (date == null || date.isEmpty) return "No Next Visit";

  try {
    return DateFormat('dd MMM yyyy').format(DateTime.parse(date));
  } catch (e) {
    return date;
  }
}
