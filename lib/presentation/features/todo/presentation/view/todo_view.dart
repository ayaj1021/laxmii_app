import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/notifier/delete_task_notifier.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/notifier/get_all_tasks_notifier.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/notifier/update_task_notifier.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/pages/monthly_page.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/pages/once_page.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/pages/weekly_page.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/pages/yearly_page.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/view/create_task_view.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class TodoView extends ConsumerStatefulWidget {
  const TodoView({super.key});
  static const routeName = '/todoView';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoViewState();
}

class _TodoViewState extends ConsumerState<TodoView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getAllTasksNotifierProvider.notifier).getAllTasks();
      await ref.read(getAccessTokenNotifier.notifier).accessToken();
    });
    super.initState();
  }

  DateTime todayDate = DateTime.now();

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
        getAllTasksNotifierProvider.select((v) => v.loadState.isLoading));
    final isDeleteLoading = ref
        .watch(deleteTaskNotifier.select((v) => v.deleteTaskState.isLoading));
    final isUpdateLoading = ref
        .watch(updateTaskNotifier.select((v) => v.updateTaskState.isLoading));

    return Scaffold(
      appBar: const LaxmiiAppBar(
        centerTitle: true,
        title: 'My Tasks',
      ),
      body: PageLoader(
        isLoading: isUpdateLoading,
        child: PageLoader(
          isLoading: isDeleteLoading,
          child: PageLoader(
            isLoading: isLoading,
            child: SafeArea(
                child: Column(
              children: [
                Text(
                  '${_formatDate(todayDate)} Today',
                  style: context.textTheme.s12w500.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const VerticalSpacing(12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: TabBar(
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerHeight: 0,
                            indicatorWeight: 0,
                            labelPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primaryColor,
                            ),
                            labelStyle: context.textTheme.s12w400
                                .copyWith(color: AppColors.white),
                            unselectedLabelStyle: context.textTheme.s12w400
                                .copyWith(color: AppColors.primary3B3522),
                            controller: _tabController,
                            tabs: const [
                              Text('Once'),
                              Text('Weekly'),
                              Text('Monthly'),
                              Text('Yearly'),
                            ]),
                      ),
                      GestureDetector(
                        onTap: () =>
                            context.pushNamed(CreateTaskView.routeName),
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.add_circle,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalSpacing(19),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      OncePage(),
                      WeeklyPage(),
                      MonthlyPage(),
                      YearlyPage(),
                    ],
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
