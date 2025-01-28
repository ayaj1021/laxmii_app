import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/exception/message_exception.dart';
import 'package:laxmii_app/core/config/network_utils/async_response.dart';
import 'package:laxmii_app/core/utils/enums.dart';
import 'package:laxmii_app/presentation/features/generate_report/data/repository/get_all_reports_repository.dart';
import 'package:laxmii_app/presentation/features/generate_report/presentation/notifier/get_all_reports_state.dart';

class GetAllReportsNotifier extends AutoDisposeNotifier<GetAllReportsState> {
  GetAllReportsNotifier();

  late GetAllReportsRepository _getAllReportsRepository;

  @override
  GetAllReportsState build() {
    _getAllReportsRepository = ref.read(getAllReportsRepositoryProvider);

    return GetAllReportsState.initial();
  }

  Future<void> getAllReports() async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value = await _getAllReportsRepository.getAllReports();

      if (!value.status) throw value.message.toException;

      state = state.copyWith(
          loadState: LoadState.idle,
          getAllReports: AsyncResponse.success(value.data!));
    } catch (e) {
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final getAllReportsNotifierProvider =
    NotifierProvider.autoDispose<GetAllReportsNotifier, GetAllReportsState>(
        GetAllReportsNotifier.new);
