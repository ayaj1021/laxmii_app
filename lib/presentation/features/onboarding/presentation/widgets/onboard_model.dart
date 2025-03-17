class OnboardModel {
  final String text;
  final String image;

  OnboardModel({required this.text, required this.image});
}

final List<OnboardModel> onboardPages = [
  OnboardModel(
      text: 'Record sales and expenses easily',
      image: 'assets/images/onboard_image_one.png'),
  OnboardModel(
      text: 'Tax Calculator and Optimization',
      image: 'assets/images/onboard_image_two.png'),
  OnboardModel(
      text: 'Mileage Tracker for Tax Refund',
      image: 'assets/images/onboard_image_three.png'),
  OnboardModel(
      text: 'Personalized AI Financial Insights',
      image: 'assets/images/onboard_image_four.png'),
];
