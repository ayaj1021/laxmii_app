import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/todo/data/repository/delete_task_repository.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/notifier/delete_task_state.dart';

class DeleteTaskNotifier extends AutoDisposeNotifier<DeleteTaskNotifierState> {
  DeleteTaskNotifier();

  late DeleteTaskRepository _deleteTaskRepository;

  @override
  DeleteTaskNotifierState build() {
    _deleteTaskRepository = ref.read(deleteTaskRepositoryProvider);

    return DeleteTaskNotifierState.initial();
  }

  Future<void> deletetask({
    required String taskId,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(deleteTaskState: LoadState.loading);

    try {
      final value = await _deleteTaskRepository.deleteTask(taskId: taskId);
      debugLog(taskId);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(deleteTaskState: LoadState.idle);
      onSuccess(value.data!.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(deleteTaskState: LoadState.idle);
    }
  }
}

final deleteTaskNotifier =
    NotifierProvider.autoDispose<DeleteTaskNotifier, DeleteTaskNotifierState>(
  DeleteTaskNotifier.new,
);
