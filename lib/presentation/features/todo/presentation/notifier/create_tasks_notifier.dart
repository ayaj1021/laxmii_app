import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/logger.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/create_tasks_request.dart';
import 'package:laxmii_app/presentation/features/todo/data/repository/create_task_repository.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/notifier/create_tasks_state.dart';

class CreateTasksNotifier
    extends AutoDisposeNotifier<CreateTasksNotifierState> {
  CreateTasksNotifier();

  late CreateTaskRepository _createTasksRepository;

  @override
  CreateTasksNotifierState build() {
    _createTasksRepository = ref.read(createTasksRepositoryProvider);

    return CreateTasksNotifierState.initial();
  }

  Future<void> createTasks({
    required CreateTaskRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(createTasksState: LoadState.loading);

    try {
      final value = await _createTasksRepository.createTasks(data);
      debugLog(data);
      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          createTasksState: LoadState.idle, createTasksResponse: value.data);
      onSuccess(value.data!.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(createTasksState: LoadState.idle);
    }
  }
}

final createTasksNotifier =
    NotifierProvider.autoDispose<CreateTasksNotifier, CreateTasksNotifierState>(
  CreateTasksNotifier.new,
);
