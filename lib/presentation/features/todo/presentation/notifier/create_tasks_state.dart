import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/create_task_response.dart';

class CreateTasksNotifierState {
  CreateTasksNotifierState({
    required this.createTasksState,
    required this.createTasksResponse,
  });
  factory CreateTasksNotifierState.initial() {
    return CreateTasksNotifierState(
      createTasksState: LoadState.idle,
      createTasksResponse: CreateTaskResponse(),
    );
  }

  final LoadState createTasksState;
  final CreateTaskResponse createTasksResponse;
  CreateTasksNotifierState copyWith({
    LoadState? createTasksState,
    CreateTaskResponse? createTasksResponse,
  }) {
    return CreateTasksNotifierState(
      createTasksState: createTasksState ?? this.createTasksState,
      createTasksResponse: createTasksResponse ?? this.createTasksResponse,
    );
  }
}
