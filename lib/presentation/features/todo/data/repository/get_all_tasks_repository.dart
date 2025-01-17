import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laxmii_app/core/config/base_response/base_response.dart';
import 'package:laxmii_app/core/config/exception/app_exception.dart';
import 'package:laxmii_app/data/remote_data_source/rest_client.dart';
import 'package:laxmii_app/presentation/features/todo/data/model/get_all_tasks_response.dart';

class GetAllTasksRepository {
  GetAllTasksRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<GetAllTasksResponse>> getAllTasks() async {
    try {
      final res = await _restClient.getAllTasks();
      return BaseResponse(status: true, data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getAllTasksRepositoryProvider = Provider<GetAllTasksRepository>(
  (ref) => GetAllTasksRepository(
    ref.read(restClientProvider),
  ),
);
