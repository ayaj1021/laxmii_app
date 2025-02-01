import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laxmii_app/core/extensions/string_extensions.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget(
      {super.key,
      required this.time,
      required this.todoTask,
      required this.taskPriority,
      required this.isCompleted,
      this.taskPriorityColor,
      this.onDeleteTapped,
      this.onMarkCompletedTapped});
  final String time;
  final String todoTask;
  final String taskPriority;
  final Color? taskPriorityColor;
  final bool? isCompleted;
  final Function()? onDeleteTapped;
  final Function()? onMarkCompletedTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primary101010.withValues(alpha: 0.6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                todoTask.capitalize,
                style: context.textTheme.s14w500.copyWith(
                  color: AppColors.primaryC4C4C4,
                ),
              ),
              // Text(
              //   time,
              //   style: context.textTheme.s12w300.copyWith(
              //     color: AppColors.primary5E5E5E,
              //   ),
              // ),
              const VerticalSpacing(5),
              Text(
                '',
                style: context.textTheme.s14w500.copyWith(
                  color: AppColors.primaryC4C4C4,
                ),
              ),
              const VerticalSpacing(10),
              isCompleted == true
                  ? Text(
                      'Completed',
                      style: context.textTheme.s12w400.copyWith(
                        color: AppColors.primary3B3522,
                      ),
                    )
                  : SizedBox(
                      height: 26.h,
                      width: 136.w,
                      child: GestureDetector(
                        onTap: onMarkCompletedTapped,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.primary3B3522,
                            ),
                          ),
                          child: Text(
                            'Mark as completed',
                            style: context.textTheme.s12w400.copyWith(
                              color: AppColors.primary3B3522,
                            ),
                          ),
                        ),
                      )

                      // LaxmiiOutlineSendButton(
                      //     backgroundColor: Colors.transparent,
                      //     hasBorder: true,

                      //     borderColor: AppColors.primary3B3522,
                      //     textColor: AppColors.primary3B3522,
                      //     onTap: () {},
                      //     title: 'Mark as completed'),
                      ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              isCompleted == true
                  ? const SizedBox.shrink()
                  : Text(
                      taskPriority.capitalize,
                      style: context.textTheme.s12w300.copyWith(
                        color: taskPriorityColor,
                      ),
                    ),
              const VerticalSpacing(5),
              Text(
                '',
                style: context.textTheme.s14w500.copyWith(
                  color: const Color.fromARGB(255, 235, 102, 102),
                ),
              ),
              const VerticalSpacing(10),
              // isCompleted == true
              //     ? const SizedBox.shrink()
              //     :
              GestureDetector(
                onTap: onDeleteTapped,
                child: const Icon(
                  Icons.delete_outline,
                  color: AppColors.primary3B3522,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
