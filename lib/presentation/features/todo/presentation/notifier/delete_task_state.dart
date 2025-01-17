import 'package:laxmii_app/core/utils/enums.dart';

class DeleteTaskNotifierState {
  DeleteTaskNotifierState({
    required this.inputValid,
    required this.deleteTaskState,
  });
  factory DeleteTaskNotifierState.initial() {
    return DeleteTaskNotifierState(
      inputValid: false,
      deleteTaskState: LoadState.idle,
    );
  }
  final bool inputValid;
  final LoadState deleteTaskState;
  DeleteTaskNotifierState copyWith({
    bool? inputValid,
    LoadState? deleteTaskState,
  }) {
    return DeleteTaskNotifierState(
      inputValid: inputValid ?? this.inputValid,
      deleteTaskState: deleteTaskState ?? this.deleteTaskState,
    );
  }
}
