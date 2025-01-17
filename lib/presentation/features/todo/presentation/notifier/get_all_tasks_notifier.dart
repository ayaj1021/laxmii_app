import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/todo/data/repository/get_all_tasks_repository.dart';
import 'package:laxmii_app/presentation/features/todo/presentation/notifier/get_all_tasks_state.dart';

class GetAllTasksNotifier extends AutoDisposeNotifier<GetAllTasksState> {
  GetAllTasksNotifier();

  late GetAllTasksRepository _getAllTasksRepository;

  @override
  GetAllTasksState build() {
    _getAllTasksRepository = ref.read(getAllTasksRepositoryProvider);

    return GetAllTasksState.initial();
  }

  Future<void> getAllTasks() async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value = await _getAllTasksRepository.getAllTasks();

      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          loadState: LoadState.idle,
          getAllTasks: AsyncResponse.success(value.data!));
    } catch (e) {
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final getAllTasksNotifierProvider =
    NotifierProvider.autoDispose<GetAllTasksNotifier, GetAllTasksState>(
        GetAllTasksNotifier.new);
