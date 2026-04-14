import 'package:chefaa/core/resources/assets_manager.dart';

import '../routes/app_routes_names.dart';

class AppConstants {
  static const String error = "Error";
  static const String success = 'Success';
  static const String firstName = "First Name";
  static const String lastName = "Last Name";
  static const String enterPhone = "Enter your phone number";
  static const String enterEmail = "Enter your email";
  static const String enterPassword = "Enter your password";
  static const String reEnterPassword = "Re-enter your password";
  static const String phoneHint = "+20  xxxxxxxx";
  static const String emailFacilityHint = "contact@facility.com";
  static const String emailPharmacyHint = "contact@pharmacy.com";
  static const String licenseHint = "e.g. LIC-676-78";
  static const String licensePdf = "My_ License.pdf";
  static const String doctor = "Doctor";
  static const String patient = "Patient";
  static const String facility = "Facility";
  static const String pharmacy = "Pharmacy";
  static const String lab = "Lab";

  static const String facilityType = "Facility Type";
  static const String facilityName = "Facility Name";
  static const String phoneNumber = "Phone Number";
  static const String workEmail = "Work Email";
  static const String password = "Password";
  static const String confirmPassword = "Confirm Password";
  static const String commercialLicenseNumber = "Commercial License Number";
  static const String medicalLicenseUpload = "Medical  license Upload";
  static const String uploadYourLicence = "Upload your licence";
  static const String uploadYourMedicalLicence = "Upload your Medical License";
  static const String createAccount = "Create Account";
  static const String submitForVerification = "Submit for Verification";
  static const String acceptTerm = "Please accept the terms and conditions";
  static final List<String> chronicDiseases = [
    "Diabetes",
    "Hypertension",
    "Heart Disease",
    "Coronary Artery Disease",
    "Heart Failure",
    "Arrhythmia",
    "Stroke",
    "Peripheral Artery Disease",
    "Cirrhosis",
    "Hyperthyroidism",
    "Hashimoto's Disease",
    "Rheumatoid Arthritis",
    "Osteoporosis",
    "Parkinson's Disease",
    "Alzheimer's Disease",
    "Multiple Sclerosis",
    "Irritable Bowel Syndrome",
    "Anxiety Disorder",
    "Bipolar Disorder",
    "Schizophrenia",
    "Prostate Cancer",
    "Colon Cancer",
    "Skin Cancer",
    "Lupus",
    "Psoriasis",
    "Celiac Disease",
    "Type 1 Diabetes",
    "Rheumatoid Arthritis",
    "Obesity",
    "High Cholesterol",
    "Metabolic Syndrome",
    "Gout",
    "HIV/AIDS",
    "Vision Problems",
    "Other",
    "None",
  ];

  static final List<String> allergies = [
    "Aspirin Allergy",
    "Paracetamol Allergy",
    "Ibuprofen Allergy",
    "Antibiotic Allergy",
    "Local Anesthetic Allergy",
    "NSAID Allergy",
    "Sulfa Drug Allergy",
    "Sesame Allergy",
    "Strawberry Allergy",
    "Fish Allergy",
    "Seafood Allergy",
    "Chemical Allergy",
    "Latex Allergy",
    "Metal Allergy",
    "Nickel Allergy",
    "Pollution Allergy",
    "MSG Sensitivity",
    "Food Coloring Allergy",
    "Preservative Allergy",
    "Exercise-Induced Allergy",
    "Pressure Allergy",
    "Vibration Allergy",
    "Lactose Intolerance",
    "Gluten Sensitivity",
    "Medication Allergy",
    "Sun Allergy",
    "Insect Allergy",
    "None",
  ];

  static String getLayoutFromRole(String? role) {
    switch (role) {
      case "doctor":
        return AppRoutesNames.doctorLayout;
      case "pharmacy":
        return AppRoutesNames.pharmacyLayout;
      case "facility":
        return AppRoutesNames.facilityLayout;
      default:
        return AppRoutesNames.patientLayout;
    }
  }

  static final List<Map<String, String>> specialityItems = [
    {
      "specialityImage":ImageAssets.general,
      "specialityName":"General"
    },
    {
      "specialityImage":ImageAssets.cardiology,
      "specialityName":"Cardiology"
    },
    {
      "specialityImage":ImageAssets.dentistry,
      "specialityName":"Dentistry"
    },
    {
      "specialityImage":ImageAssets.dermatology,
      "specialityName":"Dermatology"
    },
    {
      "specialityImage":ImageAssets.endocrinology,
      "specialityName":"Endocrinology"
    },
    {
      "specialityImage":ImageAssets.gynecologyObstetrics,
      "specialityName":"Gynecology & Obstetrics"
    },
    {
      "specialityImage":ImageAssets.internalMedicine,
      "specialityName":"InternalMedicine"
    },
    {
      "specialityImage":ImageAssets.neurology,
      "specialityName":"Neurology"
    },
    {
      "specialityImage":ImageAssets.urology,
      "specialityName":"Urology"
    },
    {
      "specialityImage":ImageAssets.ent,
      "specialityName":"ENT"
    },
    {
      "specialityImage":ImageAssets.nutrition,
      "specialityName":"Nutrition"
    },
    {
      "specialityImage":ImageAssets.pulmonology,
      "specialityName":"Pulmonology"
    },
    {
      "specialityImage":ImageAssets.orthopedics,
      "specialityName":"Orthopedics"
    },
    {
      "specialityImage":ImageAssets.ophthalmology,
      "specialityName":"Ophthalmology"
    },
  ];
}
