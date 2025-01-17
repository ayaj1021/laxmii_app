import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/update_task_request.dart';
import 'package:laxmii_app/presentation/features/todo/data/repository/update_task_repository.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/notifier/update_task_state.dart';

class UpdateTaskNotifier extends AutoDisposeNotifier<UpdateTaskNotifierState> {
  UpdateTaskNotifier();

  late UpdateTaskRepository _updateTasksRepository;

  @override
  UpdateTaskNotifierState build() {
    _updateTasksRepository = ref.read(updateTaskRepositoryProvider);

    return UpdateTaskNotifierState.initial();
  }

  Future<void> updateTask({
    required UpdateTaskRequest data,
    required String taskId,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(updateTaskState: LoadState.loading);

    try {
      final value =
          await _updateTasksRepository.updateTask(data, taskId: taskId);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          updateTaskState: LoadState.idle, updateTaskResponse: value.data);
      onSuccess(value.data!.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(updateTaskState: LoadState.idle);
    }
  }
}

final updateTaskNotifier =
    NotifierProvider.autoDispose<UpdateTaskNotifier, UpdateTaskNotifierState>(
  UpdateTaskNotifier.new,
);
