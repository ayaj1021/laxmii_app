import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/dashboard/dashboard.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/home/presentation/widgets/todo_list_widget.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/get_all_tasks_response.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/update_task_request.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/notifier/delete_task_notifier.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/notifier/update_task_notifier.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/view/todo_view.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class TodoListSection extends ConsumerStatefulWidget {
  const TodoListSection({
    super.key,
    required this.tasksList,
    required this.taskListLoading,
  });
  final List<Task>? tasksList;
  final bool taskListLoading;

  @override
  ConsumerState<TodoListSection> createState() => _TodoListSectionState();
}

class _TodoListSectionState extends ConsumerState<TodoListSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'To-do List',
              style: context.textTheme.s16w500.copyWith(
                color: AppColors.primary5E5E5E,
              ),
            ),
            GestureDetector(
              onTap: () {
                context.pushNamed(TodoView.routeName);
              },
              child: Text(
                'See all',
                style: context.textTheme.s12w500.copyWith(
                  fontSize: 14,
                  color: AppColors.primary3B3522,
                ),
              ),
            ),
          ],
        ),
        const VerticalSpacing(5),
        if (widget.tasksList == null) const SizedBox.shrink(),
        SizedBox(
          height: 400.h,
          // height: MediaQuery.of(context).size.height,
          child: widget.taskListLoading
              ? const SizedBox.shrink()
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (widget.tasksList?.length ?? 0) < 2
                      ? widget.tasksList?.length
                      : 2,
                  itemBuilder: (_, index) {
                    final data = widget.tasksList?[index];
                    return Column(
                      children: [
                        TodoListWidget(
                          time: '${data?.time}',
                          todoTask: '${data?.title}',
                          taskPriority: '${data?.priority} Priority',
                          taskPriorityColor: data?.priority == 'Low'
                              ? AppColors.primaryF94D4D
                              : AppColors.primary5E5E5E,
                          onDeleteTapped: () =>
                              deleteTask(taskId: '${data?.id}'),
                          isCompleted: data?.completed,
                          onMarkCompletedTapped: () => updateTask(
                              taskId: '${data?.id}',
                              priority: '${data?.priority}',
                              completed: data?.completed ?? false),
                        ),
                        const VerticalSpacing(16)
                      ],
                    );
                  }),
        ),
      ],
    );
  }

  deleteTask({required String taskId}) async {
    await ref.read(getAccessTokenNotifier.notifier).accessToken();
    ref.read(deleteTaskNotifier.notifier).deletetask(
          taskId: taskId,
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) {
            context.hideOverLay();
            context.showSuccess(message: message);
            context.pushReplacementNamed(Dashboard.routeName);
          },
        );
  }

  updateTask(
      {required String taskId,
      required String priority,
      required bool completed}) async {
    await ref.read(getAccessTokenNotifier.notifier).accessToken();
    final data = UpdateTaskRequest(priority: priority, completed: completed);
    ref.read(updateTaskNotifier.notifier).updateTask(
          data: data,
          taskId: taskId,
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) {
            context.hideOverLay();
            context.showSuccess(message: message);
            context.popAndPushNamed(Dashboard.routeName);
          },
        );
  }
}
