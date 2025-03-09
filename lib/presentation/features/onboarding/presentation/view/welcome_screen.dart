import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static const String routeName = '/welcomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Column(
          //   children: [
          //     Container(
          //       height: 200.h,
          //       width: 200.w,
          //       decoration: const BoxDecoration(
          //           color: AppColors.white,
          //           shape: BoxShape.circle,
          //           boxShadow: [
          //             BoxShadow(blurRadius: 2, blurStyle: BlurStyle.inner)
          //           ]),
          //     )
          //   ],
          // ),

          Column(
            children: [
              Image.asset('assets/images/blur_image_one.png'),
              Image.asset('assets/images/blur_image_two.png'),
              Image.asset('assets/images/blur_image_three.png'),
            ],
          ),
          const Column(
            children: [],
          ),
        ],
      ),
    );
  }
}
