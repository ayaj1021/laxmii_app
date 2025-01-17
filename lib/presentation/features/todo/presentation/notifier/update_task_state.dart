import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/update_task_response.dart';

class UpdateTaskNotifierState {
  UpdateTaskNotifierState({
    required this.inputValid,
    required this.updateTaskState,
    required this.updateTaskResponse,
  });
  factory UpdateTaskNotifierState.initial() {
    return UpdateTaskNotifierState(
      inputValid: false,
      updateTaskState: LoadState.idle,
      updateTaskResponse: UpdateTaskResponse(),
    );
  }
  final bool inputValid;
  final LoadState updateTaskState;
  final UpdateTaskResponse updateTaskResponse;
  UpdateTaskNotifierState copyWith({
    bool? inputValid,
    LoadState? updateTaskState,
    UpdateTaskResponse? updateTaskResponse,
  }) {
    return UpdateTaskNotifierState(
      inputValid: inputValid ?? this.inputValid,
      updateTaskState: updateTaskState ?? this.updateTaskState,
      updateTaskResponse: updateTaskResponse ?? this.updateTaskResponse,
    );
  }
}
