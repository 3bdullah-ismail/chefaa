import 'package:flutter/material.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import '../../data/models/patient_detail_data.dart';
import '../../data/models/pending_upload_item.dart';
import '../../data/models/uploaded_result_item.dart';

List<PendingUploadItem> getInitialPendingUploads() => [
      PendingUploadItem(
        name: "Sarah Richardson",
        scanType: "Full Blood Count",
        initials: "SR",
        avatarBgColor: ColorManager.lightBlue100,
        avatarTextColor: ColorManager.blue600,
      ),
      PendingUploadItem(
        name: "Kevin Mitchell",
        scanType: "Lipid Profile",
        initials: "KM",
        avatarBgColor: ColorManager.green100,
        avatarTextColor: ColorManager.green600,
      ),
    ];

List<UploadedResultItem> getInitialRecentlyUploaded() => [
      const UploadedResultItem(
        name: "Hassan Gamal",
        scanType: "Chest X-Ray",
        time: "2 hours ago",
        status: "Patient notified",
        statusBgColor: ColorManager.mint100,
        statusTextColor: ColorManager.mint600,
        icon: Icons.picture_as_pdf_outlined,
        iconColor: ColorManager.blue600,
        iconBgColor: ColorManager.lightBlue100,
      ),
      const UploadedResultItem(
        name: "Dina Farouk",
        scanType: "Blood Glucose",
        time: "5 hours ago",
        status: "Doctor shared",
        statusBgColor: ColorManager.purple100,
        statusTextColor: ColorManager.purple700,
        icon: Icons.image_outlined,
        iconColor: ColorManager.purple600,
        iconBgColor: ColorManager.purple50,
      ),
    ];

Map<String, PatientDetailData> getInitialPatientDetails() => {
      "Hassan Gamal": const PatientDetailData(
        id: "#44920",
        name: "Hassan Gamal",
        details: "Male, 42 yrs",
        badges: ["CHRONIC CARE", "URGENT REVIEW"],
        doctorNotes:
            "Patient shows elevated glucose levels (142 mg/dL). Recommended immediate consultation for insulin adjustment. Lungs appear clear in radiographic imaging, no signs of acute infection observed.",
        doctorName: "Dr. Aris Thorne",
        doctorNotesTime: "Oct 24, 10:45 AM",
        aiInsight:
            "Based on the elevated glucose levels, we've identified 3 pharmacies within 2km that carry your prescribed metformin brand.",
        aiLinkText: "View Pharmacies",
      ),
      "Dina Farouk": const PatientDetailData(
        id: "#44921",
        name: "Dina Farouk",
        details: "Female, 38 yrs",
        badges: ["DIABETES", "ROUTINE CHECK"],
        doctorNotes:
            "Patient's HbA1c level is 7.2% (elevated). Recommend continuing current metformin dosage and scheduling a follow-up in 3 months. Heart rate and blood pressure are within normal limits.",
        doctorName: "Dr. Sarah Jenkins",
        doctorNotesTime: "Oct 24, 08:30 AM",
        aiInsight:
            "Based on the HbA1c levels, we've identified 2 dietary wellness clinics within 5km specialized in diabetes management plans.",
        aiLinkText: "View Clinics",
      ),
      "Sarah Richardson": const PatientDetailData(
        id: "#44922",
        name: "Sarah Richardson",
        details: "Female, 29 yrs",
        badges: ["HEMATOLOGY", "ROUTINE"],
        doctorNotes:
            "Complete Blood Count shows normal hemoglobin (13.5 g/dL) and white blood cell count. Platelets are within normal limits. No immediate follow-up required.",
        doctorName: "Dr. Robert Vance",
        doctorNotesTime: "Oct 24, 11:15 AM",
        aiInsight:
            "All parameters are within reference range. We recommend maintaining a balanced diet rich in iron and repeating this test in 12 months.",
        aiLinkText: "View Insights",
      ),
      "Kevin Mitchell": const PatientDetailData(
        id: "#44923",
        name: "Kevin Mitchell",
        details: "Male, 51 yrs",
        badges: ["CARDIO", "URGENT REVIEW"],
        doctorNotes:
            "Lipid Profile reveals elevated LDL cholesterol (160 mg/dL) and borderline total cholesterol. Recommend low-fat diet, daily cardiovascular exercise, and retesting in 8 weeks.",
        doctorName: "Dr. Emily Howard",
        doctorNotesTime: "Oct 24, 11:30 AM",
        aiInsight:
            "Based on LDL cholesterol levels, we've identified 4 cardiologists and 2 nutritionists in Maadi specialized in lipid management.",
        aiLinkText: "View Doctors",
      ),
    };
