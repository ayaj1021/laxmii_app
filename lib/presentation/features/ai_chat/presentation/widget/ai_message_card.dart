import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class AiMessageCard extends StatefulWidget {
  const AiMessageCard({
    super.key,
    required this.message,
    required this.type,
    this.isLoading = false,
    this.onCopyTapped,
    this.onLikeTapped,
    this.isDisliked = false,
    this.onDislikeTapped,
  });
  final String message;
  final String type;
  final bool isLoading;
  final bool isDisliked;

  final Function()? onCopyTapped;
  final Function()? onLikeTapped;
  final Function()? onDislikeTapped;

  @override
  State<AiMessageCard> createState() => _AiMessageCardState();
}

class _AiMessageCardState extends State<AiMessageCard> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 18.h,
                width: 21.w,
                child: Image.asset('assets/logo/laxmii_logo.png'),
              ),
              const HorizontalSpacing(20),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 10,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                      color: colorScheme.unselectedWidgetColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  child: Column(
                    children: [
                      Text(
                        widget.message,
                        style: context.textTheme.s14w400.copyWith(
                          color: colorScheme.colorScheme.tertiary,
                        ),
                      ),
                      const VerticalSpacing(10),
                      Row(children: [
                        GestureDetector(
                          onTap: widget.onCopyTapped,
                          child: SvgPicture.asset(
                            'assets/icons/copy.svg',
                            colorFilter: ColorFilter.mode(
                                colorScheme.iconTheme.color ??
                                    Colors.transparent,
                                BlendMode.srcIn),
                          ),
                        ),
                        const HorizontalSpacing(15),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isLiked = !isLiked;
                            });
                            widget.onLikeTapped?.call();
                          },
                          child: isLiked
                              ? const Icon(Icons.thumb_up_alt)
                              : SvgPicture.asset(
                                  'assets/icons/thumbs_up.svg',
                                  colorFilter: ColorFilter.mode(
                                      colorScheme.iconTheme.color ??
                                          Colors.transparent,
                                      BlendMode.srcIn),
                                ),
                        ),
                        const HorizontalSpacing(15),
                        if (!widget.isDisliked)
                          GestureDetector(
                            onTap: widget.isDisliked
                                ? null
                                : widget.onDislikeTapped,
                            child: SvgPicture.asset(
                              'assets/icons/thumbs_down.svg',
                              colorFilter: ColorFilter.mode(
                                  colorScheme.iconTheme.color ??
                                      Colors.transparent,
                                  BlendMode.srcIn),
                            ),
                          ),
                      ])
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const VerticalSpacing(15),
      ],
    );
  }
}
