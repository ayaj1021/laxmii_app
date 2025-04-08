import 'package:flutter/material.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class LaxmiiSendButton extends StatefulWidget {
  const LaxmiiSendButton({
    required this.onTap,
    required this.title,
    super.key,
    this.isEnabled = true,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor,
    this.hasBorder = false,
    this.width = double.infinity,
    this.borderColor = AppColors.primary1D1446,
    this.icon,
  });

  final bool isEnabled;
  final Color backgroundColor;
  final Color? textColor;
  final Color borderColor;
  final bool hasBorder;
  final String title;
  final Widget? icon;
  final void Function() onTap;

  final double width;

  @override
  State<LaxmiiSendButton> createState() => _LaxmiiSendButtonState();
}

class _LaxmiiSendButtonState extends State<LaxmiiSendButton> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: colorScheme.canvasColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (widget.icon != null) const HorizontalSpacing(8),
                widget.icon ?? const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
