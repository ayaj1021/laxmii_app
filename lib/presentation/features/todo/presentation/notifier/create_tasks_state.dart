import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/create_task_response.dart';

class CreateTasksNotifierState {
  CreateTasksNotifierState({
    required this.inputValid,
    required this.createTasksState,
    required this.createTasksResponse,
  });
  factory CreateTasksNotifierState.initial() {
    return CreateTasksNotifierState(
      inputValid: false,
      createTasksState: LoadState.idle,
      createTasksResponse: CreateTaskResponse(),
    );
  }
  final bool inputValid;
  final LoadState createTasksState;
  final CreateTaskResponse createTasksResponse;
  CreateTasksNotifierState copyWith({
    bool? inputValid,
    LoadState? createTasksState,
    CreateTaskResponse? createTasksResponse,
  }) {
    return CreateTasksNotifierState(
      inputValid: inputValid ?? this.inputValid,
      createTasksState: createTasksState ?? this.createTasksState,
      createTasksResponse: createTasksResponse ?? this.createTasksResponse,
    );
  }
}
