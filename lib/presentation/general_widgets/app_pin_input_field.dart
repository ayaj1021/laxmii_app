import 'package:flutter/material.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AppPinInputField extends StatelessWidget {
  const AppPinInputField({super.key, required this.otpController});
  final TextEditingController otpController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      width: MediaQuery.sizeOf(context).width * 0.65,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.black, width: 2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: PinCodeTextField(
          appContext: context,
          length: 4,
          controller: otpController,
          keyboardType: TextInputType.number, // Disable system keyboard
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.underline,
            // borderRadius: BorderRadius.circular(8),
            // fieldHeight: 50,
            // fieldWidth: 30,
            activeFillColor: Colors.white,
            selectedFillColor: Colors.white,
            inactiveFillColor: Colors.grey[200]!,
            activeColor: Colors.black,
            selectedColor: Colors.black,
            inactiveColor: AppColors.black,
          ),
          onChanged: (value) {},
        ),
      ),
    );
  }
}
