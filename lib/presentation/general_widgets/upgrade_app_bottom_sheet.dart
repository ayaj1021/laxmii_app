import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class UpdateAppBottomSheet extends StatelessWidget {
  const UpdateAppBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              SvgPicture.asset('assets/icons/upgrade.svg'),
              const VerticalSpacing(12),
              Text(
                'A new version of the app is ready for you!',
                style: context.textTheme.s14w400.copyWith(
                    color: colorScheme.colorScheme.onSurface,
                    fontWeight: FontWeight.w300),
              ),
              const VerticalSpacing(5),

              Text(
                'Get the latest features, performance improvements, and important bug fixes.',
                style: context.textTheme.s14w400.copyWith(
                    color: colorScheme.colorScheme.onSurface,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
              const VerticalSpacing(42),
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pop(true), // Accept update
                child: const Text('Update Now'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), // Decline update
                child: const Text('Maybe Later'),
              ),

              // Button(
              //   text: 'Update Now',
              //   isLoading: false,
              //   onTap: () {
              //     AppTools.launchPlayStore();
              //   },
              // )
            ],
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LinearCircle(
              linearColorOne: Color(0XFFF1F7FE),
              linearColorTwo: Color(0XFFFCF3E9),
            ),
            LinearCircle(
              linearColorOne: Color(0XFFF1F7FE),
              linearColorTwo: Color(0XFFFCF3E9),
            )
          ],
        ),
      ],
    );
  }
}

class LinearCircle extends StatelessWidget {
  const LinearCircle(
      {super.key, required this.linearColorOne, required this.linearColorTwo});
  final Color linearColorOne;
  final Color linearColorTwo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              linearColorOne,
              linearColorTwo,
            ],
          ),
          shape: BoxShape.circle),
    );
  }
}
