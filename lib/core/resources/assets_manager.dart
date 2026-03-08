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
  static const String loginLogo = "$imagePath/login_logo.png";
}

class SvgAssets {
  static const String google = "$svgPath/Google.svg";
  static const String biApple = "$svgPath/bi_apple.svg";
  static const String home = "$svgPath/Home.svg";
  static const String homeActive = "$svgPath/Home_active.svg";
  static const String booking = "$svgPath/booking_inactive.svg";
  static const String bookingActive = "$svgPath/booking.svg";
  static const String chat = "$svgPath/chat.svg";
  static const String chatActive = "$svgPath/chat_active.svg";
  static const String profile = "$svgPath/profile.svg";
  static const String profileActive = "$svgPath/profile_active.svg";
  static const String aiLab = "$svgPath/ai_lab.svg";
  static const String aiLabActive = "$svgPath/ai_lab_active.svg";
}

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
