import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/get_all_tasks_response.dart';

class GetAllTasksState {
  final LoadState loadState;
  final AsyncResponse<GetAllTasksResponse> getAllTasks;

  GetAllTasksState({
    required this.loadState,
    required this.getAllTasks,
  });

  factory GetAllTasksState.initial() {
    return GetAllTasksState(
      loadState: LoadState.loading,
      getAllTasks: AsyncResponse.loading(),
    );
  }

  GetAllTasksState copyWith({
    LoadState? loadState,
    AsyncResponse<GetAllTasksResponse>? getAllTasks,
  }) {
    return GetAllTasksState(
      loadState: loadState ?? this.loadState,
      getAllTasks: getAllTasks ?? this.getAllTasks,
    );
  }
}
