import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/widget/custom_circle_avatar.dart';

import '../../data/models/patient_detail_data.dart';
import '../../data/models/pending_upload_item.dart';
import '../../data/models/uploaded_result_item.dart';
import '../widgets/detailed_analysis_card.dart';
import '../widgets/empty_state_card_widget.dart';
import '../widgets/facility_results_upload_zone.dart';
import '../widgets/pending_upload_item_card.dart';
import '../widgets/recently_uploaded_item_card.dart';
import '../widgets/section_header_widget.dart';
import 'facility_results_dummy_data.dart';

class FacilityResultsPage extends StatefulWidget {
  const FacilityResultsPage({super.key});

  @override
  State<FacilityResultsPage> createState() => _FacilityResultsPageState();
}

class _FacilityResultsPageState extends State<FacilityResultsPage> {
  late final List<PendingUploadItem> _pendingUploads;
  late final List<UploadedResultItem> _recentlyUploaded;
  late final Map<String, PatientDetailData> _patientsDetails;
  String _selectedPatientName = "Hassan Gamal";

  @override
  void initState() {
    super.initState();
    _pendingUploads = getInitialPendingUploads();
    _recentlyUploaded = getInitialRecentlyUploaded();
    _patientsDetails = getInitialPatientDetails();
  }

  void _simulateUpload(int index) {
    if (_pendingUploads[index].isUploading) return;

    setState(() {
      _pendingUploads[index].isUploading = true;
    });

    Timer(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      final item = _pendingUploads[index];
      setState(() {
        _pendingUploads.removeAt(index);

        _recentlyUploaded.insert(
          0,
          UploadedResultItem(
            name: item.name,
            scanType: item.scanType,
            time: "Just now",
            status: "Patient notified",
            statusBgColor: ColorManager.green100,
            statusTextColor: ColorManager.green600,
            icon: Icons.picture_as_pdf_outlined,
            iconColor: item.avatarTextColor,
            iconBgColor: item.avatarBgColor,
          ),
        );

        _selectedPatientName = item.name;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${item.name}'s result uploaded successfully!"),
          backgroundColor: ColorManager.lightGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  void _addNewCustomUpload(String fileName) {
    final String baseName = fileName.split('/').last.split('\\').last;
    final String patientName =
        "Patient Result (${baseName.length > 15 ? '${baseName.substring(0, 12)}...' : baseName})";

    _patientsDetails[patientName] = PatientDetailData(
      id: "#44924",
      name: patientName,
      details: "Uploaded File: $baseName",
      badges: const ["FILE UPLOADED", "REVIEW PENDING"],
      doctorNotes:
          "Result document '$baseName' has been successfully uploaded and is currently queued for doctor validation. A notification will be sent upon review completion.",
      doctorName: "System Upload",
      doctorNotesTime: "Just now",
      aiInsight:
          "Initial system scan shows document formatted correctly. Complete AI analytics will trigger once certified by medical staff.",
      aiLinkText: "Check Progress",
    );

    setState(() {
      _recentlyUploaded.insert(
        0,
        const UploadedResultItem(
          name: "New Upload",
          scanType: "Patient Document",
          time: "Just now",
          status: "Pending review",
          statusBgColor: ColorManager.amber100,
          statusTextColor: ColorManager.amber600,
          icon: Icons.insert_drive_file_outlined,
          iconColor: ColorManager.amber600,
          iconBgColor: ColorManager.amber50,
        ),
      );

      _patientsDetails["New Upload"] = _patientsDetails[patientName]!;
      _selectedPatientName = "New Upload";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("File '$baseName' uploaded successfully!"),
        backgroundColor: ColorManager.lightGreen,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentDetail =
        _patientsDetails[_selectedPatientName] ??
        _patientsDetails["Hassan Gamal"]!;

    return Scaffold(
      backgroundColor: ColorManager.lightGray,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: ColorManager.primary,
            size: FontSize.s24.sp,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Results",
              style: getBoldStyle(
                color: ColorManager.slate900,
                fontSize: FontSize.s18.sp,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              "Upload & manage patient results",
              style: getRegularStyle(
                color: ColorManager.gray,
                fontSize: FontSize.s11.sp,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppPadding.p16.w),
            child: CustomCircleAvatar(
              imagePath: ImageAssets.doctor,
              radius: AppRadius.r18.r,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(AppSize.s1.h),
          child: Container(
            color: ColorManager.input.withValues(alpha: 0.5),
            height: AppSize.s1.h,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeaderWidget(
                  title: "Pending Upload",
                  badgeText: _pendingUploads.isNotEmpty
                      ? "${_pendingUploads.length} Urgent"
                      : null,
                  badgeColor: ColorManager.lightRed,
                  badgeTextColor: ColorManager.red600,
                ),
                SizedBox(height: AppSize.s12.h),
                if (_pendingUploads.isEmpty)
                  const EmptyStateCardWidget(
                    message: "No pending uploads at the moment.",
                  )
                else
                  ...List.generate(
                    _pendingUploads.length,
                    (index) => PendingUploadItemCard(
                      item: _pendingUploads[index],
                      onUpload: () => _simulateUpload(index),
                    ),
                  ),

                SizedBox(height: 24.h),

                FacilityResultsUploadZone(
                  onSelectFile: () {},
                  onCamera: () => _addNewCustomUpload("camera_capture.png"),
                ),

                SizedBox(height: 24.h),

                const SectionHeaderWidget(title: "Recently Uploaded"),
                SizedBox(height: AppSize.s12.h),
                ..._recentlyUploaded.map(
                  (item) => RecentlyUploadedItemCard(
                    item: item,
                    isSelected: _selectedPatientName == item.name,
                    onTap: () {
                      setState(() {
                        _selectedPatientName = item.name;
                      });
                    },
                  ),
                ),

                SizedBox(height: 24.h),

                const SectionHeaderWidget(title: "Detailed Analysis"),
                SizedBox(height: AppSize.s12.h),
                DetailedAnalysisCard(detail: currentDetail),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
