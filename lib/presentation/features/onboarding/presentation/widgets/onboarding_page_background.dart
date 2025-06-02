import 'package:flutter/material.dart';

class OnboardingPageBackground extends StatelessWidget {
  const OnboardingPageBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.asset('assets/images/blur_image_one.png'),
        Image.asset('assets/images/blur_image_two.png'),
        Image.asset('assets/images/blur_image_three.png'),
      ],
    );
  }
}
