const String imagePath = "assets/images";
const String jsonPath = "assets/json";
const String iconsPath = "assets/icons";
const String svgPath = "assets/svg_images";

abstract class ImageAssets {
  static const String authLogo = "$imagePath/auth_logo.png";
  static const String onboarding1 = "$imagePath/Image.png";
  static const String onboarding2 = "$imagePath/Image3.png";
  static const String onboarding3 = "$imagePath/Image2.png";
  static const String logout = "$imagePath/Question.png";
}

class SvgAssets {
  static const String homeIcon = "$svgPath/home.svg";
  static const String searchIcon = "$svgPath/search.svg";
  static const String favouriteIcon = "$svgPath/love.svg";
  static const String profileIcon = "$svgPath/person.svg";
  static const String editIcon = "$svgPath/Icon - Edit.svg";
}

abstract class IconsAssets {
  static const String icGoogle = "$iconsPath/google_icon.svg";
  static const String icFacebook = "$iconsPath/facebook_icon.svg";
  static const String icApple = "$iconsPath/apple_icon.svg";
  static const String icSearch = "$iconsPath/search_Icon.svg";
  static const String icLove = "$iconsPath/heart.svg";
}

class JsonAssets {}
