import 'package:flutter/material.dart';
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
        // color: colorScheme.cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: PinCodeTextField(
          appContext: context,
          backgroundColor: Colors.transparent,
          length: 4,
          controller: otpController,
          keyboardType: TextInputType.number, // Disable system keyboard
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(13),
            // fieldHeight: 50,
            fieldWidth: 45,
            activeFillColor: colorScheme.cardColor,
            selectedFillColor: colorScheme.cardColor,
            inactiveFillColor: Colors.grey[200]!,
            activeColor: colorScheme.cardColor,
            selectedColor: colorScheme.cardColor,
            inactiveColor: colorScheme.cardColor,
          ),
          onChanged: (value) {},

          onCompleted: onCompleted,
        ),
      ),
    );
  }
}
