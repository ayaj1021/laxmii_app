import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class LaxmiiEmailField extends StatefulWidget {
  const LaxmiiEmailField({
    super.key,
    this.textStyle,
    this.width,
    this.labelSpace = 3,
    this.textCapitalization = TextCapitalization.sentences,
    this.onTap,
    this.decoration,
    this.hintStyle,
    this.backgroundColor,
    this.isLoading = false,
    this.readOnly = false,
    this.customLabel,
    this.hintText,
    this.controller,
    this.minLines = 1,
    this.obscureText = false,
    this.enabled = true,
    this.validateFunction,
    this.borderSide = BorderSide.none,
    this.onSaved,
    this.onChange,
    this.textInputAction,
    this.focusNode,
    this.nextFocusNode,
    this.submitAction,
    this.enableErrorMessage = true,
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.prefixIcon,
    this.bordercolor,
    this.autofocus,
    this.label,
    this.inputFormatters,
    this.borderRadius = 5,
    this.initialValue,
    this.labelSize,
    this.labelColor,
    this.errorMessage,
    this.bottomLabel,
    this.prefix,
  });
  final double? width;
  final double? labelSize;
  final String? hintText;
  final TextEditingController? controller;
  final int? minLines;
  final int? maxLines;
  final bool? obscureText;
  final bool? enabled;
  final FormFieldValidator<String>? validateFunction;
  final void Function(String)? onSaved;
  final void Function(String)? onChange;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final VoidCallback? submitAction;
  final bool? enableErrorMessage;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? bordercolor;
  final Color? backgroundColor;
  final Color? labelColor;
  final bool? autofocus;
  final String? label;
  final InputDecoration? decoration;
  final List<TextInputFormatter>? inputFormatters;
  final bool isLoading;
  final bool readOnly;
  final double borderRadius;
  final double labelSpace;
  final String? initialValue;
  final Widget? customLabel;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final BorderSide borderSide;

  final TextCapitalization textCapitalization;
  final String? errorMessage;
  final Widget? bottomLabel;
  final Widget? prefix;

  @override
  State<LaxmiiEmailField> createState() => _LaxmiiEmailFieldState();
}

class _LaxmiiEmailFieldState extends State<LaxmiiEmailField> {
  String? error;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      // height: 50.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primary212121)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/email.svg',
                fit: BoxFit.scaleDown,
              ),
              const HorizontalSpacing(5),
              Expanded(
                child: TextFormField(
                  key: widget.key,
                  textCapitalization: widget.textCapitalization,
                  onTap: widget.onTap,
                  readOnly: widget.readOnly,
                  initialValue: widget.initialValue,
                  textAlign: TextAlign.left,
                  inputFormatters: widget.inputFormatters,
                  autofocus: widget.autofocus ?? false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  enabled: widget.enabled,
                  validator: widget.validateFunction,
                  onSaved: (val) {
                    error = widget.validateFunction!(val);
                    setState(() {});
                    widget.onSaved?.call(val!);
                  },
                  onChanged: (val) {
                    widget.validateFunction != null
                        ? error = widget.validateFunction!(val)
                        : error = null;
                    setState(() {});
                    if (widget.onChange != null) widget.onChange!.call(val);
                  },
                  style: widget.textStyle ??
                      TextStyle(
                        color: colorScheme.colorScheme.onSurface,
                        fontSize: 14.sp,
                      ),
                  cursorColor: AppColors.primaryColor,
                  maxLines: widget.maxLines,
                  controller: widget.controller,
                  obscureText: widget.obscureText!,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: widget.textInputAction,
                  focusNode: widget.focusNode,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  decoration: widget.decoration ??
                      InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: widget.backgroundColor,
                        // prefixIcon: SvgPicture.asset(
                        //   'assets/icons/email.svg',
                        //   fit: BoxFit.scaleDown,
                        // ),
                        prefix: widget.prefix,
                        suffixIcon: widget.suffixIcon,
                        enabled: false,
                        hintText: widget.hintText,
                        hintStyle: widget.hintStyle,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              if (error != null || widget.errorMessage != null) ...[
                const VerticalSpacing(25),
                Text(
                  widget.errorMessage ?? error!,
                  style: const TextStyle(
                    color: AppColors.red,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
