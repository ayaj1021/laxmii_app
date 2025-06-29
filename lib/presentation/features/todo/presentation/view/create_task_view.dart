import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/extensions/build_context_extension.dart';
import 'package:laxmii_app/core/extensions/overlay_extension.dart';
import 'package:laxmii_app/core/theme/app_colors.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/dashboard/dashboard.dart';
import 'package:laxmii_app/presentation/features/inventory/presentation/widgets/update_products_textfield.dart';
import 'package:laxmii_app/presentation/features/login/presentation/notifier/get_access_token_notifier.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/create_tasks_request.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/notifier/create_tasks_notifier.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/notifier/get_all_tasks_notifier.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/widgets/priority_dropdown_widget.dart';
import 'package:laxmii_app/presentation/general_widgets/app_button.dart';
import 'package:laxmii_app/presentation/general_widgets/laxmii_app_bar.dart';
import 'package:laxmii_app/presentation/general_widgets/page_loader.dart';
import 'package:laxmii_app/presentation/general_widgets/spacing.dart';

class CreateTaskView extends ConsumerStatefulWidget {
  const CreateTaskView({super.key});
  static const routeName = '/createTaskView';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends ConsumerState<CreateTaskView> {
  final ValueNotifier<bool> _isTodoEnabled = ValueNotifier(false);
  late TextEditingController _titleController;
  String? _selectedPriority;
  @override
  void initState() {
    _titleController = TextEditingController()..addListener(_validateInput);

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();

    super.dispose();
  }

  void _validateInput() {
    _isTodoEnabled.value = _titleController.text.isNotEmpty;
  }

  // DateTime? _selectedDate;

  // Future<void> _selectDate(BuildContext context) async {
  //   final now = DateTime.now();
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: _selectedDate ?? DateTime.now(),
  //     firstDate: DateTime(now.year, now.month, now.day),
  //     lastDate: DateTime(2100),
  //   );

  //   if (picked != null && picked != _selectedDate) {
  //     setState(() {
  //       _selectedDate = picked;
  //     });
  //   }
  // }

  // String _formatDate(DateTime date) {
  //   return DateFormat('MMM d, yyyy').format(date);
  // }

  // DateTime? _selectedTime;

  // Future<void> _selectTime(BuildContext context) async {
  //   final TimeOfDay now = TimeOfDay.now();
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: _selectedTime != null
  //         ? TimeOfDay(hour: _selectedTime!.hour, minute: _selectedTime!.minute)
  //         : now,
  //   );

  //   if (picked != null) {
  //     final nowDate = DateTime.now();
  //     setState(() {
  //       _selectedTime = DateTime(
  //         nowDate.year,
  //         nowDate.month,
  //         nowDate.day,
  //         picked.hour,
  //         picked.minute,
  //       );
  //     });
  //   }
  // }

  // String _formatTime(DateTime? time) {
  //   if (time == null) return "Select Time";
  //   // Use 'h:mma' to format the time without a space between hours and AM/PM
  //   return DateFormat('h:mma').format(time);
  // }

  void _onPriorityChanged(String? newValue) {
    setState(() {
      _selectedPriority = newValue; // Update the selected priority
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(createTasksNotifier.select((v) => v.createTasksState.isLoading));
    return PageLoader(
      isLoading: isLoading,
      child: Scaffold(
        appBar: const LaxmiiAppBar(
          centerTitle: true,
          title: 'New Task',
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UpdateProductsTextField(
                  product: _titleController,
                  title: 'Title',
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     GestureDetector(
                //       onTap: () => _selectDate(context),
                //       child: Container(
                //         width: 150.w,
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 10, vertical: 15),
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(8),
                //           border: Border.all(
                //             width: 1.5,
                //             color: AppColors.primary5E5E5E.withOpacity(0.5),
                //           ),
                //         ),
                //         child: Row(
                //           children: [
                //             SvgPicture.asset('assets/icons/date.svg'),
                //             const HorizontalSpacing(10),
                //             Text(
                //               _selectedDate == null
                //                   ? 'Date'
                //                   : _formatDate(_selectedDate!),
                //               style: context.textTheme.s12w400.copyWith(
                //                 color: AppColors.primary5E5E5E,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         _selectTime(context);
                //       },
                //       child: Container(
                //         width: 150.w,
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 10, vertical: 15),
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(8),
                //           border: Border.all(
                //             width: 1.5,
                //             color: AppColors.primary5E5E5E.withOpacity(0.5),
                //           ),
                //         ),
                //         child: Row(
                //           children: [
                //             SvgPicture.asset('assets/icons/time.svg'),
                //             const HorizontalSpacing(10),
                //             Text(
                //               _selectedTime == null
                //                   ? 'Time'
                //                   : _formatTime(_selectedTime!),
                //               style: context.textTheme.s12w400.copyWith(
                //                 color: AppColors.primary5E5E5E,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),

                const VerticalSpacing(10),
                TodoPriorityDropDown(
                  selectedValue: _selectedPriority,
                  onChanged: _onPriorityChanged,
                ),
                const VerticalSpacing(30),
                ValueListenableBuilder(
                    valueListenable: _isTodoEnabled,
                    builder: (context, r, c) {
                      return LaxmiiSendButton(
                          isEnabled: r,
                          //  backgroundColor: Colors.transparent,
                          hasBorder: true,
                          borderColor: AppColors.primaryColor,
                          // textColor: AppColors.primaryColor,
                          onTap: () {
                            if (_selectedPriority == null) {
                              context.showError(
                                  message: 'Priority is compulsory');
                              return;
                            } else {
                              createTask();
                            }
                          },
                          title: 'Add Task');
                    })
              ],
            ),
          ),
        )),
      ),
    );
  }

  void createTask() async {
    await ref.read(getAccessTokenNotifier.notifier).accessToken();
    final selectedTaskPeriod = _selectedPriority?.replaceAll('ly', '');
    ref.read(createTasksNotifier.notifier).createTasks(
          data: CreateTaskRequest(
            title: _titleController.text.trim(),
            priority: selectedTaskPeriod?.toLowerCase().toString() ?? '',
          ),
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) {
            ref.read(getAllTasksNotifierProvider.notifier).getAllTasks();
            context.hideOverLay();
            context.showSuccess(message: message);
            context.popUntil(ModalRoute.withName(Dashboard.routeName));
          },
        );
  }
}
