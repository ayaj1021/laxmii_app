import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/ai_insights/presentation/view/ai_insights_view.dart';
import 'package:laxmii_app/presentation/features/dashboard/dashboard.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/home/presentation/widgets/expense_tax_widget.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/home/presentation/widgets/laxmi_ai_tab_widget.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/home/presentation/widgets/todo_list_widget.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/presentation/notifier/logout_notifier.dart';
import 'package:laxmii_app/presentation/features/login/presentation/login_view.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/update_task_request.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/notifier/delete_task_notifier.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/notifier/get_all_tasks_notifier.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/notifier/update_task_notifier.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/view/todo_view.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final _pageController = PageController();
  @override
  void initState() {
    getUserName();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAllTasksNotifierProvider.notifier).getAllTasks();
      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
    super.initState();
  }

  String userName = '';

  getUserName() async {
    final name = await AppDataStorage().getUserAccountName();

    setState(() {
      userName = name.toString();
    });
  }

  String getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 18) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  final List<String> aiInsights = [
    'High Expense Alert',
    'Income Insight',
    'Tax Insight',
    'Investment Insight',
  ];

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final greetingMessage = getGreetingMessage();
    ref.listen(logOutNotifer, (previous, next) {
      if (next.homeSessionState == HomeSessionState.logout) {
        context
          ..replaceNamed(LoginView.routeName)
          ..showError(
            title: 'Session ended',
            message: 'Kindly login to continue',
          );
      }
    });
    final tasksList = ref
        .watch(getAllTasksNotifierProvider
            .select((v) => v.getAllTasks.data?.tasks?.reversed))
        ?.toList();

    final taskListLoading = ref.watch(
        getAllTasksNotifierProvider.select((v) => v.loadState.isLoading));
    final isDeleteLoading = ref
        .watch(deleteTaskNotifier.select((v) => v.deleteTaskState.isLoading));
    final isUpdateLoading = ref
        .watch(deleteTaskNotifier.select((v) => v.deleteTaskState.isLoading));

    return PageLoader(
      isLoading: isUpdateLoading,
      child: PageLoader(
        isLoading: isDeleteLoading,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 42.h,
                          width: 42.w,
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.white)),
                          child: Image.asset('assets/images/user_image.png'),
                        ),
                        const HorizontalSpacing(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              greetingMessage,
                              style: context.textTheme.s12w400.copyWith(
                                color: AppColors.primary5E5E5E,
                              ),
                            ),
                            //const VerticalSpacing(3),
                            Text(
                              userName,
                              style: context.textTheme.s14w500.copyWith(
                                color: AppColors.primaryC4C4C4,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const VerticalSpacing(24),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'AI Insights',
                            style: context.textTheme.s16w500.copyWith(
                              color: AppColors.primary5E5E5E,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.pushNamed(AiInsightsView.routeName);
                            },
                            child: Text(
                              'See all',
                              style: context.textTheme.s12w500.copyWith(
                                fontSize: 14,
                                color: AppColors.primary3B3522,
                              ),
                            ),
                          ),
                        ]),
                    const VerticalSpacing(10),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.24,
                      child: PageView(
                        controller: _pageController,
                        children: List.generate(aiInsights.length, (index) {
                          final data = aiInsights[index];

                          return ExpensesTaxWidget(
                            onBackPressed: () {
                              if (_currentIndex > 0) {
                                setState(() {
                                  _currentIndex--;
                                });
                                _pageController.animateToPage(
                                  _currentIndex,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            onForwardPressed: () {
                              if (_currentIndex < aiInsights.length - 1) {
                                setState(() {
                                  _currentIndex++;
                                });
                                _pageController.animateToPage(
                                  _currentIndex,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            title: data,
                            subTitle:
                                'Your utility bills were 30% higher this month due to increased energy use',
                            controller: _pageController,
                            length: aiInsights.length,
                          );
                        }),
                      ),
                    ),
                    const VerticalSpacing(14),
                    const LaxmiAiTabWidget(),
                    const VerticalSpacing(12),
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
                    if (tasksList == null) const SizedBox.shrink(),
                    SizedBox(
                      height: 400.h,
                      // height: MediaQuery.of(context).size.height,
                      child: taskListLoading
                          ? const SizedBox.shrink()
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: (tasksList?.length ?? 0) < 2
                                  ? tasksList?.length
                                  : 2,
                              itemBuilder: (_, index) {
                                final data = tasksList?[index];
                                return Column(
                                  children: [
                                    TodoListWidget(
                                      time: '${data?.time}',
                                      todoTask: '${data?.title}',
                                      taskPriority:
                                          '${data?.priority} Priority',
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
                                    const VerticalSpacing(3)
                                  ],
                                );
                              }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
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
