const String imagePath = "assets/images";
const String jsonPath = "assets/json";
const String iconsPath = "assets/icons";
const String svgPath = "assets/svg_images";

abstract class ImageAssets {
  static const String onboarding1 = "$imagePath/onboarding_1.png";
  static const String onboarding2 = "$imagePath/onboarding_2.png";
  static const String onboarding3 = "$imagePath/onboarding_3.png";
  static const String hospitalist = "$imagePath/Hospitalist.png";
  static const String doctor = "$imagePath/doctor.png";
  static const String patient = "$imagePath/patient.png";
  static const String drugs = "$imagePath/drugs.png";
}

class SvgAssets {}

abstract class IconsAssets {
  static const String userIcon = "$iconsPath/User_icon_Inactive.svg";
  static const String phoneIcon = "$iconsPath/Phone_icon_Inactive.svg";
  static const String emailIcon = "$iconsPath/Email_icon_Inactive.svg";
  static const String passwordIcon = "$iconsPath/Password_icon_Inactive.svg";

  static const String checkIconInactive =
      "$iconsPath/Checkbox_icon_Inactive.svg";
  static const String checkIconActive = "$iconsPath/Checkbox_active.svg";
  static const String doneIcon = "$iconsPath/Done.svg";
  static const String stethoscopeIcon = "$iconsPath/stethoscnnnnope_.svg";
}

class JsonAssets {}
