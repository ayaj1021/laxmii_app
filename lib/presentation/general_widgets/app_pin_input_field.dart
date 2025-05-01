import 'package:flutter/material.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AppPinInputField extends StatelessWidget {
  const AppPinInputField(
      {super.key, required this.otpController, this.onCompleted});
  final TextEditingController otpController;
  final Function(String)? onCompleted;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: colorScheme.cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: PinCodeTextField(
          appContext: context,
          length: 4,
          controller: otpController,
          keyboardType: TextInputType.number, // Disable system keyboard
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(13),
            // fieldHeight: 50,
            fieldWidth: 45,
            activeFillColor: Colors.white,
            selectedFillColor: Colors.white,
            inactiveFillColor: Colors.grey[200]!,
            activeColor: Colors.black,
            selectedColor: Colors.black,
            inactiveColor: AppColors.black,
          ),
          onChanged: (value) {},

          onCompleted: onCompleted,
        ),
      ),
    );
  }
}
