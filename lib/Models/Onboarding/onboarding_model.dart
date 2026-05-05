class OnboardingModel {
  final String image;
  final String phase;
  final String title;
  final String description;
  final String? text;
  final String text1;

  OnboardingModel({
    required this.image,
    required this.phase,
    required this.title,
    required this.description,
    this.text,
    required this.text1,
  });
}