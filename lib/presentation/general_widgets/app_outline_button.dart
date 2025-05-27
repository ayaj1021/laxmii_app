import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class LaxmiiOutlineSendButton extends StatefulWidget {
  const LaxmiiOutlineSendButton({
    required this.onTap,
    required this.title,
    super.key,
    this.isEnabled = true,
    this.backgroundColor,
    this.textColor = AppColors.primaryColor,
    this.hasBorder = false,
    this.isLoading = false,
    this.width = double.infinity,
    this.borderColor = AppColors.primaryColor,
    this.icon,
  });

  final bool isEnabled;
  final Color? backgroundColor;
  final Color textColor;
  final Color borderColor;
  final bool hasBorder;
  final String title;
  final String? icon;
  final void Function() onTap;
  final bool isLoading;
  final double width;

  @override
  State<LaxmiiOutlineSendButton> createState() =>
      _LaxmiiOutlineSendButtonState();
}

class _LaxmiiOutlineSendButtonState extends State<LaxmiiOutlineSendButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isEnabled ? widget.onTap : null,
      child: Container(
        width: widget.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: widget.isEnabled
                ? widget.backgroundColor
                : AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(16),
            border:
                Border.fromBorderSide(BorderSide(color: widget.borderColor))),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon != null
                  ? SvgPicture.asset(widget.icon.toString())
                  : const SizedBox.shrink(),
              const HorizontalSpacing(5),
              Text(
                widget.title,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
