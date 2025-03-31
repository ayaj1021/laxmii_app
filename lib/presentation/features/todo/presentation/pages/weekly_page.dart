import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/home/presentation/widgets/todo_list_widget.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/update_task_request.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/notifier/delete_task_notifier.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/notifier/get_all_tasks_notifier.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/notifier/update_task_notifier.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/view/todo_view.dart';
import 'package:laxmii_app/presentation/general_widgets/empty_page.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class WeeklyPage extends ConsumerStatefulWidget {
  const WeeklyPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeeklyPageState();
}

class _WeeklyPageState extends ConsumerState<WeeklyPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAllTasksNotifierProvider.notifier).getAllTasks();

      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tasks =
        ref.watch(getAllTasksNotifierProvider.select((v) => v.getAllTasks));

    final tasksList =
        tasks.data?.tasks?.where((task) => task.priority == 'week').toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          tasksList == null
              ? const SizedBox.shrink()
              : tasksList.isEmpty
                  ? const EmptyPage(
                      emptyMessage: 'No Tasks Yet',
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: tasksList.length,
                          itemBuilder: (_, index) {
                            final data = tasksList[index];
                            return Column(
                              children: [
                                GestureDetector(
                                  child: TodoListWidget(
                                    time: '${data.time}',
                                    todoTask: '${data.title}',
                                    taskPriority: '${data.priority}ly priority',
                                    taskPriorityColor: AppColors.primary5E5E5E,
                                    // taskPriorityColor:
                                    //     data?.priority == 'Low'
                                    //         ? AppColors.primaryF94D4D
                                    //         : AppColors.primary5E5E5E,
                                    onDeleteTapped: () =>
                                        deleteTask(taskId: '${data.id}'),
                                    onMarkCompletedTapped: () => updateTask(
                                        taskId: '${data.id}',
                                        priority: '${data.priority}',
                                        completed: true),
                                    isCompleted: data.completed,
                                  ),
                                ),
                                const VerticalSpacing(15)
                              ],
                            );
                          }),
                    )
        ],
      ),
    );
  }

  void deleteTask({required String taskId}) async {
    await ref.read(getAccessTokenNotifier.notifier).accessToken();
    ref.read(deleteTaskNotifier.notifier).deletetask(
          taskId: taskId,
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) {
            context.hideOverLay();
            context.showSuccess(message: message);
            context.popAndPushNamed(TodoView.routeName);
          },
        );
  }

  void updateTask(
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
            context.popAndPushNamed(TodoView.routeName);
          },
        );
  }
}
