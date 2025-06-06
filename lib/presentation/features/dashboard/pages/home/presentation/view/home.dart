import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/extensions/text_theme_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/data/local_data_source/local_storage_impl.dart';
import 'package:laxmii_app/presentation/features/ai_insights/data/model/ai_insights_request.dart';
import 'package:laxmii_app/presentation/features/ai_insights/presentation/notifier/get_ai_insights_notifier.dart';
import 'package:laxmii_app/presentation/features/ai_insights/presentation/view/ai_insights_view.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/home/presentation/widgets/empty_insights_widget.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/home/presentation/widgets/expense_tax_widget.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/home/presentation/widgets/laxmi_ai_tab_widget.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/home/presentation/widgets/todo_list_section.dart';
import 'package:laxmii_app/presentation/features/dashboard/pages/settings/presentation/notifier/logout_notifier.dart';
import 'package:laxmii_app/presentation/features/login/presentation/login_view.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_user_details_notifier.dart';
import 'package:laxmii_app/presentation/features/manage_account/presentation/view/manage_account_view.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/notifier/delete_task_notifier.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/notifier/get_all_tasks_notifier.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final data = AiInsightsRequest(insightType: 'sales');
  final _pageController = PageController();
  @override
  void initState() {
    getUserName();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(getAllTasksNotifierProvider.notifier).getAllTasks();
      ref.read(getAccessTokenNotifier.notifier).accessToken();
      ref.read(getUserDetailsNotifier.notifier).getUserDetails();
      ref.read(getUserDetailsNotifier.notifier).getUserDetails();
      ref
          .read(getAiIsightsNotifierProvider.notifier)
          .getAiInsights(request: data);
    });
    super.initState();
  }

  String userName = '';
  String userImage = '';

  getUserName() async {
    final name = await AppDataStorage().getUserAccountName();
    final image = await AppDataStorage().getUserImage();

    setState(() {
      userImage = image.toString();
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

    final userDetails = ref.watch(getUserDetailsNotifier.select((v) => v.data));
    final aiInsights = ref.watch(getAiIsightsNotifierProvider
        .select((v) => v.getAiInsights.data?.aiInsights));

    Map<String, dynamic> optimizedAiInsights = (aiInsights)?.toJson() ?? {};

    return PageLoader(
      isLoading: isUpdateLoading,
      child: PageLoader(
        isLoading: isDeleteLoading,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () =>
                          context.pushNamed(ManageAccountView.routeName),
                      child: Row(
                        children: [
                          Container(
                              height: 42.h,
                              width: 42.w,
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.white)),
                              child: ClipOval(
                                child: Image(
                                  image: (userDetails
                                                  ?.profile?.profilePicture !=
                                              null &&
                                          userDetails!.profile!.profilePicture!
                                              .isNotEmpty
                                      ? CachedNetworkImageProvider(
                                          userDetails.profile!.profilePicture!)
                                      : const AssetImage(
                                          'assets/logo/laxmii_image_logo.png')),
                                  fit: BoxFit.cover,
                                ),
                              )),
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
                    (aiInsights?.insights?.isEmpty ?? true)
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: const EmptyInsightsWidget(),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: ExpensesTaxWidget(
                              aiInsights: aiInsights?.insights ?? [],
                              subTitle: optimizedAiInsights.entries
                                  .map((entry) => entry.value.join(', '))
                                  .join(' | '),
                              controller: _pageController,
                              length: aiInsights?.insights?.length,
                            )),
                    const VerticalSpacing(14),
                    const LaxmiAiTabWidget(),
                    const VerticalSpacing(12),
                    TodoListSection(
                      tasksList: tasksList,
                      taskListLoading: taskListLoading,
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
}
