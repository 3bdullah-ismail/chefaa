import '../../../core/resources/assets_manager.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String description;

  const OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
  });

  static final List<OnboardingModel> onboardingData = [
    const OnboardingModel(
      image: ImageAssets.onboarding1,
      title: "Stay on Top of Your Health",
      description: "Your Health, Our Priority",
    ),
    const OnboardingModel(
      image: ImageAssets.onboarding2,
      title: "Your Doctor is Always Within Reach",
      description: "Access medical guidance anytime without complications",
    ),
    const OnboardingModel(
      image: ImageAssets.onboarding3,
      title: "Your health is Always Our Priority",
      description: "Access your medical info quickly and securely with Chefaa.",
    ),
  ];
}
