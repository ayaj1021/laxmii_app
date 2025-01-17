import 'package:flutter/material.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';

class LaxmiiSendButton extends StatefulWidget {
  const LaxmiiSendButton({
    required this.onTap,
    required this.title,
    super.key,
    this.isEnabled = true,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor = Colors.white,
    this.hasBorder = false,
    this.width = double.infinity,
    this.borderColor = AppColors.primary1D1446,
  });

  final bool isEnabled;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final bool hasBorder;
  final String title;
  final void Function() onTap;

  final double width;

  @override
  State<LaxmiiSendButton> createState() => _LaxmiiSendButtonState();
}

class _LaxmiiSendButtonState extends State<LaxmiiSendButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: InkWell(
        onTap: widget.isEnabled ? widget.onTap : null,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: widget.isEnabled
                  ? widget.backgroundColor
                  : AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.fromBorderSide(
                widget.hasBorder
                    ? BorderSide(color: widget.borderColor)
                    : BorderSide.none,
              )),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              widget.title,
              style: TextStyle(
                color: widget.textColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
